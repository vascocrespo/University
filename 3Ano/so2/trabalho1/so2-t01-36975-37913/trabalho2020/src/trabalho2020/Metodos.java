import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Metodos extends UnicastRemoteObject implements Interface, java.io.Serializable{
    Connect connect = new Connect();

    public Metodos() throws java.rmi.RemoteException {
        super();
    }
    
    public void removeNecessidade (int id,String produto) throws RemoteException
    {
        try 
        {
            connect.connect();
        } catch (Exception ex) {
            Logger.getLogger(Metodos.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        
        try 
        {
            Statement stmt = connect.getStatement();
            ResultSet query = stmt.executeQuery("select * from necessidades;");
            
            while(query.next())
            {
                int idd = query.getInt("id_utilizador");
                String p = query.getString("nome_produto");
                
                if(id == idd && p.equals(produto))
                {
                    stmt.executeUpdate("delete from necessidades where id_utilizador = '"+id+"' AND nome_produto='"+produto+"';");
                    break;
                }
            }
            query.close();
            
            stmt.close();
        }
        catch (Exception e) {
            e.printStackTrace();
            System.out.print("Problems1...");
        }
        
        
    }
    
    public int login(String email) throws RemoteException 
    {   
        try 
        {
            connect.connect();
        } catch (Exception ex) {
            Logger.getLogger(Metodos.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        
        try 
        {
            Statement stmt = connect.getStatement();
            ResultSet utilizador = stmt.executeQuery("select * from utilizador;");
            
            while(utilizador.next())
            {
                String mail = utilizador.getString("email");
                
                if(mail.equals(email))
                {
                    return 0;
                }     
            }
            
            utilizador.close();
            stmt.close();
            
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print("Problems1...");
        }
        
        try
        {
            Statement stmt2 = connect.getStatement();
            stmt2.executeUpdate("INSERT INTO utilizador VALUES('"+email+"');");
            stmt2.close();
            return 1;
           
        }catch (Exception e) 
        {
            e.printStackTrace();
            System.out.print("Problems2...");
        }
        return -1;
    }
    
    public ArrayList<String> consultaNecessidades() throws java.rmi.RemoteException
    {
        ArrayList<String> necessidades = new ArrayList<String>();
        
        try 
        {
            connect.connect();
        } catch (Exception ex) {
            Logger.getLogger(Metodos.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        
        try 
        {
            Statement stmt = connect.getStatement();
            ResultSet nec = stmt.executeQuery("select * from necessidades;");
            
            while(nec.next())
            {
                String nome_produto = nec.getString("nome_produto");
                int id = nec.getInt("Id_utilizador");
                necessidades.add(nome_produto);
                necessidades.add(""+id);
            }
            nec.close();
            stmt.close();
        }catch(Exception e)
        {
            e.printStackTrace();
            System.out.print("Problems3...");
        }  
        return necessidades;
    }
    
    
    public int registoNecessidade(int id, String nome_Produto) throws java.rmi.RemoteException
    {
        
        try 
        {
            connect.connect();
        } catch (Exception ex) {
            Logger.getLogger(Metodos.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        
        try
        {
            Statement stmt = connect.getStatement();
            ResultSet query = stmt.executeQuery("select * from necessidades");
            
            while(query.next())
            {
                int id_utilizador = query.getInt("id_utilizador");
                String nomeProduto = query.getString("nome_produto");
                
                if(id == id_utilizador && nomeProduto.equals(nome_Produto))
                {
                    return -1;
                }
            }
            stmt.executeUpdate("INSERT INTO necessidades values("+id+",'"+nome_Produto+"')");   
            
            query.close();
            stmt.close();
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
            System.out.print("Problems4...");
        }
        return 1;
    }
    
    public int getId(String email) throws java.rmi.RemoteException
    {
        int id = -1;
        
        try 
        {
            connect.connect();
        } catch (Exception ex) {
            Logger.getLogger(Metodos.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        
        try
        {
            Statement stmt = connect.getStatement();
            ResultSet query = stmt.executeQuery("select * from utilizador ");
            while(query.next())
            {
                String mail = query.getString("email");
                
                if(mail.equals(email))
                {
                    id = query.getInt("id");
                }
            }   
            query.close();
            stmt.close();
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
            System.out.print("Problems5...");
        }
        return id;
    }
    
    public ArrayList<String> getLojas() throws java.rmi.RemoteException
    {
        ArrayList<String> lojas = new ArrayList<String>();
        
        try 
        {
            connect.connect();
        } catch (Exception ex) {
            Logger.getLogger(Metodos.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        
        try
        {
            Statement stmt = connect.getStatement();
            ResultSet query = stmt.executeQuery("select * from loja");
            while(query.next())
            {
                String mail = query.getString("nomeloja");
                lojas.add(mail);
                
            }
            query.close();
            stmt.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            System.out.print("Problems5...");
        }
        return lojas;
    }
    
    public ArrayList<String> getProdutos()
    {
        ArrayList <String> produtos = new ArrayList<String>();
        
        try
        {
            connect.connect();
        }
        catch(Exception ex)
        {
            Logger.getLogger(Metodos.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        
        try
        {
            Statement stmt = connect.getStatement();
            ResultSet query = stmt.executeQuery("select * from produto;");
            
            while(query.next())
            {
                String produto = query.getString("nomeProduto");
                produtos.add(produto);
            }
            
            query.close();
            stmt.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            System.out.print("Problems6...");
        }
        return produtos;
    }
    
    public boolean disponibilidade(String produto, String loja)
    {
        try
        {
            connect.connect();
        }
        catch(Exception ex)
        {
            Logger.getLogger(Metodos.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        try
        {
            Statement stmt = connect.getStatement();
            ResultSet query = stmt.executeQuery("select * from lojaproduto;");
            
            while(query.next())
            {
                String produtoCheck = query.getString("nome_produto");
                String lojaCheck = query.getString("nome_loja");
                
                if(produtoCheck.equals(produto) && lojaCheck.equals(loja))
                {
                    return true;
                }      
            }
            query.close();
            stmt.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            System.out.print("Problems6...");
        }
        return false;
    } 
    public int reportaDisponibilidade(String nome_loja, String nome_produto)
    {
        try
        {
            connect.connect();
        }
        catch(Exception ex)
        {
            Logger.getLogger(Metodos.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        try
        {
            Statement stmt = connect.getStatement();
            ResultSet query = stmt.executeQuery("select * from respostas;");
            
            while(query.next())
            {
                String produto = query.getString("Nome_produto");
                String loja = query.getString("Nome_Loja");
                
                if(nome_produto.equals(produto) && nome_loja.equals(loja))
                {
                    return -1;
                }
            }
            stmt.executeUpdate("INSERT INTO respostas VALUES('" + nome_produto + "',"+"'"+nome_loja+"');");
            query.close();
            stmt.close();
            
            return 1;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            System.out.print("Problems7...");
        }
        return -1;
    }
    
    public ArrayList <String> getReports(String nome_produto)
    {
        ArrayList<String> array = new ArrayList<>();
        try
        {
            connect.connect();
        }
        catch(Exception ex)
        {
            Logger.getLogger(Metodos.class.getName()).log(Level.SEVERE, null, ex);
        }
       
        
        try
        {
            Statement stmt = connect.getStatement();
            ResultSet query = stmt.executeQuery("select * from respostas;");
            
            while(query.next())
            {
                String produto = query.getString("Nome_produto");
                String loja = query.getString("Nome_loja");
                
                if(produto.equals(nome_produto))
                {
                    array.add(produto);
                    array.add(loja);
                }
            }
            
            query.close();
            stmt.close();
            return array;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            System.out.print("Problems7...");
        }
        return null;
    }
    public ArrayList <String> getProdutosLoja(String nome_loja)
    {
        ArrayList<String> stock = new ArrayList<>();
        
        try {
            connect.connect();
        } catch (Exception ex) {
            Logger.getLogger(Metodos.class.getName()).log(Level.SEVERE, null, ex);
        }
        

        try {
            Statement stmt = connect.getStatement();
            ResultSet query = stmt.executeQuery("select * from lojaproduto;");
            
            while(query.next())
            {
                String nomeLoja = query.getString("nome_loja");
                String produto = query.getString("nome_produto");
                
                if(nomeLoja.equals(nome_loja))
                {
                    stock.add(produto);
                }
            }
            
            query.close();
            stmt.close();

        } catch (Exception e) {
            e.printStackTrace();
            System.out.print("Problems7...");
        } 
        return stock;
    }
    
    
    
}
