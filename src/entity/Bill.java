package entity;


import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;

@Entity
public class Bill implements Serializable {
    @Id
    private long id;
    @Index
    private String email;
    @Index
    private long createAt;
    @Index
    private long updateAt;
    @Index
    private int status;

    public Bill(Customer customer) {
        this.id = System.currentTimeMillis();
        this.createAt = System.currentTimeMillis();
        this.updateAt = System.currentTimeMillis();
        this.status = 1;
        this.email = customer.getEmail();

    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    public long getCreateAt() {
        return createAt;
    }

    public void setCreateAt(long createAt) {
        this.createAt = createAt;
    }

    public long getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(long updateAt) {
        this.updateAt = updateAt;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

//    private HashMap<Long, BillDetail> listBillDetail;
}
