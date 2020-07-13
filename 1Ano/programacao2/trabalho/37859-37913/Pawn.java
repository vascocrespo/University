public class Pawn {
    Route rout1;
    int linha;
    int coluna;
    public Pawn (char tab [][],int linha, int coluna){
        this.linha=linha;
        this.coluna=coluna;
        rout1 = new Route(tab,linha, coluna);

    }
    public void movePawn(Pawn peao,String move,char tab[][]) {




    }



    public Route getRoute() {
        return rout1;
    }
}

