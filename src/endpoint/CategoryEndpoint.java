package endpoint;

import com.google.gson.JsonSyntaxException;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.cmd.Query;
import entity.Category;
import entity.Product;
import entity.ResponseMessage;
import utility.FullTextSearchHandle;

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

@WebServlet(name = "CategoryEndpoint")
public class CategoryEndpoint extends HttpServlet {

    static {
        ObjectifyService.register(Category.class);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            String content = parseStringInputStream(request.getInputStream());
            Category category = gson.fromJson(content, Category.class);
            HashMap<String, String> error = category.checkValidate();
            if(error.size() > 0){
                response.setStatus(400);
                ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", gson.toJson(error));
                response.getWriter().println(gson.toJson(responseMessage));
                return;
            }
            if(ofy().save().entity(category).now() == null){
                response.setStatus(500);
                ResponseMessage responseMessage = new ResponseMessage(500, "Server error", "Please try again later!");
                response.getWriter().println(gson.toJson(responseMessage));
                return;
            }
            response.setStatus(201);
            response.getWriter().println(gson.toJson(category));
        }catch (IOException | JsonSyntaxException e){
            response.setStatus(400);
            ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", "Invalid parameter");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        int action = 1;
        String id = null;
        String[] uriSplit = request.getRequestURI().split("/");
        //check when get detail
        if(uriSplit.length == 6){
            action = 2;
            id = uriSplit[uriSplit.length - 1];
        }
        switch (action){
            case 1:
                getList(request, response);
                break;
            case 2:
                getListDetail(request, response, id);
                break;
            default:break;
        }
    }

    private void getList(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        int page = 1;
        int limit = 10;
        try {
            page = Integer.parseInt(request.getParameter("page"));
            limit = Integer.parseInt(request.getParameter("limit"));
        }catch (Exception e){
            page = 1;
            limit = 10;
        }
        Query<Category> query = ofy().load().type(Category.class).filter("status",1);
        int totalItem = query.count();
        int totalPage = totalItem / limit + ((totalItem % limit) > 0 ? 1 : 0);
        List<Category> listCategory = ofy().load().type(Category.class).limit(limit).offset((page - 1) * limit).filter("status", 1).list();
        HashMap<String, Object> resp = new HashMap<>();
        resp.put("data", listCategory);
        resp.put("page", page);
        resp.put("limit", limit);
        resp.put("totalPage", totalPage);
        resp.put("totalItem", totalItem);
        response.getWriter().println(gson.toJson(resp));
    }
    private void getListDetail(HttpServletRequest request, HttpServletResponse response, String strId) throws IOException, ServletException {
        long id = 0;
        try {
            id = Long.parseLong(strId);
            if(id == 0){
                throw new NumberFormatException("I'd must be greater than zero");
            }
        }catch (NumberFormatException e){
            response.setStatus(400);
            ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", "Invalid parameter!");
            return;
        }
        Category categoryDetail = ofy().load().type(Category.class).id(id).now();
        if(categoryDetail == null){
            response.setStatus(400);
            ResponseMessage responseMessage = new ResponseMessage(400, "Not found", "Category is not exist or has been deleted!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }
        response.setStatus(200);
        response.getWriter().println(gson.toJson(categoryDetail));

    }

    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //test url format
        String strid = null;
        String[] uriSplit = request.getRequestURI().split("/");
        if(uriSplit.length != 6){
            response.setStatus(400);
            ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", "Invalid parameter");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }
        strid = uriSplit[uriSplit.length - 1];

        //test id format sending
        long id = 0;
        try {
            id = Long.parseLong(strid);
            if(id == 0){
                throw new NumberFormatException("I'd must be greater than zero");
            }
        }catch (NumberFormatException ex){
            response.setStatus(400);
            ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", "Invalid parameter!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }

        //test object
        Category existObjectDetail = ofy().load().type(Category.class).id(id).now();
        if(existObjectDetail != null || existObjectDetail.getStatus() == 0){
            response.setStatus(404);
            ResponseMessage responseMessage = new ResponseMessage(404, "Not found", "Object is not exist or has been deleted!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }

        //Parse and intilaze content
        try {
            String content = parseStringInputStream(request.getInputStream());
            Category category = gson.fromJson(content, Category.class);
            //validate category
            HashMap<String, String> errors = category.checkValidate();
            if(errors.size() > 0){
                response.setStatus(400);
                ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", gson.toJson(errors));
                response.getWriter().println(gson.toJson(responseMessage));
                return;
            }
            existObjectDetail.setId(category.getId());
            existObjectDetail.setName(category.getName());
            existObjectDetail.setThumbnailUrl(category.getThumbnailUrl());
            existObjectDetail.setCreatedAt(category.getCreatedAt());
            existObjectDetail.setUpdatedAt(category.getUpdatedAt());
            existObjectDetail.setStatus(category.getStatus());

            if(ofy().save().entity(existObjectDetail).now() == null){
                response.setStatus(500);
                ResponseMessage responseMessage = new ResponseMessage(500, "Server error", "Please try again later!");
                response.getWriter().println(gson.toJson(responseMessage));
                return;
            }
            response.setStatus(200);
            response.getWriter().println(gson.toJson(existObjectDetail));
        }catch (JsonSyntaxException | IOException ex){
            response.setStatus(400);
            ResponseMessage responseMessage =  new ResponseMessage(400, "Bad request", "Invalid parameter!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }


    }


    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //test url format
        String strId = null;
        String[] uriSplit = request.getRequestURI().split("/");
        if(uriSplit.length != 6){
            response.setStatus(400);
            ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", "Invalid parameter!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }
        strId = uriSplit[uriSplit.length - 1];
        //test id format sending
        long id = 0;
        try {
            id = Long.parseLong(strId);
            if(id == 0){
                throw new NumberFormatException("I'd must be greater than zero!");
            }
        }catch (NumberFormatException e){
            response.setStatus(400);
            ResponseMessage responseMessage =  new ResponseMessage(400, "Bad request", "Invalid parameter!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }

        //test object
        Category existObjectDetail = ofy().load().type(Category.class).id(id).now();
        if(existObjectDetail == null || existObjectDetail.getStatus() == 0){
            response.setStatus(404);
            ResponseMessage responseMessage = new ResponseMessage(404, "Not found", "Object is not exist or has been deleted!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }
        existObjectDetail.setStatus(0);

        if(ofy().save().entity(existObjectDetail).now() == null){
            response.setStatus(500);
            ResponseMessage responseMessage = new ResponseMessage(500, "Server error", "Please try again later!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }
        FullTextSearchHandle.delete(String.valueOf(existObjectDetail.getId()));
        ResponseMessage responseMessage = new ResponseMessage(200, "Ok","Object has been deleted!");
        response.getWriter().println(gson.toJson(responseMessage));

    }



}
