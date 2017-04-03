package clinic;

import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by mouizumi on 2017/3/14.
 */
public class DeleteItemServlet extends HttpServlet{
    public DeleteItemServlet(){super();}

    public void destroy(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            String id = request.getParameter("deleteFormItemId");

            DBConc dc = new DBConc();

            String toDeleteName = dc.getItemName(Integer.parseInt(id));

            if(dc.checkLoginAs("0")) {
                Boolean ret = dc.delete(id, "item");
                HttpSession session = request.getSession();
                if (ret) {
                    session.setAttribute("deleteItemSuccess", true);
                    session.setAttribute("deleteItemName", toDeleteName);
                    response.sendRedirect("../Data/Item.jsp");
                } else {
                    session.setAttribute("deleteItemSuccess", false);
                    response.sendRedirect("../Data/Item.jsp");
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
