package JavaBean;

/**
 * Created by mouizumi on 2017/3/26.
 */
public class Bed {
    private String id;
    private String bed_room;
    private String bed_no;
    private Boolean bed_status;

    public Bed(String id, String bed_room, String bed_no,Boolean bed_status) {
        this.id = id;
        this.bed_room = bed_room;
        this.bed_no = bed_no;
        this.bed_status = bed_status;
    }

    public Boolean getBed_status() {
        return bed_status;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBed_room() {
        return bed_room;
    }

    public void setBed_room(String bed_room) {
        this.bed_room = bed_room;
    }

    public String getBed_no() {
        return bed_no;
    }

    public void setBed_no(String bed_no) {
        this.bed_no = bed_no;
    }
}
