package clinic.login;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;
import com.google.gson.Gson;

/**
 * Created by mouizumi on 2017/3/12.
 */
public class ConsultDoctorInformationServlet extends HttpServlet{
    public ConsultDoctorInformationServlet(){super();}

    public void destory(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        try{
            String dc_id = request.getParameter("id");
            DBConc dc = new DBConc();
            Map <String,String> doctorInformation = dc.getDoctorInformation(Integer.parseInt(dc_id));
            String json = new Gson().toJson(doctorInformation);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
