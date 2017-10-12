package Mail;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Harish
 */
public class mailServlet extends HttpServlet {

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
   		Properties properties = new Properties();
		FileInputStream file;
		try {
			file = new FileInputStream(
					"E:\\harish\\ISPProject\\src\\java\\Mail\\EmailConfig.properties");
			/*e.g 		file = new FileInputStream(
		"F:\\sagar\\ESC\\appClientModule\\EmailConfig.properties");*/
			properties.load(file);

			EmailConfigValue emailConfigValue = new EmailConfigValue();
			
			emailConfigValue.setServer(properties
					.getProperty("emailconfig.server"));
			emailConfigValue.setFromUserName(properties
					.getProperty("emailconfig.username"));
			emailConfigValue.setPassword(properties
					.getProperty("emailconfig.password"));
			emailConfigValue.setSmtpPort(Integer.parseInt(properties
					.getProperty("emailconfig.smtpport")));

			MessageDetailsValue messageDetailsValue = new MessageDetailsValue();
		   Connection con = ConClass.CClass.getConnection();
            Statement stmt = con.createStatement();
          ResultSet rs,rs1;
               HttpSession session = request.getSession(true);
          
            int loginid  = (Integer) session.getAttribute("loginID");

          rs1 = stmt.executeQuery("select email from logintable where loginid="+loginid+"");
         String email="";  
         while(rs1.next()){
                email = rs1.getString(1).trim();
            }
            messageDetailsValue.setTo(email);
     	      messageDetailsValue.setSubject("Expiry List of Customers");

           rs = stmt.executeQuery("select concat(pc.first_name ,' ', pc.last_name), reverse(substring(reverse(up.username),length(pa.zone)+1)),"
                    + " up.expirydat, pa.zone,pa.are, pa.buildingname , pp.planid, pp.name, pp.amount "
                    + "from userplaninfo up , addressinfo pa , customerinfo pc, planinfo pp where "
                    + "subdate(up.expirydat,interval 1 day) = current_date() and pc.username = up.username and "
                    + " pc.addressid = pa.addressid and up.planid = pp.planid and pc.loginid="+loginid+";");

            
            
            StringBuffer bf = new StringBuffer();
            bf.append("        <table border=\"1\" width=\"100%\">\n"
                    + "            <thead>\n"
                    + "                <tr>\n"
                    + "                    <th>Name</th>\n"
                    + "                    <th>Username</th>\n"
                    + "                    <th>Expiry Date</th>\n"
                    + "                    <th>Zone</th>\n"
                    + "                    <th>Area</th>\n"
                    + "                    <th>Plan Name</th>\n"
                    + "                    <th>Amount</th>\n"
                    + "                </tr>\n"
                    + "            </thead>\n"
                    + "            <tbody>\n"
                    + "");
           
            while (rs.next()) {
                String name = rs.getString(1);
                String user = rs.getString(2);
                Date exp = rs.getDate(3);
                String zone = rs.getString(4);
                String area = rs.getString(5);
                String plan = rs.getString(8);
                int am = rs.getInt(9);
                
                
                        
                        
           bf.append(" <tr>\n"
                        + "        \n"
                        + "    <td>" + name + "</td>\n"
                        + "    <td>" + user + "</td>\n"
                        + "    <td>" + exp + "</td>\n"
                        + "    <td>" + zone + "</td>\n"
                        + "    <td>" + area + "</td>\n"
                        + "    <td>" + plan + "</td>\n"
                        + "    <td>" + am + "</td>\n"
                        + "        </tr>");
                        
            }
            
            messageDetailsValue.setContent(bf.toString());
      
			mailServlet(emailConfigValue, messageDetailsValue);

        
        response.sendRedirect("HomePage.jsp");
        
                        
        response.sendRedirect("");
                }catch(Exception ex){
                    
                }   
        }
     finally {
            out.close();
        }
    }
 public  void mailServlet(EmailConfigValue emailConfigValue, MessageDetailsValue messageDetailsValue) {
        try{

			// Get system properties
			Properties sysProp = System.getProperties();

			// Setup mail server
			sysProp.put("mail.smtp.host", emailConfigValue.getServer());
			sysProp.put("mail.smtp.port", emailConfigValue.getSmtpPort());
			sysProp.put("mail.transport.protocol", "smtp");
			sysProp.put("mail.smtp.auth", "true");
			sysProp.put("mail.smtp.starttls.enable", "true");
			// getPasswordAuthentication() expect final parameters.
			final String fromUserName = emailConfigValue.getFromUserName();
			final String password = emailConfigValue.getPassword();
			Authenticator auth = new Authenticator() {
				// override the getPasswordAuthentication method
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(fromUserName, password);
				}
			};

			Session session = Session.getInstance(sysProp, auth);

			// Create a default MimeMessage object.
			MimeMessage message = new MimeMessage(session);

			// Set From: header field of the header.
			message.addHeader("Content-type", "text/HTML; charset=UTF-8");
			message.addHeader("format", "flowed");
			message.addHeader("Content-Transfer-Encoding", "8bit");

			message.setFrom(new InternetAddress(fromUserName));
			// Set To: header field of the header.
			System.out.println("asasas***"+messageDetailsValue.getTo());
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(
					messageDetailsValue.getTo()));
			// Set Subject: header field
			message.setSubject(messageDetailsValue.getSubject());

			// Send the actual HTML message, as big as you like
			message.setContent(messageDetailsValue.getContent(), "text/html");

			// Send message
			Transport.send(message);
			System.out.println("Email Sent successfully....!");
                        
                            
		} catch (MessagingException mex) {
			mex.printStackTrace();
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

 