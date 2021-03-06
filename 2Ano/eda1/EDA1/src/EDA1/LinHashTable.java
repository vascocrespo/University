package EDA1;

/**
 * Created by DanielSerrano on 25/12/2017.
 */
public class LinHashTable<T> extends Hastable<T>{

    public LinHashTable() {
        super();
    }

    public LinHashTable(int n) {
        super(n);
    }



    @Override
    protected int procPos(T s) {
        int index = s.hashCode() % tabela.length;
        while(tabela[index] != null){
            if(tabela[index].getElemento() == s){
                return index;
            }
            if(index == tabela.length){
                index = 0;
            }else{
                index ++;
            }
        }
        return index;
    }
}
