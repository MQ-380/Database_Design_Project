package clinic;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by mouizumi on 2017/3/25.
 */
public class RegisterResidentServlet extends HttpServlet{

    public RegisterResidentServlet(){super();}

    public void destroy(){
        super.destroy();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
        try {
            doPost(request, response);
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
        try{

            request.setCharacterEncoding("utf-8");

            Boolean ret;
            int id  = Integer.parseInt(request.getParameter("id"));
            String passwd = request.getParameter("passwd");
            String username = request.getParameter("name");
            String resident_name = request.getParameter("resident");
            int roomid = Integer.parseInt(request.getParameter("roomid"));

            DBConc dc = new DBConc();

            if(dc.checkLoginAs("0")){
                ret = dc.RegisterResidentCheck(id,passwd,username,resident_name,roomid);
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("type","3");
                if(ret){
                    httpSession.setAttribute("registerResidentSuccess",true);
                    httpSession.setAttribute("userName",username);
                    httpSession.setAttribute("residentName",resident_name);
                    response.sendRedirect("../Stay/registerResidentSuccess.jsp");
                }else{
                    httpSession.setAttribute("registerResidentSuccess",false);
                    response.sendRedirect("../Stay/registerResidentSuccess.jsp");
                }
            }else{
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("log",false);
                response.sendRedirect("LoginHome.jsp");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    }

}
