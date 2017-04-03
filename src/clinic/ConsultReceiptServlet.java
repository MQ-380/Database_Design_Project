package clinic;

import JavaBean.ReceiptAndPays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by mouizumi on 2017/3/19.
 */
public class ConsultReceiptServlet extends HttpServlet {

    public ConsultReceiptServlet(){super();}

    public void destroy(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request,HttpServletResponse response) throws  ServletException,IOException {
        try{
            String id = request.getParameter("id");
            DBConc dc = new DBConc();
            if(dc.checkLoginAs("1") || dc.checkLoginAs("0")) {
                ArrayList<ReceiptAndPays> receiptAndPays = dc.getReceiptsPay(Integer.parseInt(id));
                int size = receiptAndPays.size();
                //String json = new Gson().toJson(receiptAndPays);
                if (receiptAndPays.size() != 0) {
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("success", true);
                    httpSession.setAttribute("data", receiptAndPays);
                    if(dc.checkLoginAs("1")) response.sendRedirect("../CT/Cancel.jsp");
                    else response.sendRedirect("../Data/Receipt.jsp");
                } else {
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("success", false);
                    response.sendRedirect("../CT/Cancel.jsp");
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
