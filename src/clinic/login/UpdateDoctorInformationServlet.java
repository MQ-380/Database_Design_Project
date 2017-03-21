package clinic.login;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;
import java.rmi.server.ExportException;

/**
 * Created by mouizumi on 2017/3/13.
 */
@WebServlet(name = "UpdateDoctorInformationServlet")
public class UpdateDoctorInformationServlet extends HttpServlet {
    public UpdateDoctorInformationServlet(){super();}

    public void destory(){super.destroy();}

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            request.setCharacterEncoding("utf-8");

            DBConc dc = new DBConc();
            String id = request.getParameter("formid");
            Map<String,String> doctorInformation = dc.getDoctorInformation(Integer.parseInt(id));
            String newName = request.getParameter("formname");
            String oldName = doctorInformation.get("name");
            int newRoom = Integer.parseInt(request.getParameter("formroom"));
            int oldRoom = Integer.parseInt(doctorInformation.get("room"));
            String newDegree = request.getParameter("formdegree");
            String oldDegree = doctorInformation.get("degree");

            Map<String,String> changedthings = new HashMap<>();
            Map<String,String> oldthings = new HashMap<>();

            if(!newName.equals(oldName)){
                changedthings.put("doctor_name",newName);
                oldthings.put("doctor_name",oldName);
            }
            if(newRoom!=oldRoom){
                changedthings.put("room_id",String.valueOf(newRoom));
                oldthings.put("room_id",String.valueOf(oldRoom));
            }
            if(!newDegree.equals(oldDegree)){
                changedthings.put("degree",newDegree);
                oldthings.put("degree",oldDegree);
            }
            if(dc.checkLoginAs("0")) {
                if (!changedthings.isEmpty()) {
                    changedthings.put("doctor_id", id);

                    if (dc.UpdateDoctorInformation(changedthings)) {
                        HttpSession session = request.getSession();
                        session.setAttribute("showEditSuccess", "true");
                        session.setAttribute("doctor_id", id);
                        session.setAttribute("changed", changedthings);
                        session.setAttribute("old", oldthings);
                        response.sendRedirect("../Data/Doctor.jsp");
                    } else {
                        HttpSession session = request.getSession();
                        session.setAttribute("showEditSuccess", "false");
                        response.sendRedirect("../Data/Doctor.jsp");
                    }
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("showEditSuccess", "no");
                    response.sendRedirect("../Data/Doctor.jsp");
                }
            }else{
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("log",false);
                response.sendRedirect("Login.jsp");
            }
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
