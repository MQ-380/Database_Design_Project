package clinic;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOError;
import java.io.IOException;

/**
 * Created by mouizumi on 2017/3/24.
 */
public class StayLoginServlet extends HttpServlet {
    public StayLoginServlet(){super();}

    public void destroy(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        try{
            Boolean ret = false;
            String username = request.getParameter("username");
            String passwd = request.getParameter("passwd");
            String power = request.getParameter("power");

            if(power == null) {response.sendRedirect("LoginFalse.jsp");}
            DBConc dc = new DBConc();
            if(dc.StayLoginCheck(username,passwd,power)){
                if(power.equals("0")) response.sendRedirect("../Stay/StayAdmin.jsp");
                else response.sendRedirect("../Stay/Resident.jsp");
            }else{
                response.sendRedirect("StayLoginFalse.jsp");
            }

        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
