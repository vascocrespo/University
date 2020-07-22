public class PushArg extends InstruArgumentos
{
    int n1,n2;

    public PushArg(int n1,int n2)
    {
        this.n1 = n1;
        this.n2 = n2;
    }

    public String toString()
    {
        return "push_arg " + n1 + " " + n2;
    }
    
}