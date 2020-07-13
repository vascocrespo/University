#include <stdio.h>
#include <stdlib.h>
#include <string.h>	//para output
#include <pthread.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdbool.h>
#include "queues.c"

#define MemoryManager "BestFit"
char *mem[MEMSize];
int PCB_no;
char *temparray[processnumber];
char *arrayfin[processnumber][MEMSize];
int itime = 1;
int CreatedProcess=0;
char *lista[processnumber+1];

int tipo;



Queue NEW = {0,-1,0};
Queue READY = {0,-1,0};
Queue BLOCKED = {0,-1,0};
Queue RUN = {0,-1,0};
Queue EXIT = {0,-1,0};

void MemInitialize(){
	
	for(int i=0; i<MEMSize; i++){
		mem[i]="xx";
	}
}

void QueueInitialize(){
	int i = 0;
	while(i<stateSize){
		NEW.queueArray[i]=-1;
		READY.queueArray[i]=-1;
		BLOCKED.queueArray[i]=-1;
		RUN.queueArray[i]=-1;
		EXIT.queueArray[i]= -1;
		i++;	
	}
}

void printNormal(){
	printf("\nMemory = {");
	for(int x = 0; x < MEMSize; x++) {
		if (x==0)
		{
		 	printf("%s", mem[x]);
		}
		else
		{
			printf(", %s", mem[x]);
		}
	}
	printf("}\n");


	char b[3];
	sprintf(b, "%d", itime);
	lista[0] = b;
	
	printf("\n");
	for (int y = 0; y < processnumber+1; y++){
				
				printf("%s | ", lista[y]);
			}
	printf("\n");
;
	  

}

void printSimples(){
	char b[3];
	sprintf(b, "%d", itime);
	lista[0] = b;

	for(int o = 0; o < processnumber+1; o++){
		printf("%s | ", lista[o]);
	}
	printf("\n");
	printf("\n");



		
}

void zerox(int procesnumber,int variable, PCB x[processnumber]){
	mem[x[procesnumber].localizador+variable]="0";
	(x[procesnumber].programCounter)++;
	itime++; 
}

void addx(int procesnumber,int variable, PCB x[processnumber]){
	
	int a = atoi(mem[x[procesnumber].localizador+variable]);       
	a++; 
	char b[1];
	sprintf(b, "%d", a);
	mem[x[procesnumber].localizador+variable] = strdup(b) ;
	(x[procesnumber].programCounter)++;
	itime++;
}

void subx(int procesnumber,int variable, PCB x[processnumber]){
	
	int a = atoi(mem[x[procesnumber].localizador+variable]);       
	a--; 
	char b[1];
	sprintf(b, "%d", a);
	mem[x[procesnumber].localizador+variable] = strdup(b) ;
	(x[procesnumber].programCounter)++;
	itime++;
}

void ifx(int procesnumber,int variable, PCB x[processnumber]){
	if(atoi(mem[x[procesnumber].localizador+variable])==0){
		(x[procesnumber].programCounter)++;
		
		itime++;
	}
	else{
		(x[procesnumber].programCounter) = (x[procesnumber].programCounter) + 2;
		itime++;
	}
}

void backy(int procesnumber,int variable, PCB x[processnumber]){
	(x[procesnumber].programCounter)=(x[procesnumber].programCounter)-variable;
	itime++;
}

void forwy(int procesnumber,int variable, PCB x[processnumber]){
	(x[procesnumber].programCounter)=(x[procesnumber].programCounter)+variable;
	itime++;
	} 

void forky(int procesnumber, PCB x[processnumber]){
	/*processnumber = processnumber + 1;
	int final = x[procesnumber].localizador + x[procesnumber].size;
	int newProcess = final -  x[procesnumber].programCounter;
	int s = 0;
	for(int d = final+1; d< final + 10; d++){
		mem[d] = mem[x[procesnumber].programCounter];
		s++;
	}*/
	
	(x[procesnumber].programCounter)++;
	itime++;
}

void disksavex(int procesnumber, PCB x[processnumber]){
	(x[procesnumber].programCounter)++;
	itime=itime+3;
	enqueue(&BLOCKED, dequeue(&RUN));
	lista[QueuePeek(BLOCKED) + 1] = "blocked";
}

int copyx(int procesnumber,int variable, PCB x[processnumber]){
	(x[procesnumber].programCounter)++;
	itime++;
	return variable;
}

void exitz(int procesnumber, PCB x[processnumber]){
	
	itime++;
	int i;

	for(i=x[procesnumber].localizador;i<x[procesnumber].localizador+x[procesnumber].size;i++){
		mem[i]="xx";}
	
	enqueue(&EXIT, dequeue(&RUN));
	lista[QueuePeek(EXIT) + 1] = "exit";
	dequeue(&EXIT);
	
	
	if(tipo == 0){
		printNormal();
		}

	if(tipo ==1){
		printSimples();
	}

	int k = i+1;
	for(int f = 1; f < processnumber;f++){
		
		if(lista[procesnumber + f + 1]==NULL){
							
			break;
							
		}

		else{
			x[procesnumber + f].localizador = x[procesnumber + f].localizador - (x[procesnumber].size);	
			x[procesnumber +f].programCounter = x[procesnumber+f].programCounter - (x[procesnumber].size );
							
		}
						

	}
	
	while(mem[k] != "xx"){

		k +=1;				
	}

	k = k-1;
	
	

	for (int p = x[procesnumber].localizador; p < k; p++){
		mem[p] = mem[i];
		mem[i] = "xx";
		i++;
	}
	
	

}

void arraycreate(char *x[])
{
	for(int i = 0; i < processnumber; i++)
	{
		PCB newPCB = {0};
		int startofarray=1;
		int e=0;
		char str[5];
		int counter=0;

		for(e;x[i][e]!=' '; e++){//ciclo adicionar tempos iniciais
			char processTime=x[i][e];
			str[counter]=processTime;
			counter++;
			str[counter]='\0';
		}
		arrayfin[i][0]=strdup(str);
		newPCB.id=i;
		newPCB.initime=atoi(arrayfin[i][0]);
		while(x[i][e]!='\0'){//ciclo adicionar processos
			if(x[i][e]==' '){
				e++;
			}
			else{
				str[0]=x[i][e];
				str[1]=x[i][e+1];
				str[2]='\0';
				arrayfin[i][startofarray]=strdup(str);

				startofarray++;
				e+=2;
			}
		}
		newPCB.size=startofarray+8;
		pcbArray[i] = newPCB;

	}
	pcbArray[processarray].size+=1;
	if(tipo == 0){
		printf("\n***Succesfully read the file***\n");
	}
}

void readfile(char *nome){
	char* line =NULL;
	FILE* filepoint;
	size_t len=0;
	ssize_t read;

	filepoint = fopen(nome, "r");

	if (filepoint == NULL){
		printf("File not found\n");
	}
	else{
		int i=0;
		while((read=getline(&line, &len, filepoint)) != -1){
			temparray[i]=strdup(line);
			
			i++;
			
		}
	}

	fclose(filepoint);
	arraycreate(temparray);

}


void addToMemorypart2(int counts, int start, int procesnumber){
	
	pcbArray[procesnumber].localizador=start;
	
	pcbArray[procesnumber].programCounter=start+10;
	int start2=0;
	int a = 1;
	for(int i = start; i< start+10; i++){
		mem[i]="vv";
		start2=i+1;
	}
	
	
	for(int i = start2; i< pcbArray[procesnumber].size+start; i++){
		mem[i]=arrayfin[procesnumber][a];
		a++;
	}

}

int addToMemoryBestFit(int counts, int start, int procesnumber){
	int count2 = 0;
	for(int i=0;i<(MEMSize - pcbArray[procesnumber].size);i++){
			if(mem[i]=="xx"){
				counts++;
				if(counts >= (pcbArray[procesnumber].size)){
					if(tipo == 0){
						printf("\nProcess being added to the memory...\n");
						addToMemorypart2(counts, start, procesnumber);
						return 1;
					}
				}
			}
			else{
				start=i+1;
				counts=0;
			}
			count2=i;
		}

	while(count2<MEMSize){
		if(mem[count2] == "xx"){
			count2++;
		}
		else{
			if(tipo == 0){
				printf("\nXXX Can't store the process on memory, not enough space XXX\n");
				return 0;
			}
		}
	}
	if(tipo == 0){
		printf("\nProcess being added to the memory...\n");
	}
	addToMemorypart2(counts, start, procesnumber);
	return 1;
}

int addToMemoryWorstFit(int counts, int start, int procesnumber){
	int falsespaceCount=0;
	int falsestart=0;
	for(int i=0;i<MEMSize;i++){
			if(mem[i]=="xx"){
				counts++;
				if(counts >= (pcbArray[procesnumber].size) && counts>falsespaceCount){
					falsespaceCount=counts;
					falsestart=start;
				}
			}
			else{
				start=i+1;
				counts=0;
			}
		}
	if(falsespaceCount<pcbArray[procesnumber].size){
		if(tipo == 0){	
			printf("\nXXX Can't store the process on memory, not enough space XXX\n");
			return 0;
		}
	}
		if(tipo == 0){
			printf("\nProcess being added to the memory\n");
		}
		addToMemorypart2(pcbArray[procesnumber].size, falsestart, procesnumber);
		return 1;
}

int addToMemory(int procesnumber){
		int start=0;
		int counts=0;
		if(mem[start]=="xx"){
			if (MemoryManager=="WorstFit"){
				addToMemoryWorstFit(counts, start, procesnumber);
				return 0;	
			}
			if (MemoryManager=="BestFit"){
				if(tipo == 0){
					printf("\n\nBESTFIT\n\n");
					addToMemoryBestFit(counts, start, procesnumber);
					return 0;	
				}
			}	

		}
		while((mem[start]!="xx") && (start<MEMSize - pcbArray[procesnumber].size)){
			start++;
		}

		if (MemoryManager=="WorstFit"){
			addToMemoryWorstFit(counts, start, procesnumber);
			return 0;	
		}
		if (MemoryManager=="BestFit"){
			addToMemoryBestFit(counts, start, procesnumber);
			return 0;	
		}
}



void addNEW(){
	if(CreatedProcess<processnumber){
		if(atoi(arrayfin[CreatedProcess][0]) <= itime){
			enqueue(&NEW, CreatedProcess);
			lista[CreatedProcess+1] = "new"	;
			addToMemory(CreatedProcess);
			CreatedProcess++;
		}
		
		else{
			if(tipo == 0){
				printf("\n\nNo process waiting to enter NEW\n\n");
			}
		}
	}
}

void addREADY(){
	if(size(READY)<4 && size(BLOCKED)==0 && size(NEW)>0){
		
		enqueue(&READY,dequeue(&NEW));
		lista[QueuePeek(READY) + 1] = "ready";


	}
	else if(size(BLOCKED)>0){
		
		enqueue(&READY,dequeue(&BLOCKED));
		lista[QueuePeek(READY)+1] = "ready";
	}
	else{
		if(tipo == 0){
			printf("\nNo process added to ready\n");
		}
	}
}


int ProcessStart(){
	int pi = 0;
	while(!CheckIfEmpty(NEW) || !CheckIfEmpty(READY)  ||CheckIfEmpty(BLOCKED) ||CheckIfEmpty(RUN)){
		
		addNEW();
		if(tipo == 0){
			printNormal();
		}

		if(tipo ==1){
			printSimples();
		}
		

		addREADY();

		int RoundRobin=0;
		
		enqueue(&RUN, dequeue(&READY));
		lista[QueuePeek(RUN) + 1] = "run";
		
		while(RoundRobin<quantum){
			//printf("%d\n", RoundRobin);
			

			int Process = QueuePeek(RUN);
			int i = pcbArray[Process].programCounter;
			int variable = mem[i][1]-'0';

			
			
			if(mem[i][0]=='0'){
					
					zerox(Process,variable, pcbArray);
					
					RoundRobin++;
					
					
				}
			if(mem[i][0]=='1'){
					
					addx(Process,variable, pcbArray);
					RoundRobin++;
					
				
				}
			if(mem[i][0]=='2'){
					subx(Process,variable, pcbArray);
					RoundRobin++;
					
					
				}
			if(mem[i][0]=='3'){
					ifx(Process,variable, pcbArray);
					RoundRobin++;
					
					
				}
			if(mem[i][0]=='4'){
					backy(Process,variable, pcbArray);
					RoundRobin++;
					
					
				}
			if(mem[i][0]=='5'){
					forwy(Process,variable, pcbArray);
					RoundRobin++;
					
			if(mem[i][0]=='6'){
					forky(Process, pcbArray);
					RoundRobin++;
				}

				}
			if(mem[i][0]=='7'){
					disksavex(Process,pcbArray);
					
					
					break;
				}
			if(mem[i][0]=='8'){
					copyx(Process,variable, pcbArray);
					RoundRobin++;
					
					
				}
			if(mem[i][0]=='9'){
					
					exitz(Process, pcbArray);
					RoundRobin++;
					if(tipo == 0){
						printNormal();
					}

					if(tipo ==1){
						printSimples();
					}
					
					if(size(EXIT)==processnumber){
						printf("\n\nFinish\n\n");
						return 1;
					}
					break;
				}


			for(int y=0; atoi(arrayfin[y][itime])==0 & y<processarray; y++){
				addNEW();
				if(tipo == 0){
					printNormal();
				}

				if(tipo ==1){
					printSimples();
				}
				
				addREADY();
			}
				
			if(RoundRobin==quantum && mem[i][0]!='7' && mem[i][0]!='9'){
				
				enqueue(&READY, dequeue(&RUN));
				lista[QueuePeek(READY) + 1] = "ready";
			}
			//printf("%d\n", pcbArray[Process].localizador);
			//printf("%d\n", pcbArray[Process].programCounter);
			//printf("%d\n",pcbArray[0].programCounter );
			//printf("%d\n", pcbArray[1].programCounter);
			//printf("%d\n", pcbArray[2].programCounter);
			//printf("%d\n", pcbArray[3].programCounter);
			//printf("%d\n", pcbArray[4].programCounter);

			if(pi ==95){
				//printf("%d\n", i+1);
				//printf("%d\n", QueuePeek(RUN));
				//printf("%s\n", mem[i+1]);
				//printf("%d\n", RoundRobin);
				//printf("%d\n", pcbArray[Process].localizador );
				break;

			}
			//printf("%d\n", pi);

		}
		if(pi == 95){
			//printf("%d\n", i);
			//printf("%s\n", mem[i]);
			//printf("%d\n", RoundRobin);
			break;

			}
		//printf("%d\n", pi );
		pi = pi+1;
		
		
	}
	
}

int main(){
	int type;
	scanf("%d", &type);
	tipo = type;
	readfile("input.xpto");
	MemInitialize();
	QueueInitialize();
	ProcessStart();

}
