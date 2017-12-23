package endpoint;
import com.google.appengine.repackaged.com.google.api.client.json.Json;
import com.google.gson.JsonSyntaxException;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.cmd.Query;
import entity.Admin;
import entity.Credential;
import entity.Product;
import entity.ResponseMessage;
import utility.RestfulHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import static com.googlecode.objectify.ObjectifyService.ofy;
import static utility.RestfulHelper.gson;
import static utility.RestfulHelper.parseStringInputStream;

@WebServlet(name = "AdminEndpoint")
public class AdminEndpoint extends HttpServlet {

    static {
        ObjectifyService.register(Admin.class);
        ObjectifyService.register(Credential.class);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] uriSplit = request.getRequestURI().split("/");
        if(uriSplit.length != 5){
            response.setStatus(400);
            ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", "URI is split");
            response.getWriter().println(RestfulHelper.gson.toJson(responseMessage));
        }
        String endpoint = uriSplit[uriSplit.length - 1];
        switch (endpoint){
            case "login":
                loginAdmin(request, response);
                break;
            case "register":
                registerAdmin(request, response);
                break;
            default:
                response.setStatus(400);
                ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", "uri is split");
                response.getWriter().println(RestfulHelper.gson.toJson(responseMessage));
        }
    }

    private void loginAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String content = RestfulHelper.parseStringInputStream((request.getInputStream()));
        Admin checkAdmin = RestfulHelper.gson.fromJson(content, Admin.class);
        Admin admin = ofy().load().type(Admin.class).id(checkAdmin.getUsername()).now();
        if(admin == null){
            response.setStatus(403);
            ResponseMessage responseMessage = new ResponseMessage(403, "Forbidden", "Admin is not found");
            response.getWriter().println(RestfulHelper.gson.toJson(responseMessage));
            return;
        }
        if(checkAdmin.getPassword().equals(admin.getPassword()) == false){
            response.setStatus(403);
            ResponseMessage responseMessage = new ResponseMessage(403, "Forbidden", "Admin is not found");
            response.getWriter().println(RestfulHelper.gson.toJson(responseMessage));
            return;
        }
        Credential credential = new Credential(admin.getUsername());
        if(ofy().save().entity(credential).now() == null){
            response.setStatus(500);
            ResponseMessage responseMessage = new ResponseMessage(500, "Server error", "Contact to admin");
            response.getWriter().println(RestfulHelper.gson.toJson(RestfulHelper.gson.toJson(responseMessage)));
            return;
        }
        response.getWriter().println(RestfulHelper.gson.toJson(credential));
    }

    private void registerAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String content = RestfulHelper.parseStringInputStream(request.getInputStream());
            Admin admin = RestfulHelper.gson.fromJson(content, Admin.class);
            HashMap<String, String> errors = admin.validate();
            if(errors.size() > 0){
                response.setStatus(400);
                ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", RestfulHelper.gson.toJson(errors));
                response.getWriter().println(RestfulHelper.gson.toJson(responseMessage));
                        return;
            }
            if(ofy().save().entity(admin).now() == null){
                response.setStatus(500);
                ResponseMessage responseMessage = new ResponseMessage(500, "Server error", "Contact to admin");
                response.getWriter().println(RestfulHelper.gson.toJson(responseMessage));
                return;
            }
            response.getWriter().println(RestfulHelper.gson.toJson(admin));
        }catch (JsonSyntaxException e){
            response.setStatus(400);
            ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", "Invalid parameter");
            response.getWriter().println(RestfulHelper.gson.toJson(responseMessage));
            return;
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        int action = 1;
        String username = null;
        String[] uriSplit = request.getRequestURI().split("/");
        if(uriSplit.length == 5){
            action = 2;
        }
        switch (action){
            case 1:
                getAdmin(request, response);
                break;
            case 2:
                username = uriSplit[uriSplit.length - 1];
                getAdminDetai(request, response, username);
                break;
            default:break;
        }
    }

    private void getAdminDetai(HttpServletRequest request, HttpServletResponse response, String username) throws ServletException, IOException {
        Admin adminDetail = ofy().load().type(Admin.class).id(username).now();
        if(adminDetail == null || adminDetail.getStatus() == 0){
            response.setStatus(404);
            ResponseMessage responseMessage = new ResponseMessage(404, "Not found", "Book is not exist or has been deleted!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }
        response.setStatus(200);
        response.getWriter().println(gson.toJson(adminDetail));
    }

    private void getAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int page = 1;
        int limit = 10;
        try {
            page = Integer.parseInt(request.getParameter("page"));
            limit = Integer.parseInt(request.getParameter("limit"));
        }catch (Exception e){
            page = 1;
            limit = 10;
        }
        Query<Admin> query = ofy().load().type(Admin.class).filter("status",1);
        int totalItem = query.count();
        int totalPage = totalItem / limit + ((totalItem % limit) > 0 ? 1 : 0);
        List<Admin> listAdmin = ofy().load().type(Admin.class).limit(limit).offset((page - 1) * limit).filter("status", 1).list();
        HashMap<String, Object> resp = new HashMap<>();
        resp.put("data", listAdmin);
        resp.put("page", page);
        resp.put("limit", limit);
        resp.put("totalPage", totalPage);
        resp.put("totalItem", totalItem);
        response.getWriter().println(gson.toJson(resp));

    }


    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = null;
        String[] uriSplit = request.getRequestURI().split("/");
        if(uriSplit.length != 5){
            response.setStatus(400);
            ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", "Invalid parameter");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }
        username = uriSplit[uriSplit.length - 1];

        Admin existAdmin = ofy().load().type(Admin.class).id(username).now();
        if(existAdmin == null || existAdmin.getStatus() == 0){
            response.setStatus(404);
            ResponseMessage responseMessage = new ResponseMessage(404, "Not found", "Object is not exist or has been deleted!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }

        try {
            String content = parseStringInputStream(request.getInputStream());
            Admin admin = gson.fromJson(content, Admin.class);

            HashMap<String, String> errors = admin.validate();
            if(errors.size() > 0){
                response.setStatus(400);
                ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", gson.toJson(errors));
                return;
            }
            existAdmin.setUsername(admin.getUsername());
            existAdmin.setPassword(admin.getPassword());
            existAdmin.setAvatar(admin.getAvatar());
            existAdmin.setStatus(admin.getStatus());
            if(ofy().save().entity(existAdmin).now() == null){
                response.setStatus(500);
                ResponseMessage responseMessage = new ResponseMessage(500, "Server error", "Please try again later!");
                response.getWriter().println(responseMessage);
                return;
            }
            response.setStatus(200);
            response.getWriter().println(gson.toJson(existAdmin));
        }catch (IOException | JsonSyntaxException e){
            response.setStatus(400);
            ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", "Invalid parameter!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }

    }
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = null;
        String[] uriSplit = request.getRequestURI().split("/");
        if(uriSplit.length != 5){
            response.setStatus(400);
            ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", "Invalid parameter!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }

        username = uriSplit[uriSplit.length - 1];

        Admin existAdmin = ofy().load().type(Admin.class).id(username).now();

        if(existAdmin == null || existAdmin.getStatus() == 0){
            response.setStatus(404);
            ResponseMessage responseMessage = new ResponseMessage(404, "Not found", "Object is not exist or has been deleted!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }
        existAdmin.setStatus(0);
        if(ofy().save().entity(existAdmin).now() == null){
            response.setStatus(500);
            ResponseMessage responseMessage = new ResponseMessage(500, "Server error", "Please try again later!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }
        ResponseMessage responseMessage = new ResponseMessage(200, "Ok", "Object hass been deleted");
        response.getWriter().println(gson.toJson(responseMessage));

    }
}
