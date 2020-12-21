package mypackage;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.net.*;
import java.time.LocalDateTime;

//TODO: add logging to improve debugging (instead of using console prints)
public class OrderServlet extends HttpServlet {
    private boolean remote; // false = local (use localhost), true = remotely-hosted (heroku)
    
    @Override 
    public void init() {
        remote = false;
        if (System.getenv("CLEARDB_DATABASE_URL") != null) {remote=true;}
    }
    
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        Statement stmt = null;
        PrintWriter out = response.getWriter();
        try {
            boolean rc;
            response.setContentType("text/html");
            out.println("<!DOCTYPE html>");
            
            if (remote) {
                conn = OrderServlet.getConnection();
            } else {
                conn = OrderServlet.getLocalConnection();
            }
            
            stmt = conn.createStatement();
            
            // Get the next available purchase order ID
            String[] items = request.getParameterValues("items");
            String sql = "SELECT MAX(id) AS id from orders";
            System.out.format("SQL query: %s\n", sql); //debug
            ResultSet rs  = stmt.executeQuery(sql);
            int maxID = 0;
            while(rs.next()) {
                maxID = rs.getInt("id")+1;
                System.out.format("the maximum order ID is: %d\n", maxID);
            }
            
            // Record cart data
            // TODO: handle case where cart table already exists
            String tblName = "cart_"+Integer.toString(maxID);
            sql = "CREATE TABLE "+tblName+" (name VARCHAR(255), price INT, quantity INT)";
            System.out.format("SQL query: %s\n", sql); //debug
            stmt.execute(sql);
            for (String item: items) {
                System.out.format("item: %s\n", item); //debug
                sql = "INSERT INTO " + tblName + " (name) VALUES(\'" + item + "\')";
                System.out.format("SQL query: %s\n", sql); //debug
                rc = stmt.execute(sql);
            }
            
            // Record order data
            // TODO: implement current date-data generation in yyyy-mm-dd format
            // LocalDateTime ldt = LocalDateTime.now();
            sql = "INSERT INTO orders VALUES(0,'2020-12-19',0,0)";
            rc = stmt.execute(sql);
            System.out.format("SQL query: %s\n", sql); //debug
            
            out.println("<h3>SQL query successful</h3>");
            out.println("<a href=\"index.html\">Back to Home</a>");
        } catch(Exception e) {e.printStackTrace();}
        out.println("GET request complete");
    }
    
    public static Connection getConnection() throws URISyntaxException, SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String envdburl = System.getenv("CLEARDB_DATABASE_URL");
        if (envdburl == null) {throw new URISyntaxException(envdburl, "null");}
        URI dbUri = new URI(envdburl);
        
        String uname = dbUri.getUserInfo().split(":")[0];
        String pw = dbUri.getUserInfo().split(":")[1];
        String dbUrl = "jdbc:mysql://" + dbUri.getHost() + dbUri.getPath();
        
        return DriverManager.getConnection(dbUrl, uname, pw);
    }
    
    public static Connection getLocalConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        if ((System.getenv("DBURI") == null) || (System.getenv("DBPW") == null)) {throw new SQLException();}
        return DriverManager.getConnection(System.getenv("DBURI"), "root", System.getenv("DBPW"));
    }
}