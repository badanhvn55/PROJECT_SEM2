package controller;

import entity.Product;
import java.io.IOException;
import java.util.List;

import static com.googlecode.objectify.ObjectifyService.ofy;

public class HomeController extends javax.servlet.http.HttpServlet {

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        List<Product> listProduct = ofy().load().type(Product.class).list();
        request.setAttribute("listProduct",listProduct);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
