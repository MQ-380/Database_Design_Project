package JavaBean;

/**
 * Created by mouizumi on 2017/3/11.
 */
public class Doctor {
    private int doctor_id;
    private String doctor_name;
    private int room_id;
    private String degree;

    public Doctor(int doctor_id, String doctor_name, int room_id, String degree) {
        this.doctor_id = doctor_id;
        this.doctor_name = doctor_name;
        this.room_id = room_id;
        this.degree = degree;
    }

    public int getDoctor_id() {
        return doctor_id;
    }


    public void setDoctor_id(int doctor_id) {
        this.doctor_id = doctor_id;
    }

    public String getDoctor_name() {
        return doctor_name;
    }

    public void setDoctor_name(String doctor_name) {
        this.doctor_name = doctor_name;
    }

    public int getRoom_id() {
        return room_id;
    }

    public void setRoom_id(int room_id) {
        this.room_id = room_id;
    }

    public String getDegree() {
        return degree;
    }

    public void setDegree(String degree) {
        this.degree = degree;
    }
}
