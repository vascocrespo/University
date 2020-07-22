public class Jeq extends InstruSalto
{
    String etiqueta;

    public Jeq(String etiqueta)
    {
        this.etiqueta = etiqueta;
    }

    public String toString()
    {
        return "jeq " + etiqueta;
    }

}