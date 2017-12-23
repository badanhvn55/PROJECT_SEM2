package endpoint;

import entity.Credential;
import entity.ResponseMessage;
import utility.RestfulHelper;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AdminFilter")
public class AdminFilter extends HttpServlet implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        String adminTokenKey = request.getHeader("AdminAuth");
        Credential credential = Credential.loadCredential(adminTokenKey);
        String method = request.getMethod();
        switch (method){
            case "GET":
                filterChain.doFilter(request,response);
            break;
            case "POST":
                filterChain.doFilter(request, response);
                break;
            case "PUT":
            case "DELETE":
                if(credential == null){
                    response.setStatus(403);
                    ResponseMessage responseMessage = new ResponseMessage(403, "Forbidden", "Token key is exppired or invalid");
                    response.getWriter().println(RestfulHelper.gson.toJson(responseMessage));
                    return;
                }
                filterChain.doFilter(request, response);

        }

    }
}
