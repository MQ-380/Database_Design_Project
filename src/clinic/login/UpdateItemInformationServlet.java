package clinic.login;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by mouizumi on 2017/3/14.
 */
public class UpdateItemInformationServlet extends HttpServlet{
    public UpdateItemInformationServlet(){super();}

    public void destory(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            request.setCharacterEncoding("utf-8");

            DBConc dc = new DBConc();
            String id = request.getParameter("itemFormId");
            Map<String,String> itemInformation = dc.getItemInformation(Integer.parseInt(id));
            String newName = request.getParameter("itemFormName");
            String oldName = itemInformation.get("item_name");
            String newPrice = request.getParameter("itemFormPrice");
            String oldPrice = itemInformation.get("item_price");


            Map<String,String> changedthings = new HashMap<>();
            Map<String,String> oldthings = new HashMap<>();

            if(!newName.equals(oldName)){
                changedthings.put("item_name",newName);
                oldthings.put("item_name",oldName);
            }
            if(!newPrice.equals(oldPrice)){
                changedthings.put("price",newPrice);
                oldthings.put("price",oldPrice);
            }
            if(dc.checkLoginAs("0")) {
                if (!changedthings.isEmpty()) {
                    changedthings.put("item_id", id);

                    if (dc.UpdateItemInformation(changedthings)) {
                        HttpSession session = request.getSession();
                        session.setAttribute("editItemSuccess", "true");
                        session.setAttribute("item_id", id);
                        session.setAttribute("item_changed", changedthings);
                        session.setAttribute("item_old", oldthings);
                        response.sendRedirect("../Data/Item.jsp");
                    } else {
                        HttpSession session = request.getSession();
                        session.setAttribute("editItemSuccess", "false");
                        response.sendRedirect("../Data/Item.jsp");
                    }
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("editItemSuccess", "no");
                    response.sendRedirect("../Data/Item.jsp");
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
