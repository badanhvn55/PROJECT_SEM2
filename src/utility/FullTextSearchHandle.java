package utility;

import com.google.appengine.api.search.*;
import entity.Product;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class FullTextSearchHandle {

    private static Logger logger = Logger.getLogger(FullTextSearchHandle.class.getSimpleName());
    private static IndexSpec indexSpec = IndexSpec.newBuilder().setName("bookFullTextSearch").build();
    private static Index index = SearchServiceFactory.getSearchService().getIndex(indexSpec);

    public static FullTextSearchHandle getInstance(){
        return new FullTextSearchHandle();
    }

    public static void add(Document document) {
        try {
            index.put(document);
            logger.info("Index thành công.");
        } catch (PutException e) {
            logger.severe("Index lỗi");
            e.printStackTrace(System.err);
        }
    }

    public static void delete(String id) {
        try {
            index.delete(id);
            logger.info("Remove index thành công.");
        } catch (PutException e) {
            logger.severe("Remove index lỗi");
            e.printStackTrace(System.err);
        }
    }

    public List<Product> search(String keyword) {
        List<Product> listProduct = new ArrayList<>();
        Results<ScoredDocument> results = index.search(keyword);
        if (results != null && results.getNumberReturned() > 0) {
            for (ScoredDocument document : results) {
                try{
                    Product p = new Product();
                    p.setBookId(Long.parseLong(document.getId()));
                    p.setBookName(document.getOnlyField("bookName").getText());
                    p.setBookTitle(document.getOnlyField("bookTitle").getText());
                    p.setBookImage(document.getOnlyField("bookImage").getText());
                    p.setUnitPrice(document.getOnlyField("unitPrice").getNumber().intValue());
                    p.setBookAuthor(document.getOnlyField("bookAuthor").getText());
                    p.setBookPublisher(document.getOnlyField("bookPublisher").getText());
                    listProduct.add(p);
                }catch(Exception ex) {
                    logger.severe("Convert document lỗi.");
                    ex.printStackTrace(System.err);
                }
            }
        }
        return listProduct;
    }
}
