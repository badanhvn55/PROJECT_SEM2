package entity;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class ShoppingCart implements Serializable {


    private HashMap<Long, CartItem> listItem;
    public ShoppingCart(){
        listItem = new HashMap<>();
    }

    public ShoppingCart(HashMap<Long, CartItem> listItem) {
        this.listItem = listItem;
    }


    public HashMap<Long, CartItem> getListItem() {
        return listItem;
    }

    public void setListItem(HashMap<Long, CartItem> listItem) {
        this.listItem = listItem;
    }



    //insert to cart
    public void plusToCart(long key ,CartItem item){
        boolean check = listItem.containsKey(key);
        if(check){
            int quantity_old = item.getQuantity();
//            int price_old = item.getTotalPrice();
            item.setQuantity(quantity_old + 1);
//            item.setTotalPrice(price_old + item.getProduct().getUnitPrice());
            listItem.put(key, item);
        }else{
            listItem.put(key, item);
        }

    }

   //sub to cart
    public void subToCart(Long key, CartItem item){
        boolean check = listItem.containsKey(key);
        if(check){
            int quantity_old = item.getQuantity();
//            int price_old = item.getTotalPrice();
            if(quantity_old <= 1){
//                item.setTotalPrice(0);
                listItem.remove(key);
            }else {
                item.setQuantity(quantity_old - 1);
//                item.setTotalPrice(price_old - item.getProduct().getUnitPrice());
                listItem.put(key, item);
            }
        }
    }

    //remove to cart
    public void removeToCart(Long key){
        boolean check = listItem.containsKey(key);
        if (check){
            listItem.remove(key);
        }
    }

//    public void removeItem(CartItem item){
//        this.listItem.remove(item.getProduct().getBookId());
//    }

    //count item
    public int countItem(){
        return listItem.size();
    }

    //sum total
    public int totalCart(){
        int count = 0;
        //count = price * quantity;
        for (Map.Entry<Long, CartItem> list : listItem.entrySet()){
            count += list.getValue().getProduct().getUnitPrice() * list.getValue().getQuantity();
        }
        return count;
    }
}
