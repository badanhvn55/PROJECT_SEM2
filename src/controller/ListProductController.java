package controller;

import com.googlecode.objectify.cmd.Query;
import entity.Category;
import entity.Product;
import entity.ShoppingCart;
import utility.FullTextSearchHandle;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import static com.googlecode.objectify.ObjectifyService.ofy;

public class ListProductController extends javax.servlet.http.HttpServlet {

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        int action;
        action = 1;
        String id = request.getParameter("id");
        String categoryId = request.getParameter("categoryId");
        String keyword = request.getParameter("keyword");
        if (id != null && id.length() > 0) {
            System.out.println("Product by Id");
            action = 3; // Lấy chi tiết sách theo id.
        } else if (categoryId != null && categoryId.length() > 0) {
            System.out.println("Product by Category Id");
            action = 2; // Search theo danh mục.
        } else {
            System.out.println("Product by Keyword " + keyword);
            action = 1; // Search theo keyword.
        }

        switch (action) {
            case 1:
                searchBook(request, response, keyword);
                break;
            case 2:
                try {
                    getBookByCategory(request, response, Long.parseLong(categoryId));
                } catch (NumberFormatException ex) {
                    response.sendError(400);
                    return;
                }
                break;
            case 3:
                try {
                    getBookById(request, response, Long.parseLong(id));
                } catch (NumberFormatException ex) {
                    response.sendError(400);
                    return;
                }
                break;
            default:
                break;
        }

    }

    private void searchBook(HttpServletRequest request, HttpServletResponse response, String keyword) throws javax.servlet.ServletException, IOException {
        List<Product> listProduct = new ArrayList<>();
        if(keyword != null && keyword.length() > 0){
            listProduct = FullTextSearchHandle.getInstance().search(keyword);
            System.out.println("Bookname: " + keyword);
        }else{
            Query<Product> query = ofy().load().type(Product.class);
            listProduct = query.list();
        }
        request.setAttribute("listProduct", listProduct);
        request.getRequestDispatcher("/list-product.jsp").forward(request, response);
    }

    private void getBookByCategory(HttpServletRequest request, HttpServletResponse response, long categoryId) throws javax.servlet.ServletException, IOException {
        List<Product> listProductByCategory = ofy().load().type(Product.class).filter("categoryId", categoryId).list();
        request.setAttribute("listProduct", listProductByCategory);
        request.getRequestDispatcher("/list-product.jsp").forward(request, response);
    }

    private void getBookById(HttpServletRequest request, HttpServletResponse response, long bookId) throws javax.servlet.ServletException, IOException {
        Product productById = ofy().load().type(Product.class).id(bookId).now();
        request.setAttribute("productById", productById);
        request.getRequestDispatcher("/book-detail.jsp").forward(request, response);
    }
}
