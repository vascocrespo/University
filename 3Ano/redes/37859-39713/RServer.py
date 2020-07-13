import socket, select
import time
import threading
import traceback
import errno
import pickle
import sys

#FALTA EXCEÇÕES
SOCKET_LIST=[]
RECV_BUFFER= 4096
PORT= 5000


try:
    openfile=open("ficheiro.txt",'rb')
    clients=pickle.load(openfile)
except:
    clients=[]
    pickle.dump(clients, open("ficheiro.txt", "wb"))
    
    
def getNumber(s):
    global clients
    #Recebe nome do cliente
    size=0
    nome=s.recv(1024)
    nome=nome.decode()
    inside="0"
    error="1"
    #Procura o nome no array clients e envia todos os numeros correspondentes
    for individual in clients:
            if nome in individual:
                inside="1"
                error="0"
                #Envia numero de numeros para o cliente
                size=str(len(individual)-1)
                s.sendall(str(size).encode())
                time.sleep(0.6)
                for i in individual:
                        if type(i)!= str:
                                s.sendall(str(i).encode())
                                time.sleep(0.8)
    if inside=="0":
            s.sendall(str(size).encode())
            time.sleep(0.6)
    s.sendall(error.encode())
    time.sleep(1)
            

def setNumber(s):
    global clients
    clientbuffer=[]
    #Presença de erro começa a 0
    error="0"
    add="1"
    #Recebe nome a adicionar do cliente
    nome=s.recv(1024)
    nome=nome.decode()
    #Recebe numero a adicionar do cliente
    numero=s.recv(1024)
    numero=int(numero.decode())
    for individual in clients:
            #Se o nome está no array, adiciona ao array correspondente dentro de clients
            if numero in individual:
                    #numero é encontrado já no array portanto erro
                    error="1"
                    break
            elif nome in individual:
                    individual.append(numero)
                    add="0"
                    break
    #Envio do codigo de erro
    s.sendall(error.encode())
    time.sleep(0.4)
    #Se não está, adiciona um array com nome e numero a clients
    if error!="1" and add=="1":
            clientbuffer.append(nome)
            clientbuffer.append(numero)
            clients.append(clientbuffer)
            pickle.dump(clients, open("ficheiro.txt", "wb"))
    if error!="1" and add=="0":
            pickle.dump(clients, open("ficheiro.txt","wb"))

    
def reverse(s):
    global clients
    namebuffer=" "
    error="1"
    #Recebe numero do cliente
    numero=s.recv(1024)
    numero=int(numero.decode())
    #Procura o nome no array clients e envia para o cliente
    for individual in clients:
            if numero in individual:
                    error="0"
                    namebuffer=str(individual[0])
    s.sendall(error.encode())
    time.sleep(0.6)
    
    s.sendall(namebuffer.encode())
    time.sleep(0.4)

def removeNumber(s):
    global clients
    error="1"
    #Recebe numero do cliente
    numero=s.recv(1024)
    numero=int(numero.decode())
    #Procura o nome no array clients e envia para o cliente
    for individual in clients:
            if numero in individual and (len(individual)>2):
                    error="0"
                    individual.remove(numero)
            if numero in individual and (len(individual)==2):
                    error="0"
                    clients.remove(individual)
    pickle.dump(clients, open("ficheiro.txt", "wb"))
    s.sendall(error.encode())
    time.sleep(0.4)

def removeClient(s):
    global clients
    error="1"
    #Recebe numero do cliente
    nome=s.recv(1024)
    nome=nome.decode()
    #Procura o nome no array clients e envia para o cliente
    for individual in clients:
            if nome in individual:
                    error="0"
                    clients.remove(individual)
                    break
    pickle.dump(clients, open("ficheiro.txt", "wb"))
    s.sendall(error.encode())
    time.sleep(0.4)



                                    
def main(data, sock):
    if (data.decode() == "getNumber"):
            getNumber(sock)
    if (data.decode() == "setNumber"):
            setNumber(sock)
    if (data.decode() == "reverse"):
            reverse(sock)
    if (data.decode() == "removenumber"):
            removeNumber(sock)
    if (data.decode() == "removeclient"):
            removeClient(sock)

            
if __name__ == "__main__":
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server_socket.bind(("0.0.0.0", PORT))  # aceita ligações de qualquer lado
    server_socket.listen(10)
    #server_socket.setblocking(0) # o socket deixa de ser blocking
    
    # Adicionamos o socket à lista de sockets a monitorizar
    SOCKET_LIST.append(server_socket)
    
    print("Servidor iniciado na porta %d" % (PORT,))
    #PICKLE

    timecount = 0
    while True:  # ciclo infinito

            # apagamos os sockets que "morreram" entretanto
            for sock in SOCKET_LIST:
                    if sock.fileno() < 0:
                            SOCKET_LIST.remove(sock)

            # agora, esperamos que haja dados em algum dos sockets que temos
            rsocks,_,_ = select.select(SOCKET_LIST,[],[], 5)

            if len(rsocks) == 0: # timeout
                    timecount += 5
                    print("Timeout on select() -> %d secs" % (timecount))
                    if timecount % 60 == 0:  # passou um minuto
                            timecount = 0
                    continue
            
            for sock in rsocks:  # percorrer os sockets com nova informação
                     
                    if sock == server_socket: # há uma nova ligação
                            newsock, addr = server_socket.accept()
                            #newsock.setblocking(0)
                            SOCKET_LIST.append(newsock)
                            
                            print("Novo Cliente - %s" % (addr,))
                             
                    else: # há dados num socket ligado a um cliente
                            try:
                                    data = sock.recv(RECV_BUFFER)
                                    if data:
                                            #main (data,sock)
                                            t = threading.Thread(target = main, args = (data, sock))
                                            t.start()

                                    else: # não há dados, o cliente fechou o socket
                                            print("\nCliente Desconectado")
                                            sock.close()
                                            SOCKET_LIST.remove(sock)
                                            
                            except Exception as e: # excepção ao ler o socket, o cliente fechou ou morreu
                                    print("Client disconnected")
                                    print("Exception -> %s" % (e,))
                                    print(traceback.format_exc())
                                    
                                    sock.close()
                                    SOCKET_LIST.remove(sock)
