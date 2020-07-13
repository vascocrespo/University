import java.util.ArrayList;

public class Maze implements IMaze {
    public Pawn peao;
    public Pawn piao;
    public int linenumber;
    public int columns;
    public int linhaInicial;
    public int colunaInicial;

    public int [] posPeao;
    ArrayList<String> pawnMoves = new ArrayList<String>();
    public Maze(char[][] tab, int linhaInicial, int colunaInicial, int linha, int coluna, int linenumber, int columns){
        peao = new Pawn(tab,linha,coluna);
        piao = new Pawn(tab,linha,coluna);
        this.linenumber = linenumber;
        this.columns = columns;
        this.linhaInicial = linhaInicial;
        this.colunaInicial = colunaInicial;
    }


    public int getLinha(){
        return peao.linha;
    }
    public int getColuna(){
        return peao.coluna;
    }

    public boolean canMove(Pawn peao,String Move, int linenumber, int columns, char tab[][]) {

        switch (Move) {
            case "NORTH":
                if ( (peao.linha - 1 < 0) || (tab[peao.linha - 1][peao.coluna]) == 'W' ) {
                    System.out.println("Movimentação inválida: " + Move);
                    return false;

                }
                if ( (tab[peao.linha - 1][peao.coluna] == '_') || (tab[peao.linha - 1][peao.coluna] == 'E') ) {
                    return true;
                }

            case "SOUTH":
                if ( (peao.linha + 2 > linenumber) || (tab[peao.linha + 1][peao.coluna] == 'W') ) {
                    System.out.println("Movimentação inválida: " + Move);
                    return false;
                }
                if ( (tab[peao.linha + 1][peao.coluna] == '_') || (tab[peao.linha + 1][peao.coluna] == 'E') ) {
                    return true;
                }
            case "EAST":
                if ( (peao.coluna + 2 > columns) || (tab[peao.linha][peao.coluna + 1] == 'W') ) {
                    System.out.println("Movimentação inválida: " + Move);
                    return false;
                }
                if ( (tab[peao.linha][peao.coluna + 1] == '_') || (tab[peao.linha][peao.coluna + 1] == 'E') ) {
                    return true;
                }
            case "WEST":

                if ( (peao.coluna - 1 < 0) || (tab[peao.linha][peao.coluna - 1] == 'W') ) {
                    System.out.println("Movimentação inválida: " + Move);
                    return false;

                }
                if ( (tab[peao.linha][peao.coluna - 1] == '_') || (tab[peao.linha][peao.coluna - 1] == 'E') ) {
                    return true;

                }

        }
        if (Move != "NORTH" || Move != "WEST" || Move != "SOUTH" || Move != "EAST") {
            System.out.println("Movimentação inválida: " + Move);
            return false;
        }
        return false;

    }

    public void move(char tab[][],Pawn peao,String Move, int linha, int coluna) {


        if(canMove(peao,Move,linenumber,columns,tab) == true){

            switch (Move){
                case "NORTH":

                    if (tab[peao.linha][peao.coluna] != 'S' && tab[peao.linha][peao.coluna] != 'E') {
                        tab[peao.linha][peao.coluna] = '_';
                    }

                    peao.linha = peao.linha - 1;
                    if ( tab[peao.linha][peao.coluna] == 'E'){
                        break;

                    }
                    tab[peao.linha][peao.coluna] = 'X';
                    /*System.out.println(peao.linha);
                    System.out.println(peao.coluna);*/
                    posPeao = new int[]{peao.linha + 1,peao.coluna + 1};

                    System.out.println("Posição atual do peão: " + posPeao[0] + "," + posPeao[1]);

                    for (int l=0; l<linenumber; l++){
                        for (int co=0; co<columns; co++){
                            System.out.print(tab[l][co]);
                        }
                        System.out.println("");

                    }

                    break;
                    //falta verificar se chegou ao fim
                case "SOUTH":
                    if (tab[peao.linha][peao.coluna] != 'S' && tab[peao.linha][peao.coluna] != 'E') {
                        tab[peao.linha][peao.coluna] = '_';
                    }
                    peao.linha = peao.linha + 1;
                    if ( tab[peao.linha][peao.coluna] == 'E'){
                        break;

                    }
                    tab[peao.linha][peao.coluna] = 'X';
                    /*System.out.println(peao.linha);
                    System.out.println(peao.coluna);*/
                    posPeao = new int[]{peao.linha + 1,peao.coluna + 1};

                    System.out.println("Posição atual do peão: " + posPeao[0] + "," + posPeao[1]);

                    for (int l=0; l<linenumber; l++) {
                        for (int co = 0; co < columns; co++) {
                            System.out.print(tab[l][co]);
                        }
                        System.out.println("");
                    }



                    break;

                case "EAST":


                    if (tab[peao.linha][peao.coluna] != 'S' && tab[peao.linha][peao.coluna] != 'E') {
                        tab[peao.linha][peao.coluna] = '_';
                    }
                    peao.coluna = peao.coluna + 1;
                    if ( tab[peao.linha][peao.coluna] == 'E'){
                        break;

                    }

                    tab[peao.linha][peao.coluna] = 'X';
                    /*System.out.println(peao.linha);
                    System.out.println(peao.coluna);*/
                    posPeao = new int[]{peao.linha + 1, peao.coluna + 1};


                    System.out.println("Posição atual do peão: " + posPeao[0] + "," + posPeao[1]);

                    for (int l = 0; l < linenumber; l++) {
                        for (int co = 0; co < columns; co++) {
                            System.out.print(tab[l][co]);
                        }
                        System.out.println("");

                    }


                    break;
                case "WEST":
                    if (tab[peao.linha][peao.coluna] != 'S' && tab[peao.linha][peao.coluna] != 'E') {
                        tab[peao.linha][peao.coluna] = '_';
                    }

                    peao.coluna = peao.coluna - 1;
                    if ( tab[peao.linha][peao.coluna] == 'E'){
                        break;
                    }
                    tab[peao.linha][peao.coluna] = 'X';
                    /*System.out.println(peao.linha);
                    System.out.println(peao.coluna);*/
                    posPeao = new int[]{peao.linha + 1, peao.coluna + 1};

                    System.out.println("Posição atual do peão: " + posPeao[0]+ "," + posPeao[1]);

                    for (int l = 0; l < linenumber; l++) {
                        for (int co = 0; co < columns; co++) {
                            System.out.print(tab[l][co]);
                        }
                        System.out.println("");

                    }


                    break;

            }
        }//caso de estar num beco e nao estar em E
        //caso de estar em E

    }


    public boolean isSolvedBy(Pawn peao,char tab[][]) {

        if (tab[peao.linha][peao.coluna] == 'E'){

            return true;
        }
        else{

            return false;
        }
    }

    public boolean canMovimentar(Pawn piao,int linenumber , int columns, char tab[][]) {

        if (piao.linha - 1 >=0) {


            if ( tab[piao.linha - 1][piao.coluna] == '_') {

                return true;
            }
        }
        if (piao.linha + 1 <linenumber) {
            if ( tab[piao.linha + 1][piao.coluna] == '_' ) {
                return true;
            }
        }
        if (piao.coluna + 1 <columns) {
            if ( tab[piao.linha][piao.coluna + 1] == '_') {
                return true;
            }
        }
        if (piao.coluna - 1 >=0) {
            if ( tab[piao.linha][piao.coluna - 1] == '_' ) {
                return true;

            }
        }
        else{

            return false;
        }
        return false;

    }
}






