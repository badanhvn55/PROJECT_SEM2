package endpoint;

import entity.Credential;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AuthenticationFilter")
public class AuthenticationFilter extends HttpServlet implements Filter {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    //Khi đăng nhập, server trả về cho người dùng 1 token key.
    //Lần sau đăng nhập thì người dùng sẽ gửi token key lên và server biết là ai!

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        String method = request.getMethod();
        switch (method){
            case "GET":
                filterChain.doFilter(servletRequest, servletResponse);
                break;
            case "POST":
                filterChain.doFilter(servletRequest, servletResponse);
                break;
            case "PUT":
            case "DELETE":
                String authenticationHeader = request.getHeader("Authentication");
                Credential credential = Credential.loadCredential(authenticationHeader);
                response.getWriter().println(credential);
                if(credential == null){
                    filterChain.doFilter(servletRequest, servletResponse);
                }else{
                    response.sendError(403, "WRONG LOGIN INFORMATION OR TOKEN IS EXPIERD! PLEAST RE-LOGIN!");
                }
                break;
        }
    }
}
