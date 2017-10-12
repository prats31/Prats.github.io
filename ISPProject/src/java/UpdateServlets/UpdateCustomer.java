/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UpdateServlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.sql.PreparedStatement;
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
public class UpdateCustomer extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

            Connection con = ConClass.CClass.getConnection();
 HttpSession session = request.getSession(true);
          
            int loginid  = (Integer) session.getAttribute("loginID");

            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String no = request.getParameter("no");
            String email = request.getParameter("email");
            String user = request.getParameter("user");

            PreparedStatement ps = con.prepareStatement("update customerinfo set first_name =?,last_name=?,email_id=?,mobileno =? where username=? and loginid="+loginid+" ");
            ps.setString(1, fname);
            ps.setString(2, lname);
            ps.setString(3, email);
            ps.setString(4, no);
            ps.setString(5, user);

            ps.executeUpdate();
            ps = con.prepareStatement("select addressid from customerinfo where username='" + user + "'");
            ResultSet rs = ps.executeQuery();
            int addId = 0;
            while (rs.next()) {
                addId = rs.getInt(1);
            }

            String flat = request.getParameter("flat");
            String build = request.getParameter("build");
            String zone = request.getParameter("zone");
            String area = request.getParameter("area");
            String add = request.getParameter("addre");

            ps = con.prepareStatement("update addressinfo set flatno=?,buildingname=? , are = ?,zone=?,addressline1=? where addressid = ? ");
            ps.setString(1, flat);
            ps.setString(2, build);
            ps.setString(3, area);
            ps.setString(4, zone);
            ps.setString(5, add);
            ps.setInt(6, addId);

            ps.executeUpdate();

            String planName = request.getParameter("planid");
            //int pid = Integer.parseInt(planid);
            ps = con.prepareStatement("select * from planinfo where name='" + planName + "' and loginid="+loginid+" ");
            rs = ps.executeQuery();
            int am = 0, pid = 0;
            while (rs.next()) {
                am = rs.getInt("amount");
                pid = rs.getInt("planid");
            }
            Date newdate, expdate = null;
            ps = con.prepareStatement("select p.name,p.duration,p.amount,max(up.renewdat), max(up.expirydat)  from planinfo p , userplaninfo up where p.planid= up.planid and trim(lower(up.username))='" + user.trim().toLowerCase() + "' and p.loginid=" + loginid + " ");
            rs = ps.executeQuery();
            while (rs.next()) {
                newdate = rs.getDate(4);
                expdate = rs.getDate(5);
            }

            String start = request.getParameter("startdate");
            String end = request.getParameter("enddate");

            java.text.DateFormat format = new java.text.SimpleDateFormat("y-MM-dd");

            java.util.Date parsed = format.parse(start);
            java.sql.Date startdate = new java.sql.Date(parsed.getTime());

            java.util.Date parsed1 = format.parse(end);
            java.sql.Date enddate = new java.sql.Date(parsed1.getTime());

            ps = con.prepareStatement("update userplaninfo set renewdat=?, expirydat=?, due=? ,paid=?,planid=? where lower(username) =? and expirydat =?");
            ps.setDate(1, startdate);
            ps.setDate(2, enddate);
            ps.setInt(3, am);
            ps.setInt(4, 0);
            ps.setInt(5, pid);
            ps.setString(6, user);
            ps.setDate(7, expdate);
            ps.executeUpdate();
            ps = con.prepareStatement("update customerinfo set planid=? where username=?");
            ps.setInt(1, pid);
            ps.setString(2, user);
            ps.executeUpdate();

            out.print("User Successfully Updated");

        } catch (Exception ex) {
            out.print(ex);//      Logger.getLogger(UpdateCustomer.class.getName()).log(Level.SEVERE, null, ex);
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
     * @param request servlet requestx
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
