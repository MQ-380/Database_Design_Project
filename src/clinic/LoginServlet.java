package clinic; /**
 * Created by mouizumi on 2017/3/7.
 */



import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

public class LoginServlet extends HttpServlet {
    public LoginServlet(){super();}

    public void destroy(){
        super.destroy();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doPost(request, response);
    }

    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
        try{
            boolean ret = false;
            String username = request.getParameter("username");
            String passwd = request.getParameter("passwd");
            String power = request.getParameter("power");

            DBConc conc =  new DBConc();
            if(power == null) {response.sendRedirect("LoginFalse.jsp");}
            ret = conc.LoginCheck(username,passwd,power);
            if(ret){
                String[] info = conc.getInfo(username,power);
                HttpSession hs = request.getSession();
                hs.setAttribute("id",info[0]);
                hs.setAttribute("name",info[1]);
                if(power.equals("0")) response.sendRedirect("../Admin/AdminHome.jsp");
                else response.sendRedirect("../CT/CTHome.jsp");
            }else{
                response.sendRedirect("LoginFalse.jsp");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    }

}
