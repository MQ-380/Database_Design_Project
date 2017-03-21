package JavaBean;

import  java.util.*;
import java.util.function.DoubleToIntFunction;

/**
 * Created by mouizumi on 2017/3/11.
 */
public class DoctorReceipt {

    Date receiptDate;
    int receipt_id;
    int num;
    double amount;
    int item_id;

    public DoctorReceipt(Date receiptDate, int receipt_id, int num, double amount, int item_id) {
        this.receiptDate = receiptDate;
        this.receipt_id = receipt_id;
        this.num = num;
        this.amount = amount;
        this.item_id = item_id;
    }

    public Date getReceiptDate() {
        return receiptDate;
    }

    public void setReceiptDate(Date receiptDate) {
        this.receiptDate = receiptDate;
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

    public int getItem_id() {
        return item_id;
    }

    public void setItem_id(int item_id) {
        this.item_id = item_id;
    }
}
