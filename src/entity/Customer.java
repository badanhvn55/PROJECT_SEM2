package entity;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Unindex;

import java.io.Serializable;
import java.util.HashMap;
import static com.googlecode.objectify.ObjectifyService.ofy;

@Entity
public class Customer implements Serializable {
    @Id private String email;
    @Unindex private String name;
    @Unindex private String address;
    @Unindex private String phone;
    @Unindex private String imageUrl;
    @Index private int status;

    public Customer() {
        this.imageUrl = "http://www.behindthevoiceactors.com/_img/chars/rikka-takanashi-love-chunibyo-and-other-delusions-6.03.jpg";
        this.status = 1;
    }



    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }


    public HashMap<String, String> validate(){
        HashMap<String, String> errors = new HashMap<>();
        if(this.email == null || this.email.length() == 0){
            errors.put("email", "Please enter your email");
        }
        if(this.status != 0 && this.status != 1){
            errors.put("status", "status is not valid");
        }
        return errors;
    }

    public static Customer customer(String email){
        Customer c = ofy().load().type(Customer.class).id(email).now();
        return c;
    }

}
