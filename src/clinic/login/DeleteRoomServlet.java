package clinic.login;

import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by mouizumi on 2017/3/14.
 */
public class DeleteRoomServlet extends HttpServlet{
    public DeleteRoomServlet(){super();}

    public void destory(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            String id = request.getParameter("deleteFormRoomId");

            DBConc dc = new DBConc();

            String toDeleteName = dc.getRoomName(Integer.parseInt(id));

            if(dc.checkLoginAs("0")) {
                Boolean ret = dc.delete(id, "room");
                HttpSession session = request.getSession();
                if (ret) {
                    session.setAttribute("deleteRoomSuccess", true);
                    session.setAttribute("deleteRoomName", toDeleteName);
                    response.sendRedirect("../Data/Room.jsp");
                } else {
                    session.setAttribute("deleteRoomSuccess", false);
                    response.sendRedirect("../Data/Room.jsp");
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
}
