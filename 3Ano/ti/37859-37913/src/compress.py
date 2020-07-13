import sys, math

new=[]
size=[]
compressed=[]

def read_file(ficheiro):
    global new
    global size 
    fopen=open(ficheiro,"r")
     
    for line in fopen: #iteracao para ler o ficheiro a descomprimir
        if line[0]== "#" or line[0]== "P":
            continue
        if size:
            buffer=line.split() #separar o que esta no ficheiro para adicionar ao array caracter por caracter
            for char in buffer:
                new.append(char)
        elif not size:
            tempsize=line.split()
            for i in tempsize:
                size.append(i)
    #print(new)
    
    fopen.close()

def compress(new):
    global compressed #lista que vai guardar os inteiros correspondentes a compressao do ficheiro
    p=""
    dic={0:"0",1:"1"} #dicionario que e utilizado para guardar as possibilidades de compressao
    i=len(dic)
    for char in new:
        lzw=p+char
        if lzw in dic.values():
            p=lzw
        else:
            for key in dic.items():
                if key[1]==p:
                    compressed.append(int(key[0]))
            dic[i]=lzw
            i+=1
            p=char
    for key in dic.items():
                if key[1]==p:
                    compressed.append(int(key[0]))
    


def file_writing(compress): # funcao para escrever num novo ficheiro txt o ficheiro ja comprimido
    f= open(compress,"w+")
    i=""
    for hl in size:
        
        f.write(hl + " ")
    f.write("\n")
    for p in compressed:
        
        f.write("%d " % p)
        
    f.close

def entropia():
    zeros = 0
    ones = 0
    twozero = 0
    zerone = 0
    twone = 0
    onezero = 0
    for j in range(0,len(new)):
        
        
        if new[j] == "0":
            zeros+=1
            if j != len(new)-1:
                
                if new[j+1] == "0":
                    twozero+=1
                elif new[j+1] == "1":
                    zerone+=1
        if new[j] == "1":
            ones+=1
            if j != len(new)-1:
                if new[j+1] == "1":
                    twone+=1
                elif new[j+1] == "0":
                    onezero+=1

##    print("zeros",zeros)
##    print("ones",ones)
##    print("twozero",twozero)
##    print("zerone",zerone)
##    print("twone",twone)
##    print("onezero",onezero)
                
    prob0 = (zeros/len(new))
    prob1 = (ones/len(new))
    result=-((prob0*math.log(prob0,2))+(prob1*math.log(prob1,2)))
    print("A entropia deste ficheiro é",result)

    prob00 = twozero /( len(new) - 1)
    prob01 = zerone / (len(new) - 1)
    prob11 = twone / (len(new) - 1)
    prob10 = onezero / (len(new) - 1)
    

    cond0 = prob0 * ((prob00 * math.log(prob00,2)) + (prob01 * math.log(prob01,2)))
    cond1 = prob1 * ((prob10 * math.log(prob10,2)) + (prob11 * math.log(prob11,2)))
    conditional = -(cond0 + cond1)
    print("A entropia condicional deste ficheio é", conditional)


def desempenho():
    performance = ((math.fabs(len(compressed)-len(new)))/len(new))*100
    print("O desempenho desta compressão é",performance,"%")

    


def main():
    read_file(sys.argv[1])
    compress(new)
    file_writing(sys.argv[2])
    entropia()
    desempenho()
            
        
main()
    
