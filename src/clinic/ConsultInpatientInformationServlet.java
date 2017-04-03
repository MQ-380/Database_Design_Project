package clinic;

import JavaBean.PrescriptionsInformation;
import JavaBean.StayInformation;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by mouizumi on 2017/3/31.
 */
public class ConsultInpatientInformationServlet extends HttpServlet {
    public ConsultInpatientInformationServlet(){super();}

    public void destroy(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
        try{
            String roomId = request.getParameter("roomId");
            String bedId = request.getParameter("bedId");
            String from = request.getParameter("from");
            DBConc dc = new DBConc();
            String inpatientID = request.getParameter("InpatientID");
            int bed = -1;
            if(roomId != null) bed = dc.getBedId(roomId,bedId);
            HttpSession httpSession = request.getSession();
            if(bed!=-1 || !inpatientID.equals("")){
                ArrayList<StayInformation> stayInformation;
                if(bed!=-1) stayInformation = dc.getInpatient("bed",String.valueOf(bed));
                else stayInformation = dc.getInpatient("stay",inpatientID);
                if(stayInformation.size()!=0){
                    ArrayList<PrescriptionsInformation> prescriptionsInformations = dc.getPrescription(stayInformation.get(0).getStay_id());
                    httpSession.setAttribute("getSuccess","true");
                    httpSession.setAttribute("stayInformation",stayInformation.get(0));
                    httpSession.setAttribute("prescriptions",prescriptionsInformations);
                }else{
                    httpSession.setAttribute("getSuccess","noInpatient");
                }
            }else{
                httpSession.setAttribute("getSuccess","false");
            }
            if(from.equals("consult")) response.sendRedirect("../Stay/InpatientInformation.jsp");
            else if(from.equals("cancel")) response.sendRedirect("../Stay/Cancel.jsp");
        }catch(Exception e){

            e.printStackTrace();
        }
    }
}
