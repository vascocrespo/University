####################################################################
#quatro - Esta funcao verifica se os quatro algarismos de um certo 
#numero sao todos diferentes
#
#Argumentos:
#numero-string de quatro caracteres
#
#Valor de retorno:
#retorna True caso todos os 4 caracteres sejam diferentes e False
#caso haja pelo menos 2 caracteres iguais
####################################################################
def quatro(numero):
    count = 0

    for i in range(0,4):#percorrer todos os 4 caracteres da string
        count = 0

        if numero[i] == numero[0]:
            count = count + 1

        if numero[i] == numero[1]:
            count = count + 1

        if numero[i] == numero[2]:
            count = count + 1

        if numero[i] == numero[3]:
            count = count + 1

        if count >1:
        
            return False

    return True

####################################################################
#PigAndBull - Esta funcao executa o jogo e recebe os inputs do
#utilizador executando todas as verificacoes e verificando a
#igualdade dos algarismos do numero gerado aleatoriamente e do numero
#valido dado como input pelo utilizador
#
#Nao recebe argumentos
#
#Valor de retorno:
#Devolve a quantidade de piggs e bulls em cada jogada do utilizador
#e ao chegar ao fim devolve todas as jogadas feitas pelo utilizador
#enumerando-as
####################################################################
def PigAndBull():
    import random
    num = str(random.randint(1000,9999)) #escolha de um numero aleatorio de 1000 a 9999
    quatro1 = quatro(num)
    
    while quatro1 == False:#excecao caso string com caracteres iguais
        num = str(random.randint(1000,9999))
        quatro1 = quatro(num)  

    tentativa = str(input('Código? '))
    check1 = check(tentativa)
    
    while check1 == False:#excecoes caso string com caracteres invalidos e/ou iguais
        tentativa = str(input('Código? '))
        check1 = check(tentativa)

        if check1 == True:
            quatro2 = quatro(tentativa)

            while check1 == True and quatro2 == False:
                print('Introduziu um valor inválido, tente outra vez!')
                tentativa = str(input('Código? '))
                quatro2 = quatro(tentativa)

    quatro2 = quatro(tentativa)
    
    while quatro2 == False:
        print('Introduziu um valor inválido, tente outra vez!')
        tentativa = str(input('Código? '))
        check2 = check(tentativa)

        while check2 == False:
            tentativa = str(input('Código? '))
            check2 = check(tentativa)
        quatro2 = quatro(tentativa)
    
    pigs = 0
    bulls = 0
    attempt = 1
    final = ''
    fim = 0
    
    if  tentativa == num:#verificar se chegou ao resultado final
        print('Acertou!!')
        print('As suas tentativas foram:')
        print(final + '\n' + 'T' + str(attempt) + ': ' + str(tentativa) + ', ' + '4T' + ' ' + '0P')
    
    
    else:#caso nao tenha descoberto na primeira tentativa

        while tentativa != num:

            for o in range(0,4):#verificar em quantos algarismos e as posicoes que adivinhou

                for p in range(0,4):
                    
                    if o == p and tentativa[o]==num[p]:
                        bulls = bulls + 1

                    elif tentativa[o] == num[p]:
                        pigs = pigs + 1
            
            final = final + '\n' + 'T' + str(attempt) + ': ' + str(tentativa) + ', ' + str(bulls)+ 'T' + ' ' + str(pigs) + 'P'
            print(str(bulls) + 'T', str(pigs) + 'P')
            tentativa = str(input('Código? '))
            check3 = check(tentativa)
            quatro3 = quatro(tentativa)

            while check1 == False:
                
                tentativa = str(input('Código? '))
                check3 = check(tentativa)

                if check3 == True:
                    quatro3 = quatro(tentativa)

                    while check3 == True and quatro3 == False:
                        tentativa = str(input('Código? '))
                        quatro3 = quatro(tentativa)

            quatro3 = quatro(tentativa)
            
            while quatro3 == False:

                print('Introduziu um valor inválido, tente outra vez!')
                tentativa = str(input('Código? '))    
                check3 = check(tentativa)

                while check3 == False:

                    tentativa = str(input('Código? '))
                    check3 = check(tentativa)
                    quatro3 = quatro(tentativa)

                    while quatro3 == False:

                        print('Introduziu um valor inválido, tente outra vez!')
                        tentativa = str(input('Código? '))
                        quatro3 = quatro(tentativa)
                
            attempt = attempt + 1
            pigs = 0
            bulls = 0

            if  tentativa == num:

                f = 1
                print('Acertou!!')    
                print('As suas tentativas foram:')
                print(final + '\n' + 'T' + str(attempt) + ': ' + str(tentativa) + ', ' + '4T' + ' ' + '0P')
                

####################################################################
#check - Esta funcao verifica se o seu input é constuido por um
#numero de quatro algarismos 
#
#Argumentos:
#tentativa- string
#
#Valor de retorno:
#retorna True caso seja uma string constituida apenas por algarismos
#e se tiver tamanho quatro e retorna False caso contrario
####################################################################    
def check(tentativa):

    for h in tentativa:

        if ord(h) < 48 or ord(h) >57 or len(tentativa) != 4:
            print('Introduziu um valor inválido, tente outra vez!')
            return False

    return True


        
    
        
    


