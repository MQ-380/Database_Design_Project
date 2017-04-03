package JavaBean;
import java.util.*;
/**
 * Created by mouizumi on 2017/3/11.
 */
public class CTReceipt {

    private Date pays_date;
    private int item_id;
    private int receipt_id;
    private int num;
    private double amount;
    private int doctor_id;

    public CTReceipt(Date pays_date, int item_id, int receipt_id, int num, double amount, int doctor_id) {
        this.pays_date = pays_date;
        this.item_id = item_id;
        this.receipt_id = receipt_id;
        this.num = num;
        this.amount = amount;
        this.doctor_id = doctor_id;
    }

    public Date getPays_date() {
        return pays_date;
    }

    public void setPays_date(Date pays_date) {
        this.pays_date = pays_date;
    }

    public int getItem_id() {
        return item_id;
    }

    public void setItem_id(int item_id) {
        this.item_id = item_id;
    }

    public int getReceipt_id() {
        return receipt_id;
    }

    public void setReceipt_id(int receipt_id) {
        this.receipt_id = receipt_id;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public int getDoctor_id() {
        return doctor_id;
    }

    public void setDoctor_id(int doctor_id) {
        this.doctor_id = doctor_id;
    }
}
