package clinic;

import com.sun.security.ntlm.Server;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by mouizumi on 2017/3/26.
 */
public class UpdateStayRoomServlet extends HttpServlet {
    public UpdateStayRoomServlet() {super();}

    public void destroy() {super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException{
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws  IOException,ServletException{
        try{
            int roomid = Integer.valueOf(request.getParameter("RoomId"));
            int roomCapacity = Integer.valueOf(request.getParameter("RoomNumber"));
            DBConc dc = new DBConc();

            int oldCapacity = dc.getStayRoomCapacity(Integer.valueOf(roomid));
            HttpSession httpSession = request.getSession();
            if(dc.checkLoginAs("0")) {
                if (oldCapacity != -1) {
                    if (roomCapacity > oldCapacity) {
                        if (dc.addStayRoom(roomid, roomCapacity - oldCapacity, oldCapacity)) {
                            httpSession.setAttribute("UpdateStayRoomSuccess", "true");
                            httpSession.setAttribute("room",String.valueOf(roomid));
                            httpSession.setAttribute("newCapacity", String.valueOf(roomCapacity));
                            httpSession.setAttribute("oldCapacity", String.valueOf(oldCapacity));
                            response.sendRedirect("../Stay/Bed.jsp");
                        }
                    } else if (roomCapacity < oldCapacity) {
                        if (dc.reduceStayRoomCapacity(roomid, oldCapacity - roomCapacity, oldCapacity)) {
                            httpSession.setAttribute("UpdateStayRoomSuccess", "true");
                            httpSession.setAttribute("room",String.valueOf(roomid));
                            httpSession.setAttribute("newCapacity", String.valueOf(roomCapacity));
                            httpSession.setAttribute("oldCapacity", String.valueOf(oldCapacity));
                            response.sendRedirect("../Stay/Bed.jsp");
                        } else {
                            httpSession.setAttribute("UpdateStayRoomSuccess", "CanNotReduce");
                            response.sendRedirect("../Stay/Bed.jsp");
                        }
                    } else {
                        httpSession.setAttribute("UpdateStayRoomSuccess", "noChange");
                        response.sendRedirect("../Stay/Bed.jsp");
                    }
                } else {
                    httpSession.setAttribute("UpdateStayRoomSuccess", "false");
                    response.sendRedirect("../Stay/Bed.jsp");
                }
            }else{
                httpSession.setAttribute("log",false);
                response.sendRedirect("LoginHome.jsp");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
