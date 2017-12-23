package entity;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Unindex;
import utility.ApplicationConstant;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import static com.googlecode.objectify.ObjectifyService.ofy;

@Entity
public class Category implements Serializable {

    @Id
    private long id;
    @Index
    private String name;
    @Unindex
    private String thumbnailUrl;
    @Index
    private long createdAt;
    @Index
    private long updatedAt;
    @Index
    private int status;

    private static List<Category> listCategory;

    public Category(long categoryId, String name, String thumbnailUrl) {
        this.id = categoryId;
        this.name = name;
        this.thumbnailUrl = thumbnailUrl;
        this.createdAt = System.currentTimeMillis();
        this.updatedAt = System.currentTimeMillis();
        this.status = 1;
    }

    public Category() {
        this.createdAt = System.currentTimeMillis();
        this.updatedAt = System.currentTimeMillis();
        this.status = 1;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getThumbnailUrl() {
        return thumbnailUrl;
    }

    public void setThumbnailUrl(String thumbnailUrl) {
        this.thumbnailUrl = thumbnailUrl;
    }

    public long getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(long createdAt) {
        this.createdAt = createdAt;
    }

    public long getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(long updatedAt) {
        this.updatedAt = updatedAt;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    /**
     * Thêm dữ liệu mẫu khi cần.
     * */
    public static void generateExampleData(){
        listCategory = new ArrayList<>();
//
//            Category c = new Category(1, "Sách giáo khoa", "/image/biasachvanhoc/vhvn3.jpg");
//            Category c1 = new Category(2, "Sách văn học", "/image/biasachvanhoc/tpkd3.jpg");
//            Category c2 = new Category(3, "Sách thiếu nhi", "/image/biasachthieunhi/truyentn3.jpg");
//            Category c3 = new Category(4, "Sách chuyên ngành", "/image/biasachchuyenganh/sach3.jpg");
//            Category c4 = new Category(5, "Sách Sách ngoại ngữ", "/image/biasach/image_107442.jpg");
//            Category c5 = new Category(6, "Sách kinh tế", "/image/biasachchuyenganh/sach1.jpg");
//            Category c6 = new Category(7, "Sách thường thức đời sống", "/image/biasachvanhoc/chamtoigiacmo.jpg");
//            Category c7 = new Category(8, "Sách phát triển bản thân", "/image/biasachvanhoc/vhvn2.jpg");
//            Category c8 = new Category(9, "Kho sách giảm giá", "/image/biasachvanhoc/tpkd2.jpg");
//            Category c9 = new Category(10, "Sách bán chạy", "/image/biasachvanhoc/vhvn4.jpg");
//            Category c10 = new Category(11, "Top 100", "/image/biasachvanhoc/tpkd1.jpg");
//
//            listCategory.add(c);
//            listCategory.add(c1);
//            listCategory.add(c2);
//            listCategory.add(c3);
//            listCategory.add(c4);
//            listCategory.add(c5);
//            listCategory.add(c6);
//            listCategory.add(c7);
//            listCategory.add(c8);
//            listCategory.add(c9);
//            listCategory.add(c10);
//
//        ofy().save().entities(listCategory).now();
    }

    /**
     * Lấy danh sách category trong trường hợp chưa có.
     * */
    public static List<Category> getListCategory(){
        if(listCategory == null){
            listCategory = ofy().load().type(Category.class).list();
        }
        if(listCategory.size() == 0){
            generateExampleData();
        }
        return listCategory;
    }

    public static void setListCategory(List<Category> updateListCategory){
        listCategory = updateListCategory;
    }

    /**
     *
     * */
    public HashMap<String, String> checkValidate() {
        HashMap<String, String> error = new HashMap<>();
        if (this.id <= 0) {
            error.put("id", "Category id is not valid!");
        }
        if (this.name == null || this.name.length() == 0) {
            error.put("name", "Please enter category name!");
        }
        if(this.thumbnailUrl == null || this.thumbnailUrl.length() == 0){
            error.put("thumbnailUrl", "Please enter thumbnail url!");
        }
        if(this.status != 1 && this.status != 0){
            error.put("status", "Category status is not valid!");
        }
        return error;
    }
}
