    /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mainpage;

import static com.sun.corba.se.spi.presentation.rmi.StubAdapter.request;
import java.sql.*;
import java.util.Calendar;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Harish
 */
public class selectExpRecords {

    public static void main(String[] args) {

        try {
 PreparedStatement ps,ps1;
 ResultSet rs ,rs1;
 int olddue = 0;

     //     HttpSession session = null;
       //    int loginid;
         //   loginid = (Integer) session.getAttribute("loginID");
         
           
            Connection con = ConClass.CClass.getConnection();
Statement stmt = con.createStatement();
             ps = con.prepareStatement("select up.username, up.planid ,max(up.expirydat),date_add(up.expirydat,INTERVAL 1 DAY) as newdate ,"
+ "date_add(date_add(up.expirydat,INTERVAL 1 DAY),INTERVAL pp.duration DAY), pp.amount  " +
"from userplaninfo up , planinfo pp where (select max(up1.expirydat) from userplaninfo up1 where up1.username = up.username) < current_date() and up.planid =pp.planid and up.loginid="+ID.LoginId.login_id+"  group by up.username;");
             rs = ps.executeQuery();
            while (rs.next()) {
               
                String user = rs.getString(1);
                int planid = rs.getInt(2);
                Date newdate = rs.getDate(4);
                Date expdat = rs.getDate(5);
                int am = rs.getInt(6);
                Date oldexp = rs.getDate(3);
     
                
                rs1 = stmt.executeQuery("select username from userplaninfo where username ='"+user+"' and expirydat = '"+expdat+"' ");
              
                if(rs1.next() == false){
                
                    stmt.executeUpdate("insert into userplaninfo values(2,'"+user+"','"+newdate+"','"+expdat+"',"+(am)+",0,"+planid+")");
                       
                }
                
             
                System.out.println(user + "  " + expdat);
            }
        } catch (Exception ex) {
System.out.println(ex);
        }
    }
}
