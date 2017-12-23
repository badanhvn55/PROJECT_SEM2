package entity;

import java.io.Serializable;

public class BookPoint implements Serializable {
    private Product product;
    private float unitPoint;

    public BookPoint(Product product, int unitPoint) {
        this.product = product;
        this.unitPoint = product.getUnitPrice() / 20000;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public float getUnitPoint() {
        return unitPoint;
    }

    public void setUnitPoint(float unitPoint) {
        this.unitPoint = unitPoint;
    }
}
