package EDA1;

/**
 * Created by DanielSerrano on 23/12/2017.
 */
public class LinkedListIterator<T> implements java.util.Iterator<T> {

    private Node<T> current;

    public LinkedListIterator(Node<T> c) {
        current = c;
    }

    public boolean hasNext() {
        return current != null;
    }

    public T next() {
        if (!hasNext())
            throw new java.util.NoSuchElementException();

        T nextItem = null;

        try {
            nextItem = current.elemento();
        }
        catch (InvalidNodeException e) {
            e.printStackTrace();
        }
        current = current.getRight();
        return nextItem;
    }

    public void remove() {
        throw new UnsupportedOperationException();
    }

}
