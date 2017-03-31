package clinic;
/**
 * Created by mouizumi on 2017/3/7.
 */

import java.sql.*;
import java.util.ArrayList;
import java.util.*;

import JavaBean.*;
import com.sun.org.apache.regexp.internal.RE;

public class DBConc {
    private static Connection conc = null;
    private static String loginPower = null;
    private static String nowCTUserId = "-1";
    private static String nowResidentId = "-1";

    public static Connection getConn(){
        try{
            String url = "jdbc:mysql://localhost:3306/hospital?characterEncoding=utf-8";
            Class.forName("com.mysql.jdbc.Driver");
            conc = DriverManager.getConnection(url,"root","65433858-maoquan");
            return conc;
        }catch(Exception e){
            System.err.println("Error"+e.getMessage());
            return null;
        }
    }


    public void closeConnection(){
        try{
            conc.close();
        }catch(Exception e){
            System.err.println("Error"+e.getMessage());
        }
    }

    public boolean LoginCheck(String id,String passwd,String power){
        //power 0 - Admin  1 - toll_collector;
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql;
            if(power.equals("0")){
                sql = "select * from admin where user_name='"+id+"'and passwd='"+passwd+"'";
            }else{
                sql = "select * from toll_collector where user_id='"+id+"'and passwd='"+passwd+"'";
            }
            ResultSet rs = stat.executeQuery(sql);
            if(rs.next()){
                loginPower = power;
                if(power.equals("1")) nowCTUserId = id;
                return true;
            }else{
                return false;
            }
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }finally{
            dc.closeConnection();
        }
    }

    public boolean StayLoginCheck(String id,String passwd,String power){
        //power 0 - Admin  1 - toll_collector;
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql;
            if(power.equals("0")){
                sql = "select * from admin where user_name='"+id+"'and passwd='"+passwd+"'";
            }else{
                sql = "select * from resident where username='"+id+"'and passwd='"+passwd+"'";
            }
            ResultSet rs = stat.executeQuery(sql);
            if(rs.next()){
                loginPower = power;
                if(power.equals("3")) nowResidentId = id;
                return true;
            }else{
                return false;
            }
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }finally{
            dc.closeConnection();
        }
    }

    public Boolean checkLoginAs(String power){
        if(power.equals(loginPower)) return true;
        else return false;
    }



    public String getNowCT(){
       String[] info = getInfo(nowCTUserId,"1");
       return info[1];
    }

    public String getNowCTID(){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql;

                sql = "select ct_id from toll_collector where user_id='"+nowCTUserId+"'";
                ResultSet rs = stat.executeQuery(sql);
                if(rs.next()){
                    return String.valueOf(rs.getInt("ct_id"));
                }
                return "-1";
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }finally {
            dc.closeConnection();
        }
    }

    public void logOut(){
        loginPower="-1";
    }

    public String[] getInfo(String username,String power){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql;
            String[] info = new String[2];
            if(power.equals("0")){
                sql = "select * from admin where user_name='"+username+"'";
                ResultSet rs = stat.executeQuery(sql);
                if(rs.next()){
                    info[0] = rs.getString("user_name");
                    info[1] = rs.getString("power");
                    return info;
                }
            }else {
                sql = "select * from toll_collector where user_id='" + username + "'";
                ResultSet rs = stat.executeQuery(sql);
                if(rs.next()) {
                    info[0] = rs.getString("user_id");
                    info[1] = rs.getString("ct_name");
                    return info;
                }
            }
            return null;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }finally {
            dc.closeConnection();
        }
    }

    public Boolean RegisterCheck(int id,String passwd,String name,String username){
        Connection conc;
        PreparedStatement pstat;
        DBConc cc = new DBConc();
        conc = cc.getConn();

        try{
            Statement stat = conc.createStatement();
            String sql;
            sql = "insert into toll_collector(ct_id,passwd,ct_name,user_id) value(?,?,?,?)";
            pstat = conc.prepareStatement(sql);
            pstat.setInt(1,id);
            pstat.setString(2,passwd);
            pstat.setString(3,username);
            pstat.setString(4,name);

            int n = 0;
            n = pstat.executeUpdate();

            if(n>0){
                return true;
            }else{
                return false;
            }

        }catch(Exception e){
            e.printStackTrace();
            return false;
        }finally {
            cc.closeConnection();
        }
    }

    public Boolean RegisterAdminCheck(int id,String passwd,String name,String power){
        Connection conc;
        PreparedStatement pstat;
        DBConc cc = new DBConc();
        conc = cc.getConn();

        try{
            Statement stat = conc.createStatement();
            String sql;
            sql = "insert into admin(id,passwd,power,user_name) value(?,?,?,?)";
            pstat = conc.prepareStatement(sql);
            pstat.setInt(1,id);
            pstat.setString(2,passwd);
            pstat.setString(3,power);
            pstat.setString(4,name);

            int n = 0;
            n = pstat.executeUpdate();

            if(n>0){
                return true;
            }else{
                return false;
            }

        }catch(Exception e){
            e.printStackTrace();
            return false;
        }finally {
            cc.closeConnection();
        }
    }

    public Boolean RegisterResidentCheck(int id,String passwd,String name,String resident_name,int room_id){
        Connection conc;
        PreparedStatement pstat;
        DBConc cc = new DBConc();
        conc = cc.getConn();

        try{
            Statement stat = conc.createStatement();
            String sql;
            sql = "insert into resident(id,username,passwd,resident_name,room_id) value(?,?,?,?,?)";
            pstat = conc.prepareStatement(sql);
            pstat.setInt(1,id);
            pstat.setString(2,name);
            pstat.setString(3,passwd);
            pstat.setString(4,resident_name);
            pstat.setInt(5,room_id);

            int n = 0;
            n = pstat.executeUpdate();

            if(n>0){
                return true;
            }else{
                return false;
            }

        }catch(Exception e){
            e.printStackTrace();
            return false;
        }finally {
            cc.closeConnection();
        }
    }

    public int GetNewId(String table,String column){
        Connection conc;
        PreparedStatement pstat;
        DBConc cc = new DBConc();
        conc = cc.getConn();

        try{
            Statement stat = conc.createStatement();
            int newId = 1;
            String sql = "select "+column+" from "+table+" Order by  "+column+" DESC";
            ResultSet rs = stat.executeQuery(sql);
            if(rs.next()){
                newId = Integer.valueOf(rs.getString(column))+1;

            }

           return newId;

        }catch (Exception e){
            e.printStackTrace();
            return 1;
        }
    }


    public Map<String,String> getDoctorInformation(int dc_id){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql;
            Map<String,String> doctorInformation = new LinkedHashMap<>();
            sql = "select * from doctor where doctor_id="+dc_id+";";
            ResultSet rs = stat.executeQuery(sql);
            if(rs.next()) {
                doctorInformation.put("id", String.valueOf(dc_id));
                doctorInformation.put("room", String.valueOf(rs.getInt("room_id")));
                doctorInformation.put("degree", rs.getString("degree"));
                doctorInformation.put("name", rs.getString("doctor_name"));
            }
            return doctorInformation;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }finally {
            dc.closeConnection();
        }
    }

    public Map<String,String> getItemInformation(int item_id){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql;
            Map<String,String> itemInformation = new LinkedHashMap<>();
            sql = "select * from item where item_id="+item_id+";";
            ResultSet rs = stat.executeQuery(sql);
            if(rs.next()) {
               itemInformation.put("item_id",String.valueOf(rs.getInt("item_id")));
               itemInformation.put("item_name",rs.getString("item_name"));
               itemInformation.put("item_price",String.valueOf(rs.getDouble("price")));
            }
            return itemInformation;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }finally {
            dc.closeConnection();
        }
    }

    public Map<String,String> getRoomInformation(int room_id){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql;
            Map<String,String> roomInformation = new LinkedHashMap<>();
            sql = "select * from room where room_id="+room_id+";";
            ResultSet rs = stat.executeQuery(sql);
            if(rs.next()) {
                roomInformation.put("room_id",String.valueOf(rs.getInt("room_id")));
                roomInformation.put("room_name",rs.getString("room_name"));
            }
            return roomInformation;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }finally {
            dc.closeConnection();
        }
    }

    public Map<String,String> getDoctor(){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql;
            Map<String,String> r = new HashMap<>();
                sql = "select doctor_name,doctor_id from doctor";
                ResultSet rs = stat.executeQuery(sql);
                while(rs.next()){
                    r.put(String.valueOf(rs.getInt("doctor_id")),rs.getString("doctor_name"));
                }
            return r;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }finally {
            dc.closeConnection();
        }
    }


    public Map<String,String> getResident(){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql = "select resident_name,id from resident";
            Map<String,String> ans = new HashMap<>();
            ResultSet rs = stat.executeQuery(sql);
            while(rs.next()){
                ans.put(String.valueOf(rs.getInt("id")),rs.getString("resident_name"));
            }
            return ans;
        }catch (Exception e){
            e.printStackTrace();
            return new HashMap<>();
        }finally {
            dc.closeConnection();
        }
    }

    public Map<String,String> getCT(){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql;
            Map<String,String> r = new HashMap<>();
            sql = "select ct_name,ct_id from toll_collector";
            ResultSet rs = stat.executeQuery(sql);
            while(rs.next()){
                r.put(String.valueOf(rs.getInt("ct_id")),rs.getString("ct_name"));
            }
            return r;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }finally {
            dc.closeConnection();
        }
    }

    public Map<String,String> getRoom(){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql;
            Map<String,String> r = new HashMap<>();
            sql = "select room_name,room_id from room";
            ResultSet rs = stat.executeQuery(sql);
            while(rs.next()){
               r.put(String.valueOf(rs.getInt("room_id")),rs.getString("room_name"));
            }
            return r;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }finally {
            dc.closeConnection();
        }
    }

    public ArrayList<DoctorReceipt> getDoctorReceipt(int doctor_id,String start,String end){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql;
            sql = "select pays_date,item_id,receipt_id,total,amount from pays where pays_date between'"+start+"' AND '"+end+"' && doctor_id="+doctor_id+";";
            ResultSet rs = stat.executeQuery(sql);
            ArrayList<DoctorReceipt> receipts = new ArrayList<DoctorReceipt>();
            while(rs.next()){
                DoctorReceipt doctorReceipt = new DoctorReceipt(rs.getDate("pays_date"),rs.getInt("receipt_id"),rs.getInt("amount"),rs.getDouble("total"),rs.getInt("item_id"));
                receipts.add(doctorReceipt);
            }
            return receipts;
        }catch(Exception e){
            e.printStackTrace();
            return new ArrayList<DoctorReceipt>();
        }finally {
            dc.closeConnection();
        }
    }

    //CTReceipt

    public ArrayList<CTReceipt> getCTReceipt(int ct_id,String start,String end) {
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try {
            Statement stat = conn.createStatement();
            String sql;
            sql = "select pays_date,item_id,receipt_id,total,amount,doctor_id from pays where pays_date between'" + start + "' AND '" + end + "' && ct_id=" + ct_id + ";";
            ResultSet rs = stat.executeQuery(sql);
            ArrayList<CTReceipt> receipts = new ArrayList<CTReceipt>();
            while (rs.next()) {
                CTReceipt ctReceipt = new CTReceipt(rs.getDate("pays_date"), rs.getInt("item_id"), rs.getInt("receipt_id"), rs.getInt("amount"), rs.getDouble("total"), rs.getInt("doctor_id"));
                receipts.add(ctReceipt);
            }
            return receipts;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<CTReceipt>();
        } finally {
            dc.closeConnection();
        }
    }

    public ArrayList<ReceiptAndPays> getReceiptsPay(int r_id) {
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try {
            Statement stat = conn.createStatement();
            String sql;
            sql = "select pays_date,item_id,receipt_id,total,amount,doctor_id,pays_id,total,ct_id from pays where receipt_id=" + r_id + ";";
            ResultSet rs = stat.executeQuery(sql);
            ArrayList<ReceiptAndPays> receipts = new ArrayList<>();
            while (rs.next()) {
                ReceiptAndPays receiptAndPays = new ReceiptAndPays(rs.getInt("pays_id"),rs.getString("pays_date"),rs.getDouble("total"),
                        rs.getInt("item_id"),rs.getInt("doctor_id"),rs.getInt("ct_id"),rs.getInt("receipt_id"),rs.getInt("amount"),getReceiptName(r_id));
                receipts.add(receiptAndPays);
            }
            return receipts;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            dc.closeConnection();
        }
    }

    public ArrayList<ReceiptAndPays> getAllPays() {
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try {
            Statement stat = conn.createStatement();
            String sql;
            sql = "select pays_date,item_id,receipt_id,total,amount,doctor_id,pays_id,total,ct_id from pays;";
            ResultSet rs = stat.executeQuery(sql);
            ArrayList<ReceiptAndPays> receipts = new ArrayList<>();
            while (rs.next()) {
                ReceiptAndPays receiptAndPays = new ReceiptAndPays(rs.getInt("pays_id"),rs.getString("pays_date"),rs.getDouble("total"),
                        rs.getInt("item_id"),rs.getInt("doctor_id"),rs.getInt("ct_id"),rs.getInt("receipt_id"),rs.getInt("amount"),"");
                receiptAndPays.setReceipt_name(getReceiptName(rs.getInt("receipt_id")));
                receipts.add(receiptAndPays);
            }
            return receipts;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            dc.closeConnection();
        }
    }

    public ArrayList<StayInformation> getInpatient(String type,String id){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try {
            Statement stat = conn.createStatement();
            String sql = "";
            if(type.equals("resident")) {
                sql = "select * from inpatient where resident_id =" + id;
            }else if(type.equals("room")){
                sql = "select * from inpatient where bed_id in (SELECT  bed_id from bed where bed_room="+id+")";
            }
            ResultSet rs = stat.executeQuery(sql);
            ArrayList<StayInformation> stayInformations   = new ArrayList<>();
            while (rs.next()) {
                int inpaitent_id = rs.getInt("inpatient_id");
                int resident_id = rs.getInt("resident_id");
                String inpatient_name = rs.getString("inpatient_name");
                int bed_id = rs.getInt("bed_id");
                int stay_id = rs.getInt("stay_id");
                StayInformation stayInformation = new StayInformation(inpaitent_id,resident_id,inpatient_name,bed_id,stay_id);
                stayInformations.add(stayInformation);
            }
            return stayInformations;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            dc.closeConnection();
        }
    }




    public String getReceiptName(int receipt_id){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql = "select receipt_name from receipt where receipt_id="+receipt_id+";";
            ResultSet rs = stat.executeQuery(sql);
            String receiptName = new String();
            if(rs.next()){
                receiptName = rs.getString("receipt_name");
            }
            return receiptName;
        }catch (Exception e){
            e.printStackTrace();
            return new String();
        }finally {
            dc.closeConnection();
        }
    }

    public String getItemName(int item_id){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql;
            sql = "select item_name from item where item_id="+item_id+";";
            ResultSet rs = stat.executeQuery(sql);
            String itemName = new String();
            if(rs.next()){
                itemName = rs.getString("item_name");
            }
            return itemName;
        }catch(Exception e){
            e.printStackTrace();
            return new String();
        }finally {
            dc.closeConnection();
        }
    }

    public String getDoctorName(int doctor_id){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql;
            sql = "select doctor_name from doctor where doctor_id="+doctor_id+";";
            ResultSet rs = stat.executeQuery(sql);
            String doctorName = new String();
            if(rs.next()){
                doctorName = rs.getString("doctor_name");
            }
            return doctorName;
        }catch(Exception e){
            e.printStackTrace();
            return new String();
        }finally {
            dc.closeConnection();
        }
    }

    public String getCTName(int ct_id){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql;
            sql = "select ct_name from toll_collector where ct_id="+ct_id+";";
            ResultSet rs = stat.executeQuery(sql);
            String ctName = new String();
            if(rs.next()){
                ctName = rs.getString("ct_name");
            }
            return ctName;
        }catch(Exception e){
            e.printStackTrace();
            return new String();
        }finally {
            dc.closeConnection();
        }
    }

    public Map<String,String> getBedRoomAndNumber(String bed_id){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql;
            sql = "select bed_room,bed_no from bed where bed_id="+bed_id+";";
            ResultSet rs = stat.executeQuery(sql);
            Map<String,String> bed = new HashMap<>();
            if(rs.next()){
                String bed_room =  String.valueOf(rs.getInt("bed_room"));
                String bed_no = String.valueOf(rs.getInt("bed_no"));
                bed.put("room",bed_room);
                bed.put("number",bed_no);
            }
            return bed;
        }catch(Exception e){
            e.printStackTrace();
            return new HashMap<>();
        }finally {
            dc.closeConnection();
        }
    }

    public String getResidentName(String id){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql;
            sql = "select resident_name from resident where id="+id+";";
            ResultSet rs = stat.executeQuery(sql);
            String residentName = new String();
            if(rs.next()){
                residentName = rs.getString("resident_name");
            }
            return residentName;
        }catch(Exception e){
            e.printStackTrace();
            return new String();
        }finally {
            dc.closeConnection();
        }
    }

    public String getRoomName(int room_id){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql;
            sql = "select room_name from room where room_id="+room_id+";";
            ResultSet rs = stat.executeQuery(sql);
            String roomName = new String();
            if(rs.next()){
                roomName = rs.getString("room_name");
            }
            return roomName;
        }catch(Exception e){
            e.printStackTrace();
            return new String();
        }finally {
            dc.closeConnection();
        }
    }

    public ArrayList<Doctor> getAllDoctor(){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql = "select * from doctor";
            ResultSet rs = stat.executeQuery(sql);
            ArrayList<Doctor> doctors = new ArrayList<Doctor>();
            while(rs.next()){
                int doctor_id = rs.getInt("doctor_id");
                int room_id = rs.getInt("room_id");
                String doctor_name = rs.getString("doctor_name");
                String degree = rs.getString("degree");
                Doctor doctor = new Doctor(doctor_id,doctor_name,room_id,degree);
                doctors.add(doctor);
            }
            return doctors;
        }catch (Exception e){
            e.printStackTrace();
            return new ArrayList<Doctor>();
        }finally {
            dc.closeConnection();
        }
    }

    public ArrayList<Item> getAllItems(){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql = "select * from item";
            ResultSet rs = stat.executeQuery(sql);
            ArrayList<Item> items = new ArrayList<>();
            while(rs.next()){
                int item_id = rs.getInt("item_id");
                String item_name = rs.getString("item_name");
                Double price = rs.getDouble("price");
                Item item = new Item(item_id,item_name,price);
                items.add(item);
            }
            return items;
        }catch (Exception e){
            e.printStackTrace();
            return new ArrayList<Item>();
        }finally {
            dc.closeConnection();
        }
    }

    public ArrayList<Room> getAllRooms(){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql = "select * from room";
            ResultSet rs = stat.executeQuery(sql);
            ArrayList<Room> rooms = new ArrayList<>();
            while(rs.next()){
                int room_id = rs.getInt("room_id");
                String room_name = rs.getString("room_name");
                Room room = new Room(room_id,room_name);
                rooms.add(room);
            }
            return rooms;
        }catch (Exception e){
            e.printStackTrace();
            return new ArrayList<Room>();
        }finally {
            dc.closeConnection();
        }
    }




    public ArrayList<BedRoom> getAllBedNumberOfRoom(){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql = "select bed_room,count(bed_room) as bedNumber from bed group by bed_room HAVING bedNumber>0";
            ResultSet rs = stat.executeQuery(sql);
            ArrayList<BedRoom> rooms = new ArrayList<>();
            while(rs.next()){
                String bed_room = String.valueOf(rs.getInt("bed_room"));
                int bed_number = rs.getInt("bedNumber");
                BedRoom bedRoom = new BedRoom(bed_room,bed_number);
                rooms.add(bedRoom);
            }
            return rooms;
        }catch (Exception e){
            e.printStackTrace();
            return new ArrayList<>();
        }finally {
            dc.closeConnection();
        }
    }



    public int getStayRoomCapacity(int room_id){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();

        try{
            Statement stat = conn.createStatement();
            String sql = "select bed_room,count(bed_room) as bedNumber from bed group by bed_room HAVING bedNumber>0 AND bed_room="+room_id;
            ResultSet rs = stat.executeQuery(sql);

            if(rs.next()){
                return rs.getInt("bedNumber");
            }
            return 0;
        }catch (Exception e){
            e.printStackTrace();
            return -1;
        }finally {
            dc.closeConnection();
        }
    }

    public Boolean addDoctor(int id,String name,int room,String degree){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();
        PreparedStatement preparedStatement;

        try{

            String sql = "insert into doctor(doctor_id,doctor_name,room_id,degree) value(?,?,?,?)";
            preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setInt(1,id);
            preparedStatement.setString(2,name);
            preparedStatement.setInt(3,room);
            preparedStatement.setString(4,degree);
            int n = 0;
            n = preparedStatement.executeUpdate();

            if(n>0){
                return true;
            }else{
                return false;
            }
        }catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }




    public Boolean addItem(int id,String name,double price){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();
        PreparedStatement preparedStatement;

        try{

            String sql = "insert into item(item_id,item_name,price) value(?,?,?)";
            preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setInt(1,id);
            preparedStatement.setString(2,name);
            preparedStatement.setDouble(3,price);

            int n = preparedStatement.executeUpdate();

            if(n>0){
                return true;
            }else{
                return false;
            }
        }catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean addRoom(int id,String name){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();
        PreparedStatement preparedStatement;

        try{

            String sql = "insert into room(room_id,room_name) value(?,?)";
            preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setInt(1,id);
            preparedStatement.setString(2,name);

            int n = preparedStatement.executeUpdate();

            if(n>0){
                return true;
            }else{
                return false;
            }
        }catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean addStayRoom(int id,int number,int oldCapacity){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();
        PreparedStatement preparedStatement;

        try{
            StringBuffer sqlBuffer = new StringBuffer();
            int newId = dc.GetNewId("bed","bed_id");
            for(int i=0;i<number;i++){
                if(i!=0) sqlBuffer.append(",");
                sqlBuffer.append("('"+(newId+i)+"','"+id+"','"+(oldCapacity+i+1)+"')");
            }

            String sql = "insert into bed(bed_id, bed_room, bed_no)  value "+ sqlBuffer.toString();
            preparedStatement = conn.prepareStatement(sql);

            int n = preparedStatement.executeUpdate();

            if(n>0){
                return true;
            }else{
                return false;
            }
        }catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean addReceipt(int id,String date,String receipt_name){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();
        PreparedStatement preparedStatement;

        try{
            String sql = "insert into receipt(receipt_id,receipt_date,receipt_name) value(?,?,?)";
            preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setInt(1,id);
            preparedStatement.setString(2,date);
            preparedStatement.setString(3,receipt_name);

            int n = preparedStatement.executeUpdate();
            if(n>0){
                return true;
            }else{
                return false;
            }
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public Boolean addPays(int id,String date,double total,int item_id,int doctor_id,int ct_id,int receipt_id,int amount){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();
        PreparedStatement preparedStatement;

        try{
            String sql = "insert into pays(pays_id,pays_date,total,item_id,doctor_id,ct_id,receipt_id,amount) value(?,?,?,?,?,?,?,?)";
            preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setInt(1,id);
            preparedStatement.setString(2,date);
            preparedStatement.setDouble(3,total);
            preparedStatement.setInt(4,item_id);
            preparedStatement.setInt(5,doctor_id);
            preparedStatement.setInt(6,ct_id);
            preparedStatement.setInt(7,receipt_id);
            preparedStatement.setInt(8,amount);

            int n = preparedStatement.executeUpdate();
            if(n>0){
                return true;
            }else{
                return false;
            }
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public Boolean UpdateDoctorInformation(Map<String,String> newDoctorInformation){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();
        PreparedStatement preparedStatement;

        try{
            Statement statement = conn.createStatement();
            StringBuffer tmp = new StringBuffer();
            for(Map.Entry<String,String> entry: newDoctorInformation.entrySet()){

                if(!entry.getKey().equals("doctor_id")) {
                    if(tmp.length()!=0) tmp.append(",");
                    tmp.append(entry.getKey() + "='" + entry.getValue() + "'");
                }
            }
            String temp = tmp.toString();
            String sql = "update doctor set "+temp+" where doctor_id="+newDoctorInformation.get("doctor_id")+";";
            preparedStatement = conn.prepareStatement(sql);
            int n=0;
            n = preparedStatement.executeUpdate();

            if(n>0){
                return true;
            }else{
                return false;
            }
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }finally {
            dc.closeConnection();
        }
    }

    public Boolean UpdateItemInformation(Map<String,String> newItemInformation){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();
        PreparedStatement preparedStatement;

        try{

            StringBuffer tmp = new StringBuffer();
            for(Map.Entry<String,String> entry: newItemInformation.entrySet()){

                if(!entry.getKey().equals("item_id")) {
                    if(tmp.length()!=0) tmp.append(",");
                    tmp.append(entry.getKey() + "='" + entry.getValue() + "'");
                }
            }
            String temp = tmp.toString();
            String sql = "update item set "+temp+" where item_id="+newItemInformation.get("item_id")+";";
            preparedStatement = conn.prepareStatement(sql);
            int n=0;
            n = preparedStatement.executeUpdate();

            if(n>0){
                return true;
            }else{
                return false;
            }
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }finally {
            dc.closeConnection();
        }
    }

    public Boolean UpdateRoomInformation(Map<String,String> newRoomInformation){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();
        PreparedStatement preparedStatement;

        try{

            StringBuffer tmp = new StringBuffer();
            for(Map.Entry<String,String> entry: newRoomInformation.entrySet()){

                if(!entry.getKey().equals("room_id")) {
                    if(tmp.length()!=0) tmp.append(",");
                    tmp.append(entry.getKey() + "='" + entry.getValue() + "'");
                }
            }
            String temp = tmp.toString();
            String sql = "update room set "+temp+" where room_id="+newRoomInformation.get("room_id")+";";
            preparedStatement = conn.prepareStatement(sql);
            int n=0;
            n = preparedStatement.executeUpdate();

            if(n>0){
                return true;
            }else{
                return false;
            }
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }finally {
            dc.closeConnection();
        }
    }

    public Boolean delete(String toDelete,String form){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();
        PreparedStatement preparedStatement;

        try{
            String sql="";
            if(form.equals("doctor")) {
                sql = "delete from doctor where doctor_id=" + toDelete;
            }else if(form.equals("item")){
                sql = "delete from item where item_id=" + toDelete;
            }else if(form.equals("room")){
                sql = "delete from room where room_id=" + toDelete;
            }else if(form.equals("pays")){
                sql = "delete from pays where pays_id=" + toDelete;
            }else if(form.equals("receipt")){
                sql = "delete from receipt where receipt_id=" + toDelete;
            }else if(form.equals("bed")){
                sql = "delete from bed where bed_room=" + toDelete;
            }
            preparedStatement = conn.prepareStatement(sql);
            int n = 0;
            n = preparedStatement.executeUpdate();
            if(n>0){
                return true;
            }else{
                return false;
            }
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public Boolean reduceStayRoomCapacity(int id,int capacityToReduce,int oldCapacity){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();
        PreparedStatement preparedStatement;

        try{
            StringBuffer sqlBuffer = new StringBuffer("in (");
            for(int i=0;i<capacityToReduce;i++){
                if(i!=0) sqlBuffer.append(",");
                sqlBuffer.append(String.valueOf(oldCapacity-i));
            }
            sqlBuffer.append(")");
            String sql= "delete from bed where bed_room="+id+" AND bed_no "+sqlBuffer.toString();

            preparedStatement = conn.prepareStatement(sql);
            int n = 0;
            n = preparedStatement.executeUpdate();
            return n>0;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }


    public Boolean cancelPays(ArrayList<String> toDelete){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();
        PreparedStatement preparedStatement;

        try{
            int size = toDelete.size();
            StringBuffer sqltemp = new StringBuffer();
            sqltemp.append("in (");
            for(int i=0;i<size;i++){
                if(i!=0) sqltemp.append(",");
                sqltemp.append(toDelete.get(i));
            }
            sqltemp.append(")");
            String tmp = sqltemp.toString();
            String sql="delete from pays where pays_id "+tmp;

            preparedStatement = conn.prepareStatement(sql);
            int n = 0;
            n = preparedStatement.executeUpdate();
            if(n>0){
                return true;
            }else{
                return false;
            }

        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public Boolean checkReceiptNeed(String receipt_id){
        Connection conn;
        DBConc dc = new DBConc();
        conn = dc.getConn();
        PreparedStatement preparedStatement;

        try{
            Statement stat = conn.createStatement();
            String sql="select pays_id from pays where receipt_id="+receipt_id;
            ResultSet rs = stat.executeQuery(sql);
            if(rs.next()){
                return true;
            }else{
                return false;
            }
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
}
