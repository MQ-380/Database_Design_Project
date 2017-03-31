package clinic;

import JavaBean.StayInformation;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by mouizumi on 2017/3/29.
 */
public class ConsultRoomInpatientServlet extends HttpServlet{
    public ConsultRoomInpatientServlet() {super();}

    public void destroy(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException{
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
        try{
            String room = request.getParameter("roomId");
            DBConc dc = new DBConc();

            if(dc.checkLoginAs("0")){
                ArrayList<StayInformation> stayInformations = dc.getInpatient("room",room);
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("inpatient",stayInformations);
                httpSession.setAttribute("roomId",room);
                response.sendRedirect("../Stay/ResidentRoomInformation.jsp");
            }else{
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("log",false);
                response.sendRedirect("LoginHome.jsp");
            }
        }catch (Exception e ){
            e.printStackTrace();
        }
    }
}
