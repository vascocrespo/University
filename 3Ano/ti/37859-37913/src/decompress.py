import sys

size = []
output = []
def read_file(ficheiro):#ler o ficheio comprimido
    global compressed
    global size
    fopen = open(ficheiro,"r")
    line = fopen.readline()
    size = [int(l) for l in line.split()] #separar a informacao do ficheiro para ficarem em inteiros
    
    line = fopen.readline()
    compressed = [int(x) for x in line.split()]
    
    fopen.close()



def decompress(compressed):
    
    dic = {0:"0", 1:"1"}

    i = len(dic)
    
    for oi in range(1, len(compressed)):
       
        actual = compressed[oi-1]
        
        prox = compressed[oi]
        output.append(dic[actual])
 
        if prox not in dic:
            dic[i] = str(dic[actual]) + str(dic[actual])[0]
      
        else:
            dic[i] = str(dic[actual]) + str(dic[prox])[0]
        if oi == len(compressed) -1 :
            output.append(dic[prox])
        i+=1
        print(output)
    

def write_file(image):

    f = open(image,"w+")
    lines = size[0]
    column = size[1]
    f.write("P1" + "\n")
    for hl in size:
        f.write(str(hl) + " ")
    f.write("\n")
    #print(output)

    linhas = 0
    for pp in output:
        for we in pp:
            f.write(we + " ")
            linhas = linhas + 1
            if linhas == lines:
                f.write("\n")
                linhas = 0

def main():
    read_file(sys.argv[1])
    decompress(compressed)
    write_file(sys.argv[2])

main()
