/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mainpage;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Formatter;
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
public class MainPage extends HttpServlet {

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

            Connection con = ConClass.CClass.getConnection();
            String strdate, endDate, duestr, paystr;
            ResultSet rs, rs1;
            PreparedStatement ps, ps1; 
            HttpSession session = request.getSession(true);
          
            int loginid  = (Integer) session.getAttribute("loginID");
            ps = con.prepareStatement("select reverse(substring(reverse(c.username),length(a.zone)+1)) ,a.zone from customerinfo c , addressinfo a where c.addressid = a.addressid and c.loginid = "+loginid+" ");
            rs = ps.executeQuery();            
            while(rs.next()) {
                String user = rs.getString(1).toLowerCase();
String zone = rs.getString(2).toLowerCase();
                
                
                    strdate = request.getParameter(user + "new");
                endDate = request.getParameter(user + "exp");

                paystr = request.getParameter(user + "pay");
                duestr = request.getParameter(user + "due");

                if (strdate != null) {
                    java.text.DateFormat format = new java.text.SimpleDateFormat("y-MM-dd");

                    java.util.Date parsed = format.parse(endDate);
                    java.sql.Date enddate = new java.sql.Date(parsed.getTime());

                    int pay = Integer.parseInt(paystr);
                    int due = Integer.parseInt(duestr);
                    int updatedue = due - pay;
                    ps1 = con.prepareStatement("update userplaninfo set due=? ,paid=? where lower(username) =? and expirydat =?");
                    ps1.setInt(1, updatedue);
                    ps1.setInt(2, pay);
                    ps1.setString(3, user+zone);
                    ps1.setDate(4, enddate);
                    ps1.executeUpdate();
//   out.println(strdate + " " + endDate+" "+pay+"");
                }
            }
            out.print("        </tbody>\n"
                    + "    </table>\n"
                    + "");

            response.sendRedirect("newjsp.jsp");

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
