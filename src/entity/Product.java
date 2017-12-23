package entity;

import com.google.appengine.api.search.Document;
import com.google.appengine.api.search.Field;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

import java.io.Serializable;
import java.util.HashMap;

@Entity
public class Product implements Serializable {
    @Id
    private long bookId;
    @Index
    private long categoryId;
    @Index
    private String bookName;
    @Index
    private String bookTitle;
    @Index
    private String bookAuthor;
    @Index
    private String bookPublisher;
    @Index
    private String bookImage;
    @Index
    private String bookDescription;
    @Index
    private int unitPrice;
    @Index
    private int status; // 0. dead - 1. alive - 2. book in shopping cart

    public Product(long categoryId, String bookName, String bookTitle, String bookAuthor, String bookPublisher, String bookImage, String bookDescription, int unitPrice) {
        this.bookId = System.currentTimeMillis();
        this.categoryId = categoryId;
        this.bookName = bookName;
        this.bookTitle = bookTitle;
        this.bookAuthor = bookAuthor;
        this.bookPublisher = bookPublisher;
        this.bookImage = bookImage;
        this.bookDescription = bookDescription;
        this.unitPrice = unitPrice;
        this.status = 1;
    }

    public Product() {

    }

    public long getBookId() {
        return bookId;
    }

    public void setBookId(long bookId) {
        this.bookId = bookId;
    }

    public long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(long categoryId) {
        this.categoryId = categoryId;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public String getBookAuthor() {
        return bookAuthor;
    }

    public void setBookAuthor(String bookAuthor) {
        this.bookAuthor = bookAuthor;
    }

    public String getBookPublisher() {
        return bookPublisher;
    }

    public void setBookPublisher(String bookPublisher) {
        this.bookPublisher = bookPublisher;
    }

    public String getBookImage() {
        return bookImage;
    }

    public void setBookImage(String bookImage) {
        this.bookImage = bookImage;
    }

    public String getBookDescription() {
        return bookDescription;
    }

    public void setBookDescription(String bookDescription) {
        this.bookDescription = bookDescription;
    }

    public int getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(int unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public HashMap<String, String> validate() {
        HashMap<String, String> errors = new HashMap<>();
        if (this.bookName == null || this.bookName.length() == 0) {
            errors.put("bookName", "Please enter bookName");
        }
        if (this.categoryId < 1 || this.categoryId > 8) {
            errors.put("categoryId", "Category is not valid");
        }
        if (this.bookAuthor == null || this.bookAuthor.length() == 0) {
            errors.put("bookAuthor", "Please enter bookAuthor");
        }
        if (this.bookImage == null || this.bookImage.length() == 0) {
            errors.put("bookImage", "Please enter bookImage");
        }
        if (this.bookPublisher == null || this.bookPublisher.length() == 0) {
            errors.put("bookPublisher", "Please enter bookPublisher");
        }
        if (this.bookTitle == null || this.bookTitle.length() == 0) {
            errors.put("bookTitle", "Please enter bookTitle");
        }
        if (this.unitPrice < 0) {
            errors.put("unitPrice", "unitPrice is not valid");
        }
        return errors;
    }

    public Document toSearchDocument() {
        return
                Document.newBuilder()
                        .setId(String.valueOf(this.getBookId()))
                        .addField(Field.newBuilder().setName("bookName").setText(this.getBookName()))
                        .addField(Field.newBuilder().setName("bookTitle").setText(this.getBookTitle()))
                        .addField(Field.newBuilder().setName("bookImage").setText(this.getBookImage()))
                        .addField(Field.newBuilder().setName("unitPrice").setNumber(this.getUnitPrice()))
                        .addField(Field.newBuilder().setName("bookAuthor").setText(this.getBookAuthor()))
                        .addField(Field.newBuilder().setName("bookPublisher").setAtom(this.getBookPublisher()))
                        .build();
    }
}
