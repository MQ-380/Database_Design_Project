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
public class DeleteStayRoomServlet extends HttpServlet {
    public DeleteStayRoomServlet(){super();}

    public void destory(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException{
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException {
        try{
            String roomId = request.getParameter("RoomId");

            DBConc dc = new DBConc();
            if(dc.checkLoginAs("0")) {
                if (dc.delete(roomId, "bed")) {
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("DeleteStayRoomSuccess", true);
                    httpSession.setAttribute("DeleteRoomId",roomId);
                    response.sendRedirect("../Stay/Bed.jsp");
                } else {
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("DeleteStayRoomSuccess", false);
                    response.sendRedirect("../Stay/Bed.jsp");
                }
            }else{
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("log",false);
                response.sendRedirect("LoginHome.jsp");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    }

}
