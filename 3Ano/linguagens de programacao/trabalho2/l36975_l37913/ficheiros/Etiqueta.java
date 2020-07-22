import java.util.ArrayList;

public class Etiqueta 
{
	ArrayList<Instrucao> instrucao1;

	public Etiqueta()
	{
		instrucao1 = new ArrayList<Instrucao>();
	}

	public void add_instrucao(Instrucao instrucao)
	{
		instrucao1.add(instrucao);
	}

	public void output()
	{
		
		for(int i=instrucao1.size()-1; i >= 0 ; i--)
		{
			System.out.println(instrucao1.get(i).toString());
		}
	}

}
