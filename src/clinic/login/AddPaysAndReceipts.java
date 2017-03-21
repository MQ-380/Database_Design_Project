package clinic.login;

import javax.lang.model.type.ArrayType;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import com.google.gson.*;

/**
 * Created by mouizumi on 2017/3/17.
 */
public class AddPaysAndReceipts extends HttpServlet{

    public AddPaysAndReceipts(){super();}

    public void destory(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request,HttpServletResponse response) throws  ServletException,IOException {
        try{
            String json = request.getParameter("receiptInfo");
            ReceiptsInformation receiptsInformation = new Gson().fromJson(json,ReceiptsInformation.class);
            ArrayList<Pays> paysDetail = receiptsInformation.getPays();
            DBConc dc = new DBConc();
                int receipt_id = Integer.parseInt(receiptsInformation.getReceipt_id());
                String receipt_date = receiptsInformation.getDate();
                String receipt_name = receiptsInformation.getReceipt_name();
                if(dc.addReceipt(receipt_id,receipt_date,receipt_name)){
                    int size = paysDetail.size();
                    double totalPrice = 0.0;
                    Boolean goon = true;
                    for(int j=0;j<size;j++){
                        int pays_id = dc.GetNewId("pays","pays_id");
                        double total = Double.parseDouble(paysDetail.get(j).getTotal());
                        int item_id = Integer.parseInt(paysDetail.get(j).getItem_id());
                        int doctor_id = Integer.parseInt(receiptsInformation.getDoctor());
                        int ct_id = Integer.parseInt(receiptsInformation.getCt());
                        int amount = Integer.parseInt(paysDetail.get(j).getAmount());
                        if(dc.addPays(pays_id,receipt_date,total,item_id,doctor_id,ct_id,receipt_id,amount)){
                            totalPrice += total;
                        }else{
                            goon = false;
                            break;
                        }
                    }
                    String totalReturn;
                    if(goon){
                        totalReturn = String.valueOf(totalPrice);

                    }else{
                        totalReturn = String.valueOf(-1);
                    }
                    response.setContentType("text/plain");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(totalReturn);
                }
        }catch (Exception e){
           e.printStackTrace();
        }
    }

    class ReceiptsInformation{
        private String receipt_id;
        private String date;
        private String receipt_name;
        private ArrayList<Pays> pays;
        private String doctor;
        private String ct;

        public ReceiptsInformation(String receipt_id, String date, String receipt_name, ArrayList<Pays> pays, String doctor, String ct) {
            this.receipt_id = receipt_id;
            this.date = date;
            this.receipt_name = receipt_name;
            this.pays = pays;
            this.doctor = doctor;
            this.ct = ct;
        }

        public String getReceipt_id() {
            return receipt_id;
        }

        public void setReceipt_id(String receipt_id) {
            this.receipt_id = receipt_id;
        }

        public String getDate() {
            return date;
        }

        public void setDate(String date) {
            this.date = date;
        }

        public String getReceipt_name() {
            return receipt_name;
        }

        public void setReceipt_name(String receipt_name) {
            this.receipt_name = receipt_name;
        }

        public ArrayList<Pays> getPays() {
            return pays;
        }

        public void setPays(ArrayList<Pays> pays) {
            this.pays = pays;
        }

        public String getDoctor() {
            return doctor;
        }

        public void setDoctor(String doctor) {
            this.doctor = doctor;
        }

        public String getCt() {
            return ct;
        }

        public void setCt(String ct) {
            this.ct = ct;
        }
    }

    class Pays{
        private String item_id;
        private String amount;
        private String total;

        public Pays(String item_id, String amount, String total) {
            this.item_id = item_id;
            this.amount = amount;
            this.total = total;
        }

        public String getItem_id() {
            return item_id;
        }

        public void setItem_id(String item_id) {
            this.item_id = item_id;
        }

        public String getAmount() {
            return amount;
        }

        public void setAmount(String amount) {
            this.amount = amount;
        }

        public String getTotal() {
            return total;
        }

        public void setTotal(String total) {
            this.total = total;
        }
    }

}
