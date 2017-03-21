package clinic.login;

import com.sun.xml.internal.ws.policy.privateutil.PolicyUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by mouizumi on 2017/3/7.
 */
public class RegisterServlet extends HttpServlet{
    public RegisterServlet(){super();}

    public void destory(){
        super.destroy();
    }

    public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
        try {
            doPost(request, response);
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
        try{
            Boolean ret = false;
            int id  = Integer.parseInt(request.getParameter("id"));
            String passwd = request.getParameter("passwd");
            String name = request.getParameter("name");
            String username = request.getParameter("username");

            DBConc dc = new DBConc();

            if(dc.checkLoginAs("0")){
                    ret = dc.RegisterCheck(id,passwd,name,username);
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("type","1");
                    if(ret == true){
                        httpSession.setAttribute("registerSuccess",true);
                        httpSession.setAttribute("name",name);
                        response.sendRedirect("../Admin/registerSuccess.jsp");
                    }else{
                        httpSession.setAttribute("registerSuccess",false);
                        response.sendRedirect("../Admin/registerSuccess.jsp");
                    }
                }else{
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("log",false);
                    response.sendRedirect("Login.jsp");
                }
        }catch(Exception e){
            e.printStackTrace();
        }
    }

}
