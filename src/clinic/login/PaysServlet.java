package clinic.login;

/**
 * Created by mouizumi on 2017/3/10.
 */

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.http.HTTPException;

import java.io.IOException;

public class PaysServlet extends HttpServlet {
    public PaysServlet() {super();}

    public void destory() {super.destroy();}

    public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
        try {
            response.sendRedirect("/Receipt/Receipt.jsp");
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
