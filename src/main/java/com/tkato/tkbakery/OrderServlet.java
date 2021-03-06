package com.tkato.tkbakery;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.net.*;
import java.text.SimpleDateFormat;
import java.util.Date;

//TODO: add logging to improve debugging (instead of using console prints)
public class OrderServlet extends HttpServlet {
    
    private Logger log = LoggerFactory.getLogger(OrderServlet.class);
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
            String sql = "";
            response.setContentType("text/html");
            out.println("<!DOCTYPE html>");
            
            if (remote) {
                conn = OrderServlet.getConnection();
            } else {
                conn = OrderServlet.getLocalConnection();
            }
            
            stmt = conn.createStatement();
            
            // Get today's date in yyyy-mm-dd format
            Date date = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String today = formatter.format(date);
            
            // Record order data
            sql = "INSERT INTO orders VALUES(0,\"" + today + "\",0,0)";
            rc = stmt.execute(sql);
            log.info("SQL query: %s\n", sql);
            
            // Get the next available purchase order ID
            String[] items = request.getParameterValues("items");
            sql = "SELECT MAX(id) AS id from orders";
            log.info("SQL query: %s\n", sql);
            ResultSet rs  = stmt.executeQuery(sql);
            int maxID = 0;
            while(rs.next()) {
                maxID = rs.getInt("id");
                log.info("the maximum order ID is: %d\n", maxID);
            }
            
            // Record cart data
            String tblName = "cart_"+Integer.toString(maxID);
            sql = "CREATE TABLE IF NOT EXISTS " + tblName + " (name VARCHAR(255), price INT, quantity INT)";
            log.info("SQL query: %s\n", sql);
            stmt.execute(sql);
            for (String item: items) {
                log.info("item: %s\n", item);
                sql = "INSERT INTO " + tblName + " (name) VALUES(\'" + item + "\')";
                log.info("SQL query: %s\n", sql);
                rc = stmt.execute(sql);
            }
            
            out.println("<h3>Order complete!</h3>");
            out.println("<p>Thank you for shopping at TK Bakery</p>");
            out.println("<a href=\"/\">Back to Home</a>");
        } catch(Exception e) {log.error("Order failed to complete, check stack trace on the console");e.printStackTrace();}
        log.info("GET request complete");
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