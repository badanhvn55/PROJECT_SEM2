package controller;

import com.googlecode.objectify.ObjectifyService;
import entity.Admin;
import entity.Bill;
import entity.Category;
import entity.Product;

import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ApplicationFilter implements Filter{

    static {
        ObjectifyService.register(Product.class);
        ObjectifyService.register(Category.class);
        ObjectifyService.register(Bill.class);
        ObjectifyService.register(Admin.class);
    }


    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request =  (HttpServletRequest) servletRequest;
        HttpServletResponse response =  (HttpServletResponse) servletResponse;
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        filterChain.doFilter(request, response);
    }

    @Override
    public void destroy() {

    }
}
