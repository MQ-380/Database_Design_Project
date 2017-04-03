package clinic;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by mouizumi on 2017/4/3.
 */
public class AddInpatientServlet extends HttpServlet{
    public AddInpatientServlet(){super();}

    public void destroy(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
        try {
            request.setCharacterEncoding("utf-8");
            String inpatient_name = request.getParameter("inpatient_name");
            String bed = request.getParameter("inpatient_bed");
            DBConc dc = new DBConc();
            if(dc.checkLoginAs("3")){
                int resident_id = Integer.parseInt(dc.getNowResident().get(1));
                int stay_id = dc.GetNewId("inpatient","stay_id");
                int inpatient_id = dc.GetNewId("inpatient","inpatient_id");
                int bed_id = Integer.parseInt(bed);
                HttpSession httpSession = request.getSession();
                if(dc.addInpatient(inpatient_id,resident_id,inpatient_name,bed_id,stay_id)){
                    dc.ChangeBedStatus(true,bed);
                    httpSession.setAttribute("AddSuccess","true");
                    httpSession.setAttribute("name",inpatient_name);
                    httpSession.setAttribute("id",stay_id);
                    response.sendRedirect("../Stay/AddNewInpatientResult.jsp");
                }else{
                    httpSession.setAttribute("AddSuccess","false");
                    response.sendRedirect("../Stay/AddNewInpatientResult.jsp");
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
