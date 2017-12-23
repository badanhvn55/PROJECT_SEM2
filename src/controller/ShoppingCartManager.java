package controller;

import com.googlecode.objectify.ObjectifyService;
import entity.CartItem;
import entity.Product;
import entity.ShoppingCart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

import static com.googlecode.objectify.ObjectifyService.ofy;

@WebServlet(name = "ShoppingCartManager")
public class ShoppingCartManager extends HttpServlet {

    static {
        ObjectifyService.register(Product.class);
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");


    HttpSession session = request.getSession();
    String command = request.getParameter("command");
    String productId = request.getParameter("productId");
    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
    try {
        long idProduct = Long.parseLong(productId);
        Product product = ofy().load().type(Product.class).id(idProduct).now();
        switch (command){
            case "plus":
                if(cart.getListItem().containsKey(idProduct)){
                    cart.plusToCart(idProduct, new CartItem(product, cart.getListItem().get(idProduct).getQuantity()));
                }else{
                    cart.plusToCart(idProduct, new CartItem(product, 1));
                }
                break;
            case "remove":
                cart.removeToCart(idProduct);
                break;
        }
    }catch (Exception e){
        e.printStackTrace();
//        response.sendRedirect("/list-product.jsp");
    }
    session.setAttribute("cart", cart);
//    response.sendRedirect("/list-product.jsp");
    }



    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}