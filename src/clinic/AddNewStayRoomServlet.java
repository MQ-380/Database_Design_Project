package clinic;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by mouizumi on 2017/3/26.
 */
public class AddNewStayRoomServlet extends HttpServlet {
    public AddNewStayRoomServlet(){super();}

    public void destroy(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException {
        try{
            String room_id = request.getParameter("roomId");
            String room_number = request.getParameter("roomNumber");

            DBConc dc = new DBConc();
            if(dc.checkLoginAs("0")) {
                if(Integer.valueOf(room_number) <= 0) {
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("addStayRoomSuccess", "noZero");
                    response.sendRedirect("../Stay/Bed.jsp");
                } else if (dc.addStayRoom(Integer.valueOf(room_id), Integer.valueOf(room_number),0)) {
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("addStayRoomSuccess", "true");
                    httpSession.setAttribute("RoomId", room_id);
                    httpSession.setAttribute("RoomNumber", room_number);
                    response.sendRedirect("../Stay/Bed.jsp");
                } else {
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("addStayRoomSuccess", "false");
                    response.sendRedirect("../Stay/Bed.jsp");
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

