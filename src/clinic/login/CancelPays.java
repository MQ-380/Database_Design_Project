package clinic.login;



import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.lang.reflect.Type;
import com.google.gson.reflect.TypeToken;
import com.google.gson.*;

/**
 * Created by mouizumi on 2017/3/21.
 */
public class CancelPays extends HttpServlet {

    public CancelPays(){super();}

    public void destory(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request,HttpServletResponse response) throws  ServletException,IOException{
        try{
            String json = request.getParameter("data");
            Type idType = new TypeToken<ArrayList<Id>>(){}.getType();
            ArrayList<Id> deleteId = new Gson().fromJson(json,idType);
            ArrayList<String> toCancel = new ArrayList<>();
            int size = deleteId.size();
            for(int i=0;i<size;i++){
                toCancel.add(deleteId.get(i).getId());
            }
            String receiptId = request.getParameter("receipt");
            DBConc dc = new DBConc();
            if(dc.cancelPays(toCancel)){
                if(!dc.checkReceiptNeed(receiptId)) {
                    dc.delete(receiptId, "receipt");
                }
                response.setContentType("text/plain");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("true");
            }else{
                response.setContentType("text/plain");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("false");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    class Id{
        String id;

        public Id(String id) {
            this.id = id;
        }

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }
    }
}
