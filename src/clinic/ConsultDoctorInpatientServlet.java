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
public class ConsultDoctorInpatientServlet extends HttpServlet{
    public ConsultDoctorInpatientServlet() {super();}

    public void destroy(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException{
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws  IOException,ServletException{
        try{
            String id = request.getParameter("residentId");
            DBConc dc = new DBConc();
            ArrayList<StayInformation> stayInformations;

            if(dc.checkLoginAs("0")){
                if(!id.equals("-1")){
                    stayInformations =  dc.getInpatient("resident",id);
                    String residentName = dc.getResidentName(id);
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("residentName",residentName);
                    httpSession.setAttribute("inpatients",stayInformations);
                    response.sendRedirect("../Stay/ResidentStayInformation.jsp");
                }
            }else{
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("log",false);
                response.sendRedirect("LoginHome.jsp");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}


