package clinic;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by mouizumi on 2017/3/14.
 */
@WebServlet(name = "AddNewItemServlet")
public class AddNewItemServlet extends HttpServlet {

    public AddNewItemServlet(){super();}

    public void destory(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            request.setCharacterEncoding("utf-8");

            String item_id = request.getParameter("id");
            String item_name = request.getParameter("name");
            String item_price = request.getParameter("price");

            DBConc dc = new DBConc();
            Boolean ret = dc.addItem(Integer.parseInt(item_id),item_name,Double.parseDouble(item_price));
            if(dc.checkLoginAs("0")) {
                HttpSession httpSession = request.getSession();
                if (ret) {
                    httpSession.setAttribute("addItemSuccess",true);
                    httpSession.setAttribute("item_name",item_name);
                    httpSession.setAttribute("item_id",item_id);
                    httpSession.setAttribute("item_price",item_price);
                    response.sendRedirect("../Data/Item.jsp");
                }else{
                    httpSession.setAttribute("addItemSuccess",false);
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
