package utility;

import com.google.gson.Gson;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.logging.Logger;

public class RestfulHelper {

    public static Gson gson = new Gson();
    private static Logger LOGGER = Logger.getLogger(RestfulHelper.class.toString());

    public static String parseStringInputStream(InputStream in) throws IOException {
        StringBuilder stringBuilder = new StringBuilder();
        String line;
        BufferedReader br = new BufferedReader(new InputStreamReader(in, Charset.forName("UTF-8")));
        while ((line = br.readLine()) != null) {
            stringBuilder.append(line);
        }
        LOGGER.info("Input String: " + stringBuilder.toString());
        return stringBuilder.toString();
    }
}
