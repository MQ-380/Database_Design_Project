package clinic;

import com.google.gson.Gson;

import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

/**
 * Created by mouizumi on 2017/3/14.
 */
public class ConsultRoomInformationServlet extends HttpServlet{

    public ConsultRoomInformationServlet(){super();}

    public void destory(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            String room_id = request.getParameter("id");
            DBConc dc = new DBConc();
            Map<String,String> roomInformation = dc.getRoomInformation(Integer.parseInt(room_id));
            String json = new Gson().toJson(roomInformation);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
