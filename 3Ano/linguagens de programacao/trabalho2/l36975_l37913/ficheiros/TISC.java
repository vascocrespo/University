import java.util.ArrayList;

// Tiny Instruction Set Computer

public class TISC 
{

  	/** Executa o programa TISC carregado na maquina. */
  	ArrayList<Etiqueta> etiquetas;

 	public TISC()
	{
		etiquetas = new ArrayList<Etiqueta>();
  	}
  
  	public ArrayList<Etiqueta> getMem()
	{
		return etiquetas;
	}

  	public void executa()
  	{
    	show();
  	}

  	public Etiqueta getLast()
	{
		if(etiquetas.size()>0)
			return etiquetas.get((etiquetas.size()-1));
		else return null;
	}
	
	public void show()
	{
		for(int i = etiquetas.size()-1; i>=0  ; i--)
		{
			etiquetas.get(i).output();
		}
	}
}
