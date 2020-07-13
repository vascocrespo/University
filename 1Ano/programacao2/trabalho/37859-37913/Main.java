import java.util.*;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.lang.*;

public class Main {
    static int linenumber;
    static int columns;
    static Scanner name;
    static BufferedReader hello;
    static char[][] meize;
    static String line;
    static int linhaInicial;
    static int colunaInicial;
    static int[] pia;
    static Scanner digaUm;
    static Maze m;
    static Route r;
    static String movimento;







    public static void main(String[] args) throws IOException {
        System.out.println("Introduza o nome do ficheiro: ");
        name = new Scanner(System.in);
        String filename = name.nextLine();
        posS(meize,filename);
        for (int l=0; l<linenumber; l++){
            for (int co=0; co<columns; co++){
                System.out.print(meize[l][co]);
            }
            System.out.println("");

        }
        m= new Maze (meize,linhaInicial,colunaInicial, linhaInicial,colunaInicial, linenumber,columns);
        r = new Route (meize,linhaInicial,colunaInicial);

        Scanner rawoption= new Scanner(System.in);
        System.out.println("Escolha uma opção(0- play, 1-solve):");
        int option= rawoption.nextInt();

        if (option==0) {
            while (m.isSolvedBy(m.peao, meize) != true) {
                digaUm = new Scanner(System.in);
                System.out.println("Introduza o próximo movimento(NORTH, SOUTH, WEST, EAST):");

                movimento = digaUm.nextLine().toUpperCase();
                player(movimento);
                if ( movimento.equals("NORTH") || movimento.equals("SOUTH") || movimento.equals("WEST") || movimento.equals("EAST") ) {
                    r.move(movimento);
                }

            }
            if ( m.isSolvedBy(m.peao, meize) == true ) {

                System.out.println("Parabéns, completou o labirinto!");

            }
        }

        if (option==1) {
            findRoute();
            meize[linhaInicial][colunaInicial] = 'S';

            for (int l = 0; l < linenumber; l++) {
                for (int co = 0; co < columns; co++) {
                    System.out.print(meize[l][co]);
                }
                System.out.println("");

            }
        }
    }


    public static char[][]OpenandCreate(String filename) throws IOException {
        try {
            hello = new BufferedReader(new FileReader(filename));
            linenumber=0;
            columns=0;
            String line = "";
            while ((line = hello.readLine()) != null) {
                linenumber = linenumber + 1 ;

                if (columns == 0) {
                    columns = line.length();

                }if (line.length() != columns) {
                    throw new Exception("Número de caractéres na linha " + linenumber + " inválido!");

                }


            }
            hello.close();
        }
        catch (Exception e) {
            System.out.println(e.getMessage());
            System.exit(0);
        }

        meize= new char[linenumber][columns];
        return meize;
    }

    public static char[][] OpenandDraw(String filename) throws IOException {
        OpenandCreate(filename);
        int x=0;
        try {
            hello = new BufferedReader(new FileReader(filename));
            while (x<linenumber) {
                line = hello.readLine();
                x = x + 1 ;
                for (int j = 0; j < columns; j++) {
                    char c = line.charAt(j);
                    meize[x-1][j] = c;
                }

            }
            hello.close();
            for (int l=0; l<linenumber; l++){
                for (int co=0; co<columns; co++){
                    if (meize[l][co] != 'S' && meize[l][co] != 'E' && meize[l][co] != '_' && meize[l][co] != 'W'){
                        throw new Exception("Ficheiro contém caractéres inválidos!");
                    }
                }
                System.out.println("");

            }
        } catch (Exception e) {

            System.out.println(e.getMessage());
            System.exit(0);

        }

        return meize;

    }

    public static int[] posS(char[][] lab, String filename) throws IOException{
        OpenandDraw(filename);
        for (int linea = 0 ; linea < linenumber; linea++ ){
            for (int colan = 0; colan < columns; colan++){
                if (meize[linea ][colan]=='S'){
                    linhaInicial = linea;
                    colunaInicial = colan;
                    break;
                }
            }
        }

        pia = new int[]{linhaInicial,colunaInicial};
        return pia;
    }

    public static void player(String Movimentar){

        m.move(m.peao.rout1.tab,m.peao, Movimentar, m.linhaInicial,m.colunaInicial);


    }
    public static void findRoute(){
        while (meize[m.piao.linha][m.piao.coluna] != 'E'){
            if (m.canMovimentar(m.piao,m.linenumber,m.columns,meize) == true ){

                if (m.piao.coluna + 1 < columns){
                    if(meize[m.piao.linha][m.piao.coluna + 1] == 'E'){
                        break;
                    }
                    if(meize[m.piao.linha][m.piao.coluna + 1] == '_'){ //direita
                        meize[m.piao.linha ][m.piao.coluna] = 'X';


                        m.piao.coluna = m.piao.coluna + 1;
                        m.pawnMoves.add("EAST");

                    }



                }

                if (m.piao.linha - 1 >=0){
                    if(meize[m.piao.linha - 1][m.piao.coluna] == 'E') {
                        break;
                    }
                    if(meize[m.piao.linha - 1][m.piao.coluna] == '_') { //norte
                        meize[m.piao.linha ][m.piao.coluna] = 'X';
                        m.piao.linha = m.piao.linha - 1;
                        m.pawnMoves.add("NORTH");
                    }

                }
                if (m.piao.coluna - 1 >=0 ) {
                    if ( meize[m.piao.linha][m.piao.coluna - 1] == 'E' ) {
                        break;
                    }
                    if ( meize[m.piao.linha][m.piao.coluna - 1] == '_' ) { //esquerda
                        meize[m.piao.linha ][m.piao.coluna] = 'X';
                        m.piao.coluna = m.piao.coluna - 1;
                        m.pawnMoves.add("WEST");
                    }

                }

                if (m.piao.linha + 1 < linenumber){
                    if(meize[m.piao.linha + 1][m.piao.coluna] == 'E') {
                        break;
                    }
                    if(meize[m.piao.linha + 1][m.piao.coluna] == '_') { //sul
                        meize[m.piao.linha ][m.piao.coluna] = 'X';
                        m.piao.linha = m.piao.linha + 1;
                        m.pawnMoves.add("SOUTH");
                    }

                }



            }
            if (m.piao.coluna - 1 >=0 ) {
                if ( m.canMovimentar(m.piao, m.linenumber, m.columns, meize) == false && meize[m.piao.linha][m.piao.coluna - 1] == 'E' ) {
                    meize[m.piao.linha][m.piao.coluna] = 'X';
                    break;


                }
            }
            if (m.piao.coluna + 1 < columns) {
                if ( m.canMovimentar(m.piao, linenumber, columns, meize) == false && meize[m.piao.linha][m.piao.coluna + 1] == 'E' ) {
                    meize[m.piao.linha][m.piao.coluna] = 'X';
                    break;

                }
            }
            if (m.piao.linha + 1 < linenumber) {
                if ( m.canMovimentar(m.piao, m.linenumber, m.columns, meize) == false && meize[m.piao.linha + 1][m.piao.coluna] == 'E' ) {
                    meize[m.piao.linha][m.piao.coluna] = 'X';
                    break;

                }
            }
            if (m.piao.linha - 1 >=0) {
                if ( m.canMovimentar(m.piao, m.linenumber, m.columns, meize) == false && meize[m.piao.linha - 1][m.piao.coluna] == 'E' ) {
                    meize[m.piao.linha][m.piao.coluna] = 'X';
                    break;

                }
            }




            if (m.canMovimentar(m.piao,m.linenumber,m.columns,meize) == false && meize[m.piao.linha][m.piao.coluna - 1] == 'X' ){
                meize[m.piao.linha][m.piao.coluna]='O';
                meize[m.piao.linha][m.piao.coluna - 1] = '_';
                m.piao.coluna=m.piao.coluna - 1;
                m.pawnMoves.add("WEST");



            }
            if (m.canMovimentar(m.piao,linenumber,columns,meize) == false && meize[m.piao.linha][m.piao.coluna + 1] == 'X' ){

                meize[m.piao.linha][m.piao.coluna]='O';
                meize[m.piao.linha][m.piao.coluna + 1] = '_';
                m.piao.coluna=m.piao.coluna + 1;
                m.pawnMoves.add("EAST");

            }
            if (m.canMovimentar(m.piao,m.linenumber,m.columns,meize) == false && meize[m.piao.linha+ 1][m.piao.coluna] == 'X' ){
                meize[m.piao.linha][m.piao.coluna]='X';
                meize[m.piao.linha + 1][m.piao.coluna] = '_';
                m.piao.linha=m.piao.linha + 1;
                m.pawnMoves.add("SOUTH");

            }
            if (m.canMovimentar(m.piao,m.linenumber,m.columns,meize) == false && meize[m.piao.linha -1 ][m.piao.coluna] == 'X' ){
                meize[m.piao.linha][m.piao.coluna]='X';
                meize[m.piao.linha - 1][m.piao.coluna] = '_';
                m.piao.linha=m.piao.linha -1;
                m.pawnMoves.add("NORTH");

            }


        }
        if (m.piao.linha + 1 < linenumber) {
            if ( meize[m.piao.linha + 1][m.piao.coluna] == 'E' && m.canMovimentar(m.piao,m.linenumber,m.columns,meize) == false) {
            }
        }
        if (m.piao.coluna + 1 < columns) {
            if ( meize[m.piao.linha][m.piao.coluna + 1] == 'E' && m.canMovimentar(m.piao,m.linenumber,m.columns,meize) == false) {

            }
        }
        if (m.piao.linha - 1 >=0) {
            if ( meize[m.piao.linha - 1][m.piao.coluna] == 'E' && m.canMovimentar(m.piao,m.linenumber,m.columns,meize) == false) {
            }
        }
        if (m.piao.coluna - 1 >=0 ) {
            if ( meize[m.piao.linha][m.piao.coluna - 1] == 'E' && m.canMovimentar(m.piao,m.linenumber,m.columns,meize) == false) {

            }
        }
        System.out.print("Percurso percorrido pelo peão: ");
        System.out.println("");
        for(int i = 0; i < m.pawnMoves.size(); i++) {
            System.out.print(m.pawnMoves.get(i) + " ");

        }
        System.out.println(" ");
    }

}






