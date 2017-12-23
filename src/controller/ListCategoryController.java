package controller;

import com.googlecode.objectify.ObjectifyService;
import entity.Category;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import static com.googlecode.objectify.ObjectifyService.ofy;

@WebServlet(name = "ListCategoryController")
public class ListCategoryController extends HttpServlet {

    static {
        ObjectifyService.register(Category.class);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response, long categoryId) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        Category category = ofy().load().type(Category.class).id(categoryId).now();
        request.setAttribute("category", category);
        request.getRequestDispatcher("/list-product.jsp").forward(request, response);


    }
}
