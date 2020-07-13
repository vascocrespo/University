package EDA1;

/**
 * Created by DanielSerrano on 25/12/2017.
 */
public class ArvBP<T extends Comparable<? super T>>{

    ANode<T> root;

    public ArvBP(){
        root = null;
    }

    public ArvBP(T x){
        root =new ANode<T>(x);
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


    public boolean isEmpty() {
        return root==null;
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


    public T findMax() {
        return findMax(root);
    }

    private T findMax(ANode<T> n){
        if(n.getRight() != null){
            return findMin(n.getLeft());
        }else{
            return n.getElemento();
        }
    }


    public void insere(T x) {
        root = insereRec(root, x);
    }

    private ANode insereRec(ANode<T> node, T x){
        if (node == null) {
            node = new ANode(x);
            return node;
        }
        if (x.compareTo(node.getElemento()) < 0) {
            node.setLeft(insereRec(node.getLeft(), x));
        }
        else if (x.compareTo(node.getElemento()) > 0) {
            node.setRight(insereRec(node.getRight(), x));
        }
        return node;
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
                n.setRight(remove(n.getRight(), minright));
            }
            else if(n.getLeft() != null){
                n = n.getLeft();
            }else if(n.getLeft() != null){
                n=n.getRight();
            }
            else{
                n = null;
            }
        }
        return n;
    }


    public void printEmOrdem() {
        printEmOrdem(root);
    }

    private void printEmOrdem(ANode n){
        if(n != null){
            printEmOrdem(n.getLeft());
            System.out.print(n + " ");
            printEmOrdem(n.getRight());
        }
    }


    public void printPosOrdem(){ printPosOrdem(root);
    }

    public void printPosOrdem(ANode n) {
        if(n !=  null) {
            printPosOrdem(n.getLeft());
            printPosOrdem(n.getRight());
            System.out.print(n + " ");
        }
    }


    public void printPreOrdem(){ printPreOrdem(root);
    }

    public void printPreOrdem(ANode n) {
        if(root !=  null) {
            System.out.print(n + " ");
            printPosOrdem(n.getLeft());
            printPosOrdem(n.getRight());
        }
    }

}
