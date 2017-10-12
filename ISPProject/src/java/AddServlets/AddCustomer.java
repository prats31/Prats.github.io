/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AddServlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Harish
 */
public class AddCustomer extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        try {
            response.setContentType("text/html;charset=UTF-8");
            Statement stmt;
            Connection con = ConClass.CClass.getConnection();
            stmt = con.createStatement();

//  address id
            ResultSet rs = stmt.executeQuery("select max(addressid) as id from addressinfo");
            int addId = 0;
            while (rs.next()) {
                addId = rs.getInt("id");
            }
//address values 
            String flat = request.getParameter("flat");
            String build = request.getParameter("build");
            String zone = request.getParameter("zone");
            String area = request.getParameter("area");
            String add = request.getParameter("addre");

            PreparedStatement ps = con.prepareStatement("insert into addressinfo values(?,?,?,?,?,?)");

            ps.setInt(1, addId + 1);
            ps.setString(2, flat.trim());
            ps.setString(3, build.trim());
            ps.setString(4, area.trim());
            ps.setString(5, zone.trim());
            ps.setString(6, add.trim());

            ps.executeUpdate();
//address done

//customer info
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String no = request.getParameter("no");
            String email = request.getParameter("email");
            String user = request.getParameter("user");
            int planid = Integer.parseInt(request.getParameter("planid"));

            //////date////
            String today = request.getParameter("today");

            SimpleDateFormat format = new SimpleDateFormat("y-MM-dd");
            java.util.Date parsed = format.parse(today.trim());
            java.sql.Date todaydate = new java.sql.Date(parsed.getTime());
           HttpSession session = request.getSession(true);
          
            int loginid  = (Integer) session.getAttribute("loginID");
         
            ps = con.prepareStatement("insert into customerinfo values(?,?,?,?,?,?,?,?,?)");

            ps.setInt(1, loginid);
            ps.setString(2, user.trim()+zone.trim());
            ps.setString(3, fname.trim());
            ps.setString(4, lname.trim());
            ps.setString(5, email.trim());
            ps.setString(6, no.trim());
            ps.setDate(7, todaydate);
            ps.setInt(8, addId + 1);
            ps.setInt(9, planid);

            ps.executeUpdate();
///done customer

// user plan
            // end date          
            String enddate = request.getParameter("enddate");
            parsed = format.parse(enddate.trim());
            java.sql.Date Enddate = new java.sql.Date(parsed.getTime());

//  plan amount
             rs = stmt.executeQuery("select * from planinfo where planid="+planid+" and loginid="+loginid+" ");
            int amount = 0;
            while (rs.next()) {
                amount = rs.getInt(6);
            }
            
            ps = con.prepareStatement("insert into userplaninfo values(?,?,?,?,?,?,?)");
int due=0;
            ps.setInt(1, loginid);//ID.LoginId.login_id
            ps.setString(2, user.trim());
            ps.setDate(3, todaydate);
            ps.setDate(4, Enddate);
            ps.setInt(5,due );
            ps.setInt(6, amount);
            ps.setInt(7, planid);
            ps.executeUpdate();
            
            
            out.print("User Successfully Added");

        } catch (SQLException ex) {
            out.print(ex);
        } catch (Exception ex) {
            out.print(ex);
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
