package clinic;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


/**
 * Created by mouizumi on 2017/3/12.
 */
public class AddNewDoctorServlet extends HttpServlet {
    public AddNewDoctorServlet(){super();}

    public void destory(){super.destroy();}

    public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
        try{
            request.setCharacterEncoding("utf-8");

            int room = Integer.parseInt(request.getParameter("room"));
            String name = request.getParameter("name");
            String degree = request.getParameter("degree");

            DBConc dc = new DBConc();
            Boolean ret = false;

            if(dc.checkLoginAs("0")){
                int id = dc.GetNewId("doctor","doctor_id");
                ret = dc.addDoctor(id,name,room,degree);
                if(ret){
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("showAddSuccess",true);
                    httpSession.setAttribute("doctor_id",id);
                    httpSession.setAttribute("doctor_name",name);
                    httpSession.setAttribute("doctor_room",room);
                    httpSession.setAttribute("doctor_degree",degree);
                }else{
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("showAddSuccess",false);
                }
                response.sendRedirect("../Data/Doctor.jsp");
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
