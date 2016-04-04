#include <StdAfx.h>
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "dpcdecl.h"
#include "depp.h"
#include "dmgr.h"int columnas = 0;

static HIF hif = hifInvalid;

static void DoPutRegRepeat() {
    
    int colImage = 1280;//porque dos pixeles están representados
    //en un decimal, por lo tanto se divide entre dos
    int rowImage = 480;//pixeles

    int data1[(colImage/2) * rowImage * 3]; //*3imagenes
    int data2[(colImage/2) * rowImage * 3]; //va a contener la 
    //mitad de la imagen
    
    BYTE data1_b[(colImage/2) * rowImage * 3]; //para pasar la info a bytes
    BYTE data2_b[(colImage/2) * rowImage * 3];
    
    FILE *f1 = fopen("imagen1.txt", "r");//imagen
    int c, j = 0, k = 0, contador = 0, aux = 0;
    //acá van a quedar los datos de la imagen

    do{//recorre todas las filas del archivo
            fscanf(f1, "%d", &c);//almacena el dato en "c"
            if(aux == colImage * rowImage) break;//forzado
            if(contador < colImage/2){
                data1[j] = (int)c;
                j++;
            }
            else{
                data2[k] = (int)c;
                k++;
            }
            contador++;
            aux++;
            if(contador == colImage) contador = 0;

    }while(feof(f1) == 0);//mientras que no sea fin de archivo
    fclose(f1);
    
    FILE *f2 = fopen("imagen2.txt", "r");//imagen
    contador = 0, aux = 0;
    //acá van a quedar los datos de la imagen

    do{//recorre todas las filas del archivo
            fscanf(f2, "%d", &c);//almacena el dato en "c"
            if(aux == colImage * rowImage) break;//forzado
            if(contador < colImage/2){
                data1[j] = (int)c;
                j++;
            }
            else{
                data2[k] = (int)c;
                k++;
            }
            contador++;
            aux++;
            if(contador == colImage) contador = 0;

    }while(feof(f2) == 0);
    fclose(f2);
    
    FILE *f3 = fopen("imagen3.txt", "r");//imagen
    contador = 0, aux = 0;
    //acá van a quedar los datos de la imagen

    do{//recorre todas las filas del archivo
            fscanf(f3, "%d", &c);//almacena el dato en "c"
            if(aux == colImage * rowImage) break;//forzado
            if(contador < colImage/2){
                data1[j] = (int)c;
                j++;
            }
            else{
                data2[k] = (int)c;
                k++;
            }
            contador++;
            aux++;
            if(contador == colImage) contador = 0;

    }while(feof(f3) == 0);
    fclose(f3);

    
    for(int i = 0; i < (colImage/2) * rowImage * 3; i++)
        data1_b[i] = (BYTE)data1[i];
    
    for(int i = 0; i < (colImage/2) * rowImage * 3; i++)
        data2_b[i] = (BYTE)data2[i];
    
    int i = 0;
    while(i < (colImage/2) * rowImage * 3)//envía todos los pixeles
    {
      if(!DeppPutReg(hif, 10, data1_b[i], fFalse)){
        printf("DeppPutRegRepeat failed.\n");
        exit(3);
      }
      i++;
      Sleep(0.1);
    }
    
    int i = 0;
    while(i < (colImage/2) * rowImage * 3)//envía todos los pixeles
    {
      if(!DeppPutReg(hif, 10, data2_b[i], fFalse)){
        printf("DeppPutRegRepeat failed.\n");
        exit(3);
      }
      i++;
      Sleep(0.1);
    }
}

int main(int cszArg, char * rgszArg[]) {
    fprintf(stderr,"Opening\n");
    if(!DmgrOpen(&hif, "Nexys2")) {  // Change to Basys2 for the other board.
        printf("DmgrOpen failed (check the device name you provided)\n");
        return 0;
    }

    fprintf(stderr,"Enabling\n");
    if(!DeppEnable(hif)) {
        printf("DeppEnable failed\n");
        return 0;
    }

    fprintf(stderr,"Outputting\n");
    DoPutRegRepeat();

    if( hif != hifInvalid ) {
        DeppDisable(hif);
        DmgrClose(hif);
    }
    return 0;
}