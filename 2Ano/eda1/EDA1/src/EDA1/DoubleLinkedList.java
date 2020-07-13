package EDA1;

import java.util.Iterator;

/**
 * Created by DanielSerrano on 25/12/2017.
 */
public class DoubleLinkedList<T> implements Iterable<T> {
    Node<T> head, tail;
    int size;

    public DoubleLinkedList() {
        head = new Node<>();
        tail = new Node<>();
        size = 0;
        head.setRight(tail);
        tail.setLeft(head);
    }


    @Override
    public Iterator<T> iterator() {
        return new DoubleLinkedListIterator<T>(head.getRight());
    }

    public int size() {
        return this.size;
    }


    public boolean isEmpty() {
        return head.getRight() == null;
    }

    public void remove(int i) {
        Node<T> x = getNode(i);


        if (x.getRight() == null) {
            x.getLeft().setRight(null);
        } else {
            x.getLeft().setRight(x.getRight());
            x.getRight().setLeft(x.getLeft());
        }
        size--;
    }

    public void remove(T x) {
        Node<T> p = head;

        while (p != null && p.getRight().getElemento() != x) {
            p = p.getRight();
        }
        p.setRight(p.getRight().getRight());
        size--;
    }

    public void add(T x) {

        add(size, x);

    }

    public void add(int i, T x) {

        Node<T> p = getNode(i - 1);
        Node<T> novo = new Node<>(x, p, p.getRight());

        p.getRight().setLeft(novo);
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

    private Node<T> getNode(int i) { //retorna o no que está em i
        Node<T> p = head;

        for (int k = 0; k <= i; k++) {
            p = p.getRight();
        }
        return p;
    }

}
