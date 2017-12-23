package endpoint;

import com.googlecode.objectify.ObjectifyService;
import entity.Bill;
import entity.Category;
import entity.Customer;
import entity.Product;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ServletCORSFilter")
public class ServletCORSFilter extends HttpServlet implements Filter {
    static {
        ObjectifyService.register(Product.class);
        ObjectifyService.register(Category.class);
        ObjectifyService.register(Customer.class);
        ObjectifyService.register(Bill.class);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        servletRequest.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.addHeader("Access-Control-Allow-Origin","*");
        response.addHeader("Access-Control-Allow-Methods","POST, GET, PUT, DELETE");
        response.addHeader("Access-Control-Allow-Headers", "Content-Type, Authentication");
        filterChain.doFilter(request, response);
    }
}
