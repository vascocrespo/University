#include <stdio.h>
#include <stdlib.h>

#define quantum 4
#define MEMSize 300
#define ready_process 4
#define processnumber 2
#define processarray 1
#define stateSize 16

typedef struct PCB{
	int id;
	int initime;
	int localizador;
	int programCounter;
	int size;
}PCB;

PCB pcbArray[processnumber];

typedef struct Queue{
	
	int front;
	int rear;
  int items;
	int queueArray[stateSize];
}Queue;

bool CheckIfEmpty(Queue q){
	return q.items==0;
}

int QueuePeek(Queue q){
   return q.queueArray[q.front];
}

bool CheckIfFull(Queue q){
    return q.items == stateSize;
}


int size(Queue q){
    return q.items;
}  



void enqueue(Queue *q, int information){
    if(!CheckIfFull(*q)){
      if(q->rear == stateSize-1){
        	q->rear = -1;            
        }       
     	q->rear++;
      q->items++;
      q->queueArray[q->rear] = information;
    }
    else{
    	printf("Full Queue, it is not possible to enqueue any more processes\n");
    }
}

int dequeue(Queue *q){
  if(CheckIfEmpty(*q)){
      printf("Cannot dequeue empty queue \n");         
    }
  else{
      int information = q->queueArray[q->front];
      q->queueArray[q->front] = -1;
      
    if(q->front == stateSize-1){
        q->front = 0;
    }

    else{
        q->front+=1;
    }
      
    q->items--;
      return information; 
      }
}

void printQueue(Queue q){
  int countSize = size(q);
  int i = q.front;
  while(countSize>0){
    printf(" %d |",q.queueArray[i] );
    if (q.front==stateSize-1){
      i=0;
      countSize-=1;
    }
    else{
      i++;
      countSize-=1;
    }
  }
}