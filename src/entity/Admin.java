package entity;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Unindex;

import java.io.Serializable;
import java.util.HashMap;

@Entity
public class Admin implements Serializable {

    @Id private String username;
    @Index private String password;
    @Unindex private String avatar;
    @Index private int status;

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public Admin() {
        this.status = 1;
    }


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public HashMap<String, String> validate(){
        HashMap<String, String> errors = new HashMap<>();
        if(this.username == null || this.password.length() == 0){
            errors.put("username", "username is not valid or empty");
        }
        if(this.password == null || this.password.length() == 0){
            errors.put("password", "password is not valid or empty");
        }
        if(this.status != 0 && this.status != 1){
            errors.put("status", "status must be 0 or 1");
        }
        return errors;
    }
}
