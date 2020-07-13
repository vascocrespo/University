package EDA1;

import java.util.Iterator;

/**
 * Created by DanielSerrano on 25/12/2017.
 */
public class ArvVL<T extends Comparable<? super T>> implements Iterable<T>{

    private ANode<T> root;
    private int size;

    public ArvVL(){
        root = null;
    }

    public ArvVL(T x){
        root = new ANode<T>(x);
    }

    public void print(){
        print(root,0);
    }
    private String ntabs(int t){
        String res="";
        for (int i=0;i<t;i++)
            res +="\t";
        return res;
    }
    private void print(ANode<T> n,int t){
        //System.out.println("PRINT2");
        if (n!=null){
            System.out.println(ntabs(t)+n);
            print(n.getLeft(),t+1);
            print(n.getRight(),t+1);
        }
    }

    public Iterator<T> iterator(){
        return new AVLIteratorPostOrder<>(root, size);
    }

    public boolean isEmpty(){
        return root==null;
    }

    public int height(){
        if(this.isEmpty()){
            return 0;
        }
        else{
            return height(root);
        }
    }

    public int height(ANode<T> node){
        if(node==null){
            return -1;
        }

        int hleft = height(node.getLeft());
        int hright = height(node.getRight());

        return Math.max(hleft,hright) + 1;
    }

    private ANode rotacaoDir(ANode<T> node){
        ANode newRoot = node.getLeft();
        ANode folhaDireitaDoNoEsq = newRoot.getRight();

        newRoot.setRight(node);
        node.setLeft(folhaDireitaDoNoEsq);

        node.setAltura(Math.max(height(node.getLeft()),height(node.getRight())));
        newRoot.setAltura(Math.max(height(newRoot.getLeft()),height(node.getRight())));

        return newRoot;
    }

    private ANode rotacaoEsq(ANode<T> node){
        ANode newRoot = node.getRight();
        ANode folhaEsqDoNoDir = newRoot.getLeft();

        newRoot.setLeft(folhaEsqDoNoDir);
        node.setRight(folhaEsqDoNoDir);

        node.setAltura(Math.max(height(node.getLeft()),height(node.getRight())));
        newRoot.setAltura(Math.max(height(newRoot.getLeft()),height(node.getRight())));

        return newRoot;


    }
    public void insere(T x) {
        root = insereRec(root, x);
    }

    private ANode insereRec(ANode<T> node, T x){
        if (node == null) {
            node = new ANode(x);
            size ++;
            return node;
        }
        if (x.compareTo(node.getElemento()) < 0) {
            node.setLeft(insereRec(node.getLeft(), x));
            node.setAltura(1 + Math.max(height(node.getLeft()),height(node.getRight())));
            if((height(node.getLeft()) - height(node.getRight())) > 1 && x.compareTo(node.getLeft().getElemento()) < 0 ){
                return rotacaoDir(node);
            }
            if((height(node.getLeft()) - height(node.getRight())) > 1 && x.compareTo(node.getLeft().getElemento()) > 0 ){
                node.setLeft(rotacaoEsq(node.getLeft()));
                return rotacaoDir(node);
            }
        }
        else if (x.compareTo(node.getElemento()) > 0) {
            node.setRight(insereRec(node.getRight(), x));
            node.setAltura(1 + Math.max(height(node.getLeft()),height(node.getRight())));
            if((height(node.getLeft()) - height(node.getRight())) < -1 && x.compareTo(node.getRight().getElemento()) > 0 ){
                return rotacaoEsq(node);
            }
            if((height(node.getLeft()) - height(node.getRight())) < -1 && x.compareTo(node.getRight().getElemento()) < 0 ){
                    node.setRight(rotacaoDir(node.getRight()));
                return rotacaoEsq(node);
            }
        }
        else{
            return node;
        }
        return node;
    }

    public T findMin(){
        return findMin(root);
    }

    private T findMin(ANode<T> n) {
        if(n.getLeft() != null){
            return findMin(n.getRight());
        }else{
            return n.getElemento();
        }
    }

    public void remove(T x) {
        root = remove(root, x);
    }

    private ANode remove(ANode<T> n, T x){
        if(n == null){
            return(n);
        }
        if(x.compareTo(n.getElemento()) < 0){
            n.setLeft(remove(n.getLeft(), x));
        }else if(x.compareTo(n.getElemento()) > 0){
            n.setRight(remove(n.getRight(), x));
        }else{
            if(n.getLeft() != null && n.getRight() !=null){
                T minright = findMin(n.getRight());
                n.setElemento(minright);
                n.setRight(remove(n.getLeft(), minright));
            }
            else if(n.getLeft() != null){
                n = n.getLeft();
            }else if(n.getRight() != null){
                n=n.getRight();
            }
            else{
                n = null;
                size --;
            }
        }
        return n;
    }

    public boolean contains(T x) {
        return contains(root, x);
    }

    private boolean contains(ANode<T> n, T x) {
        if(x.compareTo(n.getElemento()) == 0 && n.getElemento() != null){
            return true;
        }
        if(x.compareTo(n.getElemento()) < 0 && n.getLeft() != null){
            return contains(n.getLeft(), x);
        }
        if(x.compareTo(n.getElemento()) > 0 && n.getRight() != null){
            return contains(n.getRight(), x);
        }
        return false;
    }

    public void printEmOrdem() {
        printEmOrdem(root);
    }

    private void printEmOrdem(ANode n){
        if(n != null){
            printEmOrdem(n.getLeft());
            System.out.println(n + " ");
            printEmOrdem(n.getRight());
        }
    }




}
