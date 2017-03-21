package clinic.login;

import JavaBean.Doctor;
import JavaBean.DoctorReceipt;

import javax.print.Doc;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.*;

/**
 * Created by mouizumi on 2017/3/11.
 */
public class ConsultDoctorReceiptServlet extends HttpServlet {
    public ConsultDoctorReceiptServlet(){super();}

    public void destory(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request,HttpServletResponse response) throws  ServletException,IOException{
        try{
            request.setCharacterEncoding("utf-8");
            ArrayList<DoctorReceipt> receipts;
            int id = Integer.parseInt(request.getParameter("name"));
            String start = request.getParameter("start");
            String end = request.getParameter("end");


            DBConc dc = new DBConc();
            String name = dc.getDoctorName(id);
            if(dc.checkLoginAs("0")) {
                if (id != -1) {
                    receipts = dc.getDoctorReceipt(id, start, end);
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("doctorname",name);
                    httpSession.setAttribute("doctorstart",start);
                    httpSession.setAttribute("doctorend",end);
                    httpSession.setAttribute("receipts", receipts);
                    response.sendRedirect("/Admin/DoctorTable.jsp");
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
