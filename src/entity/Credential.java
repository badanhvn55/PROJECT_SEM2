package entity;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Unindex;

import java.io.Serializable;
import java.util.UUID;
import static com.googlecode.objectify.ObjectifyService.ofy;

@Entity
public class Credential implements Serializable {
    @Id String tokenKey;
    @Unindex String secretToken;
    @Unindex String adminId;
    @Index long createTime;
    @Index long expiredTime;
    @Index int status; // 1. active - 2. dead.

    public Credential(String user) {
        this.tokenKey = UUID.randomUUID().toString();
        this.secretToken = this.tokenKey;
        this.adminId = user;
        this.createTime = System.currentTimeMillis();
        this.expiredTime = this.createTime +86400 * 1000;
        this.status = 1;
    }

    public Credential() {
    }


    public String getTokenKey() {
        return tokenKey;
    }

    public void setTokenKey(String tokenKey) {
        this.tokenKey = tokenKey;
        this.secretToken = tokenKey;
    }

    public String getSecretToken() {
        return secretToken;
    }

    public void setSecretToken(String secretToken) {
        this.secretToken = secretToken;
    }

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public long getCreateTime() {
        return createTime;
    }

    public void setCreateTime(long createTime) {
        this.createTime = createTime;
    }

    public long getExpiredTime() {
        return expiredTime;
    }

    public void setExpiredTime(long expiredTime) {
        this.expiredTime = expiredTime;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public static Credential loadCredential(String secretToken){
        if(secretToken == null){
            return null;
        }
        Credential credential = ofy().load().type(Credential.class).id(secretToken).now();
        if(credential == null){
            return null;
        }
        if(credential.getExpiredTime() < System.currentTimeMillis()){
            ofy().save().entity(credential).now();
            return null;
        }
        return credential;
    }
}
