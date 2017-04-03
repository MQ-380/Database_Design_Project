package JavaBean;

/**
 * Created by mouizumi on 2017/4/1.
 */
public class PrescriptionsInformation {
    private int resident_id;
    private int prescription_id;
    private int stay_id;
    private int item_id;
    private int item_count;
    private double item_total;

    public PrescriptionsInformation(int resident_id, int prescription_id, int stay_id, int item_id, int item_count, double item_total) {
        this.resident_id = resident_id;
        this.prescription_id = prescription_id;
        this.stay_id = stay_id;
        this.item_id = item_id;
        this.item_count = item_count;
        this.item_total = item_total;
    }

    public int getItem_count() {
        return item_count;
    }

    public double getItem_total() {
        return item_total;
    }

    public int getResident_id() {
        return resident_id;
    }

    public int getPrescription_id() {
        return prescription_id;
    }

    public int getStay_id() {
        return stay_id;
    }

    public int getItem_id() {
        return item_id;
    }
}
