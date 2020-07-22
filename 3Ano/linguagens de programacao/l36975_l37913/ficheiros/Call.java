public class Call extends InstruChamada
{
    int n;
    String etiqueta;

    public Call(int n, String etiqueta)
    {
        this.n = n;
        this.etiqueta = etiqueta;
    }

    public String toString()
    {
        return "call";
    }
    
}