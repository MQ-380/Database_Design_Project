package clinic.login;

import com.google.gson.Gson;

import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

/**
 * Created by mouizumi on 2017/3/14.
 */
public class ConsultItemInformationServlet extends HttpServlet{

    public ConsultItemInformationServlet(){super();}

    public void destory(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            String item_id = request.getParameter("id");
            DBConc dc = new DBConc();
            Map<String,String> itemInformation = dc.getItemInformation(Integer.parseInt(item_id));
            String json = new Gson().toJson(itemInformation);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
