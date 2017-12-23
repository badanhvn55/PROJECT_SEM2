package controller;

import com.googlecode.objectify.ObjectifyService;
import entity.Product;
import entity.ShoppingCart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ShoppingCartController")
public class ShoppingCartController extends HttpServlet {

    static {
        ObjectifyService.register(Product.class);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ShoppingCart shoppingCart = (ShoppingCart) session.getAttribute("cart");
        request.setAttribute("shoppingCart", shoppingCart);
        request.getRequestDispatcher("/pay.jsp").forward(request, response);
    }
}
