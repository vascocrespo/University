
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author miguel
 */
public class Cliente 
{
   public static void main(String[] args)
   {
        //String regHost = "localhost";
        //String regPort = "9000";  // porto do binder
	

	if (args.length !=2) // requer 2 argumentos
        { 
            System.out.println(args.length);
	    System.out.println
		("Usage: java so2.rmi.Client registryHost registryPort");        
	    System.exit(1);
	}
	String regHost= args[0];
	String regPort= args[1];
        
        try 
        {
               // objeto que fica associado ao proxy para objeto remoto
            
            Interface obj = (Interface) java.rmi.Naming.lookup("rmi://" + regHost + ":" + regPort + "/Interface");
            
            Scanner scanner = new Scanner(System.in);
            
            boolean sucess = false;
            String email = "";
            
            while(!sucess)
            {
                System.out.println("Efetue o login");
                System.out.println("Insira o seu mail");
                String mail = scanner.next();
                
                int login = obj.login(mail);
                
                if(login == 0)
                {
                    System.out.println("Este mail ja existe.\n" 
                                        + "É seu ?\n"
                                        + "[1] Sim\n"
                                        + "[2] Nao");
                    System.out.print("Opcao: ");
                    int opcao = scanner.nextInt();
                    
                    while(opcao > 2)
                    {
                        System.out.print("Numero invalido, insira 1 ou 2");
                        opcao = scanner.nextInt();
                    }
                    
                    if(opcao == 1)
                    {
                        sucess = true;
                        email = mail;
                        System.out.println("Login efetuado com sucesso");
                    }
                }
                else if(login == 1)
                {
                    sucess = true;
                    email = mail;
                    System.out.println("Login efetuado com sucesso");
                }
            }
            

            String id = ""+obj.getId(email);
            
            int q = obj.getId(email);
            
            ArrayList<String> list = obj.consultaNecessidades();
            
            for(int i = 0; i < list.size();i++)
            {
                if(id.equals(list.get(i)))
                {
                    String prod = list.get(i-1);
                    ArrayList<String> array = obj.getReports(prod);
                    
                    for(int j = 0; j<array.size()-1;j++)
                    {
                        System.out.println("O produto " + array.get(j) + " que necessitava esta na loja "+array.get(j+1)); 
                        obj.removeNecessidade(q, prod);
                    } 
                    
                }   
            }

            int opcao = -1;
            
            while(opcao != 0)
            {
                System.out.print("\nQual a operação que deseja fazer :\n"
                    + "[1] Consulta Necessidades\n"
                    + "[2] Registo de Necessidade do Produto\n"
                    + "[3] Reporta Disponibilidade de um Produto\n"
                    + "[4] Procura Produto\n"
                    + "[0] Sair\n");
                    
                System.out.print("Opcao: ");
                opcao = scanner.nextInt();
                
                switch(opcao)
                {
                    case 1:
                        ArrayList<String> necessidades = obj.consultaNecessidades();
                        
                        System.out.println("Necessidades");
                        
                        if(necessidades.isEmpty())
                        {
                            System.out.println("Nao existem necessidades");
                        }
                        else
                        {
                            for(int i = 0; i < necessidades.size();i+=2)
                            {
                                System.out.println(necessidades.get(i));
                            }
                        }                        
                        break;
                    case 2: // registo de necessidades
                        ArrayList <String> produtos = obj.getProdutos();
                        
                        System.out.print("\nQue produto necessita:\n");
                        
                        for(int i = 0; i < produtos.size(); i++)
                        {
                            System.out.println("["+i+"] " + produtos.get(i));
                        }
                        System.out.println("["+produtos.size()+"] " + "Sair");
                        
                        System.out.print("Indique o numero correspondente ao produto: ");
                        int x = scanner.nextInt();
                        
                        if(x == produtos.size())
                        {
                            break;
                        }
                           
                        while(x > produtos.size())
                        {
                            System.out.println("Numero invalido");
                            System.out.print("Indique o numero correspondente ao produto: ");
                            x = scanner.nextInt();
                        }
                        int id1 = obj.getId(email);
                        
                        int registo = obj.registoNecessidade(id1, produtos.get(x));
                       
                        if(x < produtos.size())
                        {
                            if(registo != -1)
                            { 
                                System.out.println("Necessidade registada");
                            }
                            else
                            {
                                System.out.println("Voce ja registou esta necessidade");
                            }
                            
                        }
                        break;
                        
                    case 3:
                        System.out.println("Produtos:");
                        ArrayList<String> produtosCheck = obj.getProdutos();
                        ArrayList<String> lojasCheck = obj.getLojas();
                        
                        if(produtosCheck.isEmpty())
                        {
                            System.out.println("Nao existem produtos");
                        }
                        else
                        {
                            for(int i = 0; i < produtosCheck.size();i++)
                            {
                               System.out.println("["+i+"] " + produtosCheck.get(i));
                            }
                            System.out.println("["+produtosCheck.size()+"] " + "Sair");
                            
                            System.out.print("Indique o numero correspondente ao produto: ");
                            int y = scanner.nextInt();
                            
                            if(y == produtosCheck.size())
                            {
                                break;
                            }

                            while(y > produtosCheck.size())
                            {
                                System.out.println("Numero invalido");
                                System.out.print("Indique o numero correspondente ao produto: ");
                                y = scanner.nextInt();
                                
                            }
                            String produto = produtosCheck.get(y);
                            
                            for(int i = 0; i < lojasCheck.size();i++)
                            {
                               System.out.println("["+i+"] " + lojasCheck.get(i));
                            }
                            System.out.println("["+lojasCheck.size()+"] " + "Sair");

                            System.out.println("Indique o numero correspondente à loja: ");
                            int z = scanner.nextInt();
                            if(z == lojasCheck.size())
                            {
                                break;
                            }
                            while(z > lojasCheck.size())
                            {
                                System.out.println("Numero invalido");
                                System.out.print("Indique o numero correspondente à loja: ");
                                z = scanner.nextInt();
                                
                            }
                            String loja = lojasCheck.get(z);
                            
                            boolean check = obj.disponibilidade(produto, loja);
                            if(check)
                            {
                                //System.out.println("Esse produto existe nessa loja.");
                                
                                ArrayList <String> consulta = obj.consultaNecessidades();
                                
                                for(String i : consulta)
                                {
                                    if(i.equals(produto))
                                    {
                                        int report = obj.reportaDisponibilidade(loja, produto);
                                        
                                        if(report != -1)
                                        {
                                            System.out.println("Reporte registado com sucesso, a outra pessoa será notificada");
                                        }
                                        else
                                        {
                                            System.out.println("Reporte ja foi efetuado");
                                        }
                                    }
                                }
                            }

                            else
                            {
                                System.out.println("Esse produto não existe nessa loja.");
                            }
                            break;
                        }
                        break;
                        
                    case 4 : 
                        ArrayList<String> lojas = obj.getLojas();

                        for (int i = 0; i < lojas.size(); i++) 
                        {
                            System.out.println("[" + i + "] " + lojas.get(i));
                        }
                        System.out.println("[" + lojas.size() + "] " + "Sair");
                        System.out.print("Indique o numero correspondente a loja: ");
                        
                        int y = scanner.nextInt();
                        
                        if (y == lojas.size()) {
                            break;
                        }

                        while (y > lojas.size()) {
                            System.out.println("Numero invalido");
                            System.out.print("Indique o numero correspondente a loja: ");
                            y = scanner.nextInt();
                        }
                        
                        ArrayList<String> stock = obj.getProdutosLoja(lojas.get(y));

                        System.out.println("Produtos:");
                        if (stock.isEmpty()){
                            break;
                        } else {
                            for (int i = 0; i < stock.size(); i++) {
                                System.out.println("[" + i + "] " + stock.get(i));
                            }
                        }           
                        break;
                    default:
                        break;
                }
                
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }                                      
   }
}
