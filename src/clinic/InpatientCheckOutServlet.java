package clinic;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by mouizumi on 2017/4/2.
 */
public class InpatientCheckOutServlet extends HttpServlet {

    public InpatientCheckOutServlet(){super();}

    public void destroy(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException {
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException {
        try {
            String stay_id = request.getParameter("deleteId");

            DBConc dc  =  new DBConc();

            if(dc.delete(stay_id,"prescriptions") || dc.getPrescription(Integer.parseInt(stay_id)).size()==0){
                if(dc.delete(stay_id,"inpatient")){
                    dc.ChangeBedStatus(false,String.valueOf(dc.getInpatient("stay",stay_id).get(0).getBed_id()));
                    response.setContentType("text/plain");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("true");
                }else{
                    response.setContentType("text/plain");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("false");
                }
            }else{
                response.setContentType("text/plain");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("false");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
