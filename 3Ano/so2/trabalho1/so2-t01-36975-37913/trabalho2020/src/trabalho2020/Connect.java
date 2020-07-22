import java.sql.*;

public class Connect 
{
        java.sql.Connection con = null;
        java.sql.Statement stmt = null;
        
        String PG_HOST = "localhost";
        String PG_DB = "bdtrabalho";
        String USER = "trabalho1";
        String PWD= "teste";
    
        public void connect()
        {
            try {
                Class.forName("org.postgresql.Driver");

                // url = "jdbc:postgresql://host:port/database",
                con = DriverManager.getConnection("jdbc:postgresql://" + PG_HOST + ":5432/" + PG_DB,
                        USER,
                        PWD);

                stmt = con.createStatement();

            } catch (Exception e) {
                e.printStackTrace();
                System.err.println("Problems setting the connection");
            }
        }
        
        public Statement getStatement()
        {
            return stmt;
        }
}
