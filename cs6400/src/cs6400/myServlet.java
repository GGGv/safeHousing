package cs6400;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class myServlet
 */
@WebServlet("/myServlet")
public class myServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public class Pair implements Comparable<Pair>{
	    private int l;
	    private int r;
	    public Pair(){}
	    public int getL(){ return l; }
	    public int getR(){ return r; }
	    public void setL(int l){ this.l = l; }
	    public void setR(int r){ this.r = r; }
	    @Override
	    public int compareTo(Pair o) {
	    	return (r-o.r);
	    }
	}
	 
    public myServlet() {
        super();
       
    }
    
    protected int calDangerLevel(double la, double lo,Connection conn) {
    	Statement stmtCrime;
		try {
			stmtCrime = conn.createStatement();
	    	double laDown = la-0.005, laUp = la+0.005;
	        double loDown = lo-0.005, loUp = lo+0.005;
	        String sql = String.format("SELECT * FROM crime WHERE longitude BETWEEN %f AND %f AND "
	        		+ "latitude BETWEEN %f AND %f;",
	        		loDown, loUp, laDown, laUp);
	        ResultSet crime = stmtCrime.executeQuery(sql);
	        //Display crime in the block
	        float score = 0;
	        while(crime.next()){
	        	score += (1000-crime.getInt("KYC")) / 100
	        			/ (Math.abs(la-crime.getDouble("latitude"))
	        			+ Math.abs(lo-crime.getDouble("longitude")));
	        }
	        return (int)score;  
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		  List<Pair> list = new ArrayList<Pair>();
		  
	      // JDBC driver name and database URL
	      final String DB_URL="jdbc:mysql://localhost/Crime";

	      //  Database credentials
	      final String USER = "root";
	      final String PASS = "Lindaniu*126";

	      try {
	         // Register JDBC driver
	         Class.forName("com.mysql.jdbc.Driver");

	         // Open a connection
	         Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);

	         // find house based on baths,beds and price
	         Statement stmt = conn.createStatement();
	         String sql;
	         sql = String.format("SELECT * FROM house WHERE beds=%s AND baths=%s AND price>%s AND price<%s",
	        		 request.getParameter("bed"), request.getParameter("bath"),request.getParameter("price1"),request.getParameter("price2"));
	         ResultSet rs = stmt.executeQuery(sql);

	         // Extract data from result set
	         while(rs.next()){
	            int id  = rs.getInt("id");
	            //Search crime in the block and calculate crime score
	            double la = rs.getDouble("latitude"), lo = rs.getDouble("longitude");
	            int score = calDangerLevel(la,lo,conn);
	            Pair pair = new Pair();
	            pair.setL(id);
	            pair.setR(score);
	            list.add(pair);
	         }
	         
	         //Sort house
	         Collections.sort(list);
	         
		      // Set response content type
		      response.setContentType("text/html");
		      PrintWriter out = response.getWriter();
		      String title = "Database Result";
		      
		      String docType =
		         "<!doctype html public \"-//w3c//dtd html 4.0 " + "transitional//en\">\n";
		      
		      out.println(docType +
		         "<html>\n" +
		         "<head><title>" + title + "</title></head>\n" +
		         "<style> # map { height: 100%; } </style>\n" +
		         "<body bgcolor = \"#f0f0f0\">\n" +
		         "<h1 align = \"center\">" + title + "</h1>\n"
		         );
		      
	         //Display housing information
	         for(Pair pair : list) {
		         out.println("ID: " + pair.getL() + "<br>");
		         out.println("Score:" + pair.getR() + "<br>");
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

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    doGet(request, response);
	}

}
