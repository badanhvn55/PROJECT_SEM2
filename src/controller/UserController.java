package controller;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import com.googlecode.objectify.ObjectifyService;
import entity.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static com.googlecode.objectify.ObjectifyService.ofy;

@WebServlet(
        name = "UserAPI",
        description = "UserAPI: Login / Logout with UserService",
        urlPatterns = "/userapi"
)
public class UserController extends HttpServlet {

    static {
        ObjectifyService.register(Customer.class);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();

//        String email = request.getParameter("email");
//        if(user != null){
//            Customer customer = new Customer();
//            customer.setEmail(user.getEmail());
//            ofy().save().entity(customer).now();
//        }else{
//            Customer customer = new Customer();
//        }


        if (user != null) {
            Customer customer = new Customer();
            customer.setEmail(user.getEmail());
            ofy().save().entity(customer).now();


            response.getWriter().println("Welcome, " + user.getNickname());
            response.getWriter().println(
                    "<a href='"
                            + userService.createLogoutURL("/logout")
                            + "'> LogOut </a>");

        } else {

            response.getWriter().println(
                    "Please <a href='"
                            + userService.createLoginURL("/login")
                            + "'> LogIn </a>");

        }



    }
}
