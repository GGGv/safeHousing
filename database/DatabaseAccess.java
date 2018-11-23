// Run: javac -cp ~/Tomcat-9.0.3/lib/servlet-api.jar -d ~/Tomcat-9.0.3/webapps/ROOT/WEB-INF/classes/ DatabaseAccess.java
// Loading required libraries
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
 
public class DatabaseAccess extends HttpServlet{

   public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
   
      // JDBC driver name and database URL
      final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
      final String DB_URL="jdbc:mysql://localhost/Crime";

      //  Database credentials
      final String USER = "root";
      final String PASS = "password";

      // Set response content type
      response.setContentType("text/html");
      PrintWriter out = response.getWriter();
      String title = "Database Result";
      
      String docType =
         "<!doctype html public \"-//w3c//dtd html 4.0 " + "transitional//en\">\n";
      
      out.println(docType +
         "<html>\n" +
         "<head><title>" + title + "</title></head>\n" +
         "<body bgcolor = \"#f0f0f0\">\n" +
         "<h1 align = \"center\">" + title + "</h1>\n");
      try {
         // Register JDBC driver
         Class.forName("com.mysql.jdbc.Driver");

         // Open a connection
         Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);

         // Execute SQL query
         Statement stmt = conn.createStatement();
         String sql;
         sql = "SELECT id FROM house WHERE id=10";
         ResultSet rs = stmt.executeQuery(sql);

         // Extract data from result set
         while(rs.next()){
            //Retrieve by column name
            int id  = rs.getInt("id");
            //String address = rs.getString("address");

            //Display values
            out.println("ID: " + id + "<br>");
            //out.println(", Address: " + address + "<br>");
         }
         out.println("</body></html>");

         // Clean-up environment
         rs.close();
         stmt.close();
         conn.close();
      } catch(SQLException se) {
         //Handle errors for JDBC
         se.printStackTrace();
      } catch(Exception e) {
         //Handle errors for Class.forName
         e.printStackTrace();
      }
   }
} 