package EDA1;

import java.util.Iterator;

/**
 * Created by DanielSerrano on 23/12/2017.
 */
public class LinkedList<T> implements Iterable<T> {
    Node<T> head;
    int size;

    public LinkedList(){
        head = new Node<>();
        size=0;

    }

    @Override
    public Iterator<T> iterator() { return new LinkedListIterator<T>(head.getRight());
    }


    public int size() {
        return this.size;
    }


    public boolean isEmpty(){
        return head.getRight()==null;
    }


        public void remove(int i){

        Node<T> p = getNode(i);
        Node<T> p_ant = getNode(i-1);

        if(p.getRight()==null){

            p_ant.setRight(null);

        }
        else{

            p_ant.setRight(p.getRight());
        }

        size--;

    }


    public void remove(T x) {
        Node<T> p = head;

        while(p != null && p.getRight().getElemento()!=x){
            p = p.getRight();
        }
        p.setRight(p.getRight().getRight());
        size --;
    }



    public void add(T x) {

        add(size,x);

    }


    public void add(int i, T x) {

        Node<T> p = getNode(i - 1);

        Node<T> novo = new Node<>(x,p.getRight());

        p.setRight(novo);

        size++;

    }


    public T get(int i) {
        Node<T> x = getNode(i);
        return x.getElemento();
    }


    public void set(int i, T y) {
        Node<T> x = getNode(i);
        x.setElemento(y);
    }

    private Node<T> getNode(int i){ //retorna o no que está em i

        Node<T> p = head;

        for(int k=0; k<=i;k++){
            p=p.getRight();
        }
        return p;
    }
}
