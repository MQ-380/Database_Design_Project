package clinic;

import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by mouizumi on 2017/4/1.
 */
public class AddNewPrescription extends HttpServlet{
    public AddNewPrescription(){super();}

    public void destroy(){super.destroy();}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String json = request.getParameter("prescriptionInfo");
            Prescription prescription = new Gson().fromJson(json,Prescription.class);
            ArrayList<PrescriptionDetail> details = prescription.getPrescriptionDetails();
            int size = details.size();
            DBConc dc = new DBConc();
            for(int i=0;i<size;i++){
                PrescriptionDetail thisInfo = details.get(i);
                int prescription_id = Integer.parseInt(thisInfo.getPrescription_id());
                int item_id = Integer.parseInt(thisInfo.getItem_id());
                int resident_id = Integer.parseInt(thisInfo.getResident_id());
                int stay_id = Integer.parseInt(thisInfo.getStay_id());
                int item_count = Integer.parseInt(thisInfo.getItem_count());
                double item_total = Double.parseDouble(thisInfo.getItem_total());

                if(!dc.addPrescription(resident_id,prescription_id,stay_id,item_id,item_count,item_total)){
                    response.setContentType("text/plain");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("false");
                }
            }
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("true");
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    class PrescriptionDetail{
        private String prescription_id;
        private String item_id ;
        private String resident_id ;
        private String stay_id ;
        private String item_count;
        private String item_total;

        public PrescriptionDetail(String prescription_id, String item_id, String resident_id, String stay_id, String item_count, String item_total) {
            this.prescription_id = prescription_id;
            this.item_id = item_id;
            this.resident_id = resident_id;
            this.stay_id = stay_id;
            this.item_count = item_count;
            this.item_total = item_total;
        }

        private String getPrescription_id() {
            return prescription_id;
        }

        private String getItem_id() {
            return item_id;
        }

        private String getResident_id() {
            return resident_id;
        }

        private String getStay_id() {
            return stay_id;
        }

        private String getItem_count() {
            return item_count;
        }

        private String getItem_total() {
            return item_total;
        }
    }

    class Prescription{
        private ArrayList<PrescriptionDetail> pays;

        public Prescription(ArrayList<PrescriptionDetail> prescriptionDetails) {
            this.pays = prescriptionDetails;
        }

        public ArrayList<PrescriptionDetail> getPrescriptionDetails() {
            return pays;
        }
    }
}



