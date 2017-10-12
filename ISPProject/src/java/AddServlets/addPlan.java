/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AddServlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
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
public class addPlan extends HttpServlet {

    Statement stmt;

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
            int planid = 0;
            String name = request.getParameter("name");
            int am = Integer.parseInt(request.getParameter("am").trim());
            int dur = Integer.parseInt(request.getParameter("dur").trim());
            String des = request.getParameter("des");
            Connection con = ConClass.CClass.getConnection();
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select max(planid) as id from planinfo");

            while (rs.next()) {

                planid = rs.getInt("id");

            }

             HttpSession session = request.getSession(true);
          
            int loginid  = (Integer) session.getAttribute("loginID");

            PreparedStatement ps = con.prepareStatement("insert into planinfo values(?,?,?,?,?,?)");
            ps.setInt(1, loginid);
            ps.setInt(2, planid+1);
            ps.setString(3, name.trim());
            ps.setString(4, des.trim());
            ps.setInt(5, dur);
            ps.setInt(6, am);
            ps.executeUpdate();
            out.println("Plan successfully added");
            
        } catch (Exception ex) {
            out.print(ex);
           System.out.print(ex);
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
