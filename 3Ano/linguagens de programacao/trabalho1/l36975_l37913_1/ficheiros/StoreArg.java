public class StoreArg extends InstruArgumentos
{
    int n1, n2;

    public StoreArg(int n1, int n2)
    {
        this.n1 = n1;
        this.n2 = n2;
    }

    public String toString()
    {
        return "store_arg " + n1 + " " + n2;
    }
    
}