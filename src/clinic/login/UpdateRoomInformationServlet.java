package clinic.login;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


/**
 * Created by mouizumi on 2017/3/14.
 */
public class UpdateRoomInformationServlet extends  HttpServlet {
    public UpdateRoomInformationServlet(){super();}

    public void destory(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setCharacterEncoding("utf-8");

            DBConc dc = new DBConc();
            String id = request.getParameter("roomFormId");
            Map<String, String> roomInformation = dc.getRoomInformation(Integer.parseInt(id));
            String newName = request.getParameter("roomFormName");
            String oldName = roomInformation.get("room_name");


            Map<String, String> changedthings = new HashMap<>();
            Map<String, String> oldthings = new HashMap<>();

            if (!newName.equals(oldName)) {
                changedthings.put("room_name", newName);
                oldthings.put("room_name", oldName);
            }
            if (dc.checkLoginAs("0")) {
                if (!changedthings.isEmpty()) {
                    changedthings.put("room_id", id);

                    if (dc.UpdateRoomInformation(changedthings)) {
                        HttpSession session = request.getSession();
                        session.setAttribute("editRoomSuccess", "true");
                        session.setAttribute("room_id", id);
                        session.setAttribute("room_changed", changedthings);
                        session.setAttribute("room_old", oldthings);
                        response.sendRedirect("../Data/Room.jsp");
                    } else {
                        HttpSession session = request.getSession();
                        session.setAttribute("editRoomSuccess", "false");
                        response.sendRedirect("../Data/Room.jsp");
                    }
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("editRoomSuccess", "no");
                    response.sendRedirect("../Data/Room.jsp");
                }
            } else {
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("log", false);
                response.sendRedirect("LoginHome.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
