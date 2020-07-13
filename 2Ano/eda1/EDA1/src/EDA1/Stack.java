package EDA1;

/**
 * Created by DanielSerrano on 21/12/2017.
 */
public interface Stack<T>{
    public void push(T o);
    public T top();
    public T pop() throws EmptyException;
    public int size();
    public boolean empty();
}
