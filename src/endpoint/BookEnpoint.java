package endpoint;

import com.google.appengine.repackaged.com.google.api.client.json.Json;
import com.google.gson.JsonSyntaxException;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.cmd.Query;
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
import static utility.RestfulHelper.*;

@WebServlet(name = "BookEnpoint")
public class BookEnpoint extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            String content = parseStringInputStream(request.getInputStream());
            Product book = gson.fromJson(content, Product.class);

            HashMap<String, String> errors = book.validate();
            if(errors.size() > 0){
                response.setStatus(400);
                ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", gson.toJson(errors));
                response.getWriter().println(gson.toJson(responseMessage));
                return;
            }
            if(ofy().save().entity(book).now() == null){
                response.setStatus(500);
                ResponseMessage responseMessage = new ResponseMessage(500, "Server error", "Please try again later!");
                response.getWriter().println(gson.toJson(responseMessage));
                return;
            }
            // save thành công, tiến hành index.
            FullTextSearchHandle.add(book.toSearchDocument());
            response.setStatus(201);
            response.getWriter().println(gson.toJson(book));
        }catch (IOException | JsonSyntaxException e){
            response.setStatus(400);
            ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", "Invalid parameter!");
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
        if(uriSplit.length == 5){
            action = 2;
        }
        switch (action){
            case 1:
                getList(request, response);
                break;
            case 2:
                id = uriSplit[uriSplit.length - 1];
                getDetail(request, response, id);
                break;
            default:break;
        }
    }

    private void getDetail(HttpServletRequest request, HttpServletResponse response, String strId) throws IOException, ServletException {
        long id = 0;
        try {
            id = Long.parseLong(strId);
            if(id == 0){
                throw new NumberFormatException("I'd must be greater than zero!");
            }
        }catch (NumberFormatException e){
            response.setStatus(400);
            ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", "Invalid parameter!");
            return;
        }

        Product bookDetail = ofy().load().type(Product.class).id(id).now();
        if(bookDetail == null || bookDetail.getStatus() == 0){
            response.setStatus(404);
            ResponseMessage responseMessage = new ResponseMessage(404, "Not found", "Book is not exist or has been deleted!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }
        response.setStatus(200);
        response.getWriter().println(gson.toJson(bookDetail));
    }

    private void getList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int page = 1;
        int limit = 10;
        try {
            page = Integer.parseInt(request.getParameter("page"));
            limit = Integer.parseInt(request.getParameter("limit"));
        }catch (Exception e){
            page = 1;
            limit = 10;
        }
        Query<Product> query = ofy().load().type(Product.class).filter("status",1);
        int totalItem = query.count();
        int totalPage = totalItem / limit + ((totalItem % limit) > 0 ? 1 : 0);
        List<Product> listBook = ofy().load().type(Product.class).limit(limit).offset((page - 1) * limit).filter("status", 1).list();
        HashMap<String, Object> resp = new HashMap<>();
        resp.put("data", listBook);
        resp.put("page", page);
        resp.put("limit", limit);
        resp.put("totalPage", totalPage);
        resp.put("totalItem", totalItem);
        response.getWriter().println(gson.toJson(resp));
    }

    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        //test url format.
        String strId = null;
        String[] urlSplit = request.getRequestURI().split("/");
        if(urlSplit.length != 5){
            response.setStatus(400);
            ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", "Invalid parameter!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }
        strId = urlSplit[urlSplit.length - 1];

        // test id format sending
        long id = 0;
        try {
            id = Long.parseLong(strId);
            if(id == 0){
                throw new NumberFormatException("id must be greater then zero!");
            }
        }catch (NumberFormatException e){
            response.setStatus(400);
            ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", "Invalid parameter!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }

        //test object
        Product existObjectDetail  = ofy().load().type(Product.class).id(id).now();
        if(existObjectDetail == null || existObjectDetail.getStatus() == 0){
            response.setStatus(404);
            ResponseMessage responseMessage = new ResponseMessage(404, "Not found", "Object is not exist or has been deleted!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }

        //Parse and intilaze content
        try {
            String content = parseStringInputStream(request.getInputStream());
            Product book = gson.fromJson(content, Product.class);
            //Validate product
            HashMap<String, String> errors = book.validate();
            if(errors.size() > 0){
                response.setStatus(400);
                ResponseMessage responseMessage = new ResponseMessage(400, "Bad request", gson.toJson(errors));
                response.getWriter().println(gson.toJson(responseMessage));
                return;
            }
            existObjectDetail.setBookId(book.getBookId());
            existObjectDetail.setCategoryId(book.getCategoryId());
            existObjectDetail.setBookName(book.getBookName());
            existObjectDetail.setBookTitle(book.getBookTitle());
            existObjectDetail.setBookAuthor(book.getBookAuthor());
            existObjectDetail.setBookPublisher(book.getBookPublisher());
            existObjectDetail.setBookImage(book.getBookImage());
            existObjectDetail.setBookDescription(book.getBookDescription());
            existObjectDetail.setUnitPrice(book.getUnitPrice());
            existObjectDetail.setStatus(book.getStatus());
            if(ofy().save().entity(existObjectDetail).now() == null){
                response.setStatus(500);
                ResponseMessage responseMessage = new ResponseMessage(500, "Server error", "Please try again later!");
                response.getWriter().println(gson.toJson(responseMessage));
                return;
            }
            FullTextSearchHandle.add(book.toSearchDocument());
            response.setStatus(200);
            response.getWriter().println(gson.toJson(existObjectDetail));
        }catch (IOException | JsonSyntaxException e){
            response.setStatus(400);
            ResponseMessage responseMessage =  new ResponseMessage(400, "Bad request", "Invalid parameter!");
            response.getWriter().println(gson.toJson(responseMessage));
            return;
        }

    }


    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        //test url format
        String strId = null;
        String[] uriSplit = request.getRequestURI().split("/");
        if(uriSplit.length != 5){
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
        Product existObjectDetail = ofy().load().type(Product.class).id(id).now();
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
        FullTextSearchHandle.delete(String.valueOf(existObjectDetail.getBookId()));
        ResponseMessage responseMessage = new ResponseMessage(200, "Ok","Object has been deleted!");
        response.getWriter().println(gson.toJson(responseMessage));
    }
}
