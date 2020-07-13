
public interface IMaze {
    boolean canMove(Pawn peao,String Move, int linenumber, int columns, char tab[][]); // true IFF pawn can do move in this maze

    void move(char tab[][],Pawn peao,String Move, int linha, int coluna); // if pawn can move, change his position.
    boolean isSolvedBy(Pawn peao, char tab[][]); // true IFF pawn is in EXIT position.
}