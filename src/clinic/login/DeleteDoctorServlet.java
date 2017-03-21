package clinic.login;

import com.google.gson.Gson;
import jdk.nashorn.internal.parser.JSONParser;

import javax.lang.model.type.ArrayType;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.io.IOException;

/**
 * Created by mouizumi on 2017/3/12.
 */
public class DeleteDoctorServlet extends HttpServlet {
    public DeleteDoctorServlet(){super();}

    public void destory(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
        try{
            String id = request.getParameter("deformid");

            DBConc dc = new DBConc();

            String toDeleteName = new String();

            toDeleteName= dc.getDoctorName(Integer.parseInt(id));

            if(dc.checkLoginAs("0")) {
                Boolean ret = dc.delete(id, "doctor");
                HttpSession session = request.getSession();
                if (ret) {
                    session.setAttribute("showDeleteSuccess", true);
                    session.setAttribute("deleteName", toDeleteName);
                    response.sendRedirect("../Data/Doctor.jsp");
                } else {
                    session.setAttribute("showDeleteSuccess", false);
                    response.sendRedirect("../Data/Doctor.jsp");
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



