package clinic.login;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by mouizumi on 2017/3/14.
 */
public class AddNewRoomServlet extends HttpServlet{
    public AddNewRoomServlet(){super();}

    public void destory(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            request.setCharacterEncoding("utf-8");

            String room_id = request.getParameter("id");
            String room_name = request.getParameter("name");

            DBConc dc = new DBConc();
            Boolean ret = dc.addRoom(Integer.parseInt(room_id),room_name);
            if(dc.checkLoginAs("0")) {
                HttpSession httpSession = request.getSession();
                if (ret) {
                    httpSession.setAttribute("addRoomSuccess",true);
                    httpSession.setAttribute("room_name",room_name);
                    httpSession.setAttribute("room_id",room_id);
                    response.sendRedirect("../Data/Room.jsp");
                }else{
                    httpSession.setAttribute("addRoomSuccess",false);
                    response.sendRedirect("../Data/Room.jsp");
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

