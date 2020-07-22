
public class Server 
{
    public static void main(String[] args)
    {
       
        
        if (args.length !=1) 
        {
            System.out.println(args.length);
	    System.out.println("Usage: java so2.rmi.Server registryPort");
	    System.exit(1);
	}
        
        
        try
        {
            int regPort=Integer.parseInt(args[0]);
            
            /*A FAZER*/
            
            //criacao da interface remota de objetos
            Interface obj= new Metodos();
            //criar objeto remoto e registalo no servico de nomes
            java.rmi.registry.LocateRegistry.createRegistry(regPort); 
            java.rmi.registry.Registry registry = java.rmi.registry.LocateRegistry.getRegistry(regPort); 

	    registry.rebind("Interface", obj);  // NOME DO SERVICO
            
            System.out.println("Server Pronto");
        }
        catch(Exception ex) 
        {
	    ex.printStackTrace();
        }
    }
}
