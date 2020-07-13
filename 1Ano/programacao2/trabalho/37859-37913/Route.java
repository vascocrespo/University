import javax.sound.midi.SysexMessage;
import java.util.ArrayList;
public class Route implements IRoute {

    char tab[][];
    int linha;//posicao do pawn
    int coluna;
    ArrayList<String> directions = new ArrayList<String>();



    public Route(char tab[][], int linha,int coluna){
        this.tab = tab;
        this.linha = linha;
        this.coluna= coluna;

    }

    public int getCol() {

        return coluna;
    }


    public int getRow() {
        return 0;
    }


    public int getCol(int i) {
        return 0;
    }


    public int getRow(int i) {
        return 0;
    }


    public int length() {
        return 0;
    }


    public void move(String Move) {
        directions.add(Move);
        System.out.print("Percurso percorrido pelo peão: ");
        System.out.println("");
        for(int i = 0; i < directions.size(); i++) {
                System.out.print(directions.get(i) + " ");

            }
        System.out.println(" ");
    }




}

