package entity;


import java.io.Serializable;

public class CartItem implements Serializable {

    private Product product;
    private int quantity;
    private int totalPrice;

    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
        this.totalPrice = product.getUnitPrice()*this.quantity;
    }

    public CartItem() {
        this.totalPrice = product.getUnitPrice()*this.quantity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
        this.totalPrice = this.product.getUnitPrice()*this.quantity;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

}
