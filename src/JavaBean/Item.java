package JavaBean;

/**
 * Created by mouizumi on 2017/3/14.
 */
public class Item {
    private int item_id;
    private String item_name;
    private Double price;

    public Item(int item_id, String item_name, Double price) {
        this.item_id = item_id;
        this.item_name = item_name;
        this.price = price;
    }

    public int getItem_id() {
        return item_id;
    }

    public void setItem_id(int item_id) {
        this.item_id = item_id;
    }

    public String getItem_name() {
        return item_name;
    }

    public void setItem_name(String item_name) {
        this.item_name = item_name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}
