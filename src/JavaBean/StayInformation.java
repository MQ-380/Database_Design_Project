package JavaBean;

/**
 * Created by mouizumi on 2017/3/29.
 */
public class StayInformation {
    int inpatient_id;
    int resident_id;
    String inpatient_name;
    int bed_id;
    int stay_id;

    public StayInformation(int inpatient_id, int resident_id, String inpatient_name, int bed_id, int stay_id) {
        this.inpatient_id = inpatient_id;
        this.resident_id = resident_id;
        this.inpatient_name = inpatient_name;
        this.bed_id = bed_id;
        this.stay_id = stay_id;
    }

    public int getInpatient_id() {
        return inpatient_id;
    }

    public int getResident_id() {
        return resident_id;
    }

    public String getInpatient_name() {
        return inpatient_name;
    }

    public int getBed_id() {
        return bed_id;
    }

    public int getStay_id() {
        return stay_id;
    }
}
