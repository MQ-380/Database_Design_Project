package JavaBean;

/**
 * Created by mouizumi on 2017/3/19.
 */
public class ReceiptAndPays {
    int pays_id;
    String receipt_Date;
    double total;
    int item_id;
    int doctor_id;
    int ct_id;
    int receipt_id;
    int amount;
    String receipt_name;

    public ReceiptAndPays(int pays_id, String receipt_Date, double total, int item_id, int doctor_id, int ct_id, int receipt_id, int amount, String receipt_name) {
        this.pays_id = pays_id;
        this.receipt_Date = receipt_Date;
        this.total = total;
        this.item_id = item_id;
        this.doctor_id = doctor_id;
        this.ct_id = ct_id;
        this.receipt_id = receipt_id;
        this.amount = amount;
        this.receipt_name = receipt_name;
    }

    public int getPays_id() {
        return pays_id;
    }

    public void setPays_id(int pays_id) {
        this.pays_id = pays_id;
    }

    public String getReceipt_Date() {
        return receipt_Date;
    }

    public void setReceipt_Date(String receipt_Date) {
        this.receipt_Date = receipt_Date;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public int getItem_id() {
        return item_id;
    }

    public void setItem_id(int item_id) {
        this.item_id = item_id;
    }

    public int getDoctor_id() {
        return doctor_id;
    }

    public void setDoctor_id(int doctor_id) {
        this.doctor_id = doctor_id;
    }

    public int getCt_id() {
        return ct_id;
    }

    public void setCt_id(int ct_id) {
        this.ct_id = ct_id;
    }

    public int getReceipt_id() {
        return receipt_id;
    }

    public void setReceipt_id(int receipt_id) {
        this.receipt_id = receipt_id;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public String getReceipt_name() {
        return receipt_name;
    }

    public void setReceipt_name(String receipt_name) {
        this.receipt_name = receipt_name;
    }
}
