import socket, select
import threading
import errno
import time
import sys
import pickle

try:
    openfile=open("userpass.txt",'rb')
    admin=pickle.load(openfile)
except:
    admin=[]
    pickle.dump(admin, open("userpass.txt", "wb"))


def getNumber(s, nome):
    size=0
    x=[]
    s.sendall("getNumber".encode())
    time.sleep(0.4)
    #Envia nome para o servidor
    s.sendall(nome.encode())
    
    time.sleep(0.2)

    #Recebe quantia de numeros para o nome do servidor
    size=s.recv(1024)
    size=int(size.decode())

    #Recebe os nomes um a um e adiciona para um array
    if size!=0:
        for i in range(size):
            numbers=s.recv(1024)
            numbers=numbers.decode()
            x.append(numbers)
            print(nome, "has number",numbers)
            
        
        return
    errornumber=s.recv(1024)
    errornumber=int(errornumber.decode())
    if errornumber==1:
        print("nome não encontrado nos registos")
    return

def setNumber(s, nome, numero):
    s.sendall("setNumber".encode())
    time.sleep(0.4)
    #Envia nome para o servidor
    s.sendall(nome.encode())
    time.sleep(0.4)
    #Envia numero para o servidor
    s.sendall(numero.encode())
    time.sleep(0.4)
    print(nome, "number set to", numero)
    errornumber=s.recv(1024)
    errornumber=int(errornumber.decode())
    if errornumber==1:
        print("numero já encontrado nos registos")    
    
    

def reverse(s, numero):
    s.sendall("reverse".encode())
    time.sleep(0.4)
    #Envia numero para o servidor
    s.sendall(numero.encode())
    time.sleep(0.4)

    errornumber=s.recv(1024)
    errornumber=int(errornumber.decode())

    if errornumber==1:
        nome=s.recv(1024)
        nome=nome.decode()
        print("numero não encontrado nos registos")
    if errornumber==0:
        #Recebe nome do servidor
        nome=s.recv(1024)
        nome=nome.decode()
        print(numero,"is the number for",nome)
    return

def removeNumber(s, numero, nome):
    s.sendall("removenumber".encode())
    time.sleep(0.4)

    s.sendall(numero.encode())
    time.sleep(0.4)

    errornumber=s.recv(1024)
    errornumber=int(errornumber.decode())
    
    if errornumber==1:
        print("numero não encontrado nos registos")
    if errornumber==0:
        #Recebe nome do servidor
        print(nome, "number", numero, "deleted from database")
    return

def removeClient(s, nome):
    s.sendall("removeclient".encode())
    time.sleep(0.4)

    s.sendall(nome.encode())
    time.sleep(0.4)

    errornumber=s.recv(1024)
    errornumber=int(errornumber.decode())
    
    if errornumber==1:
        print("nome não encontrado nos registos")
    if errornumber==0:
        #Recebe nome do servidor
        print(nome, "deleted from database")
    return

def quitA(s):
    time.sleep(0.4)
    sys.exit()

def main():
    #AUTENTICAÇÃO
    if not admin:
        user=input("Criar novo utilizador: Nome?")
        password=input("Password?")
        admin.append(user)
        admin.append(password)
        pickle.dump(admin, open("userpass.txt", "wb"))
    if len(admin)==2:
        change=input("Mudar utilizador/password?(sim/nao/wipe)")
        if change.lower()=="nao":
            usercheck=input("Username:")
            passcheck=input("Password:")
            if usercheck==admin[0] and passcheck== admin[1]:
                canModify=True
            else:
                print("Username/Pasword errada(s)")
                main()
        elif change.lower()=="sim":
            print("Precisa de confirmar a última autenticação")
            usercheck=input("Username:")
            passcheck=input("Password:")
            if usercheck==admin[0] and passcheck== admin[1]:
                admin[0]=input("Novo username:")
                admin[1]=input("Nova password:")
                pickle.dump(admin, open("userpass.txt", "wb"))
            
            
            main()
        elif change.lower()=="wipe":
            admin.clear()
            pickle.dump(admin,open("userpass.txt", "wb"))
            main()
        else:
            print("so pode responder sim/nao/wipe, tentar outra vez")
            main()
    s= socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect(('localhost', 5000))
    while canModify:
        x=input("$")
        array=x.split()
        if len(array) == 1:
            print("instrução inválida")
        elif array[0]=="getphone":
            #FUNÇÃO SET FUNCIONA
            if array[1]=="-set":
                name=array[2]
                if len(array)>=4:
                    if type(array[3]==str) :
                        y=3
                        while(not array[y].isdigit()):
                            name+=" "+ array[y]
                            y+=1
                        number=array[-1]
                    setNumber(s, name, number)
            #FUNÇÃO REMOVENUMBER FUNCIONA
            elif array[1]=="-del" and array[-1].isdigit():
                name = array[2]
                
                number=array[-1]
                removeNumber(s, number, name)
                
            #FUNÇÃO REMOVECLIENT FUNCIONA
            elif array[1]=="-del" and not array[-1].isdigit():
                name=array[2]
                if(len(array)>3):
                    y=3
                    while(not array[y].isdigit()):
                        name+=" "+ array[y]
                        y+=1
                removeClient(s, name)
            #FUNÇÃO REVERSE FUNCIONA
            elif array[1].isdigit():
                number=array[1]
                reverse(s, number)
            #FUNÇÃO GETNUMBER FUNCIONA
            elif not array[1].isdigit():
                name=array[1]
                if(len(array)>2):
                    y=2
                    while(y<len(array)):
                        name+=" "+ array[y]
                        y+=1
                getNumber(s, name)
        elif array[0]=="quitnow":
            quitA(s)
        elif array[0]!="quitnow" or array[0]!="getphone":
            print("instrução inválida")
            

if __name__=='__main__':
    main()
