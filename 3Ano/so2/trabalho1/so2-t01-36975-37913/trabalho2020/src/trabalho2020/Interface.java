
import java.util.*;


public interface Interface extends java.rmi.Remote
{
    public int login(String email) throws java.rmi.RemoteException;
    public ArrayList<String> consultaNecessidades() throws java.rmi.RemoteException;
    public int registoNecessidade(int id, String nome_Produto) throws java.rmi.RemoteException;
    public int getId(String nome_Utilizador) throws java.rmi.RemoteException;
    public ArrayList <String> getProdutos() throws java.rmi.RemoteException;
    public boolean disponibilidade(String produto, String loja) throws java.rmi.RemoteException;
    public ArrayList<String> getLojas() throws java.rmi.RemoteException;
    public int reportaDisponibilidade(String nome_loja, String produto) throws java.rmi.RemoteException;
    public ArrayList<String> getReports(String nome_produto) throws java.rmi.RemoteException;
    public ArrayList <String> getProdutosLoja(String nome_loja) throws java.rmi.RemoteException;
    public void removeNecessidade (int id,String produto) throws java.rmi.RemoteException;
}
