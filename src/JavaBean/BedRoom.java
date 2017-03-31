package JavaBean;

/**
 * Created by mouizumi on 2017/3/26.
 */
public class BedRoom {
    private String bed_room;
    private int bed_room_count;

    public BedRoom(String bed_room, int bed_room_count) {
        this.bed_room = bed_room;
        this.bed_room_count = bed_room_count;
    }

    public String getBed_room() {
        return bed_room;
    }

    public void setBed_room(String bed_room) {
        this.bed_room = bed_room;
    }

    public int getBed_room_count() {
        return bed_room_count;
    }

    public void setBed_room_count(int bed_room_count) {
        this.bed_room_count = bed_room_count;
    }
}
