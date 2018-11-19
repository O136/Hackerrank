import java.util.ArrayList;

/*
1.user encodes a long URL like www.google.com
2.we put into the table (currentRow/AUTO_INCREMENTED_ID, www.google.com) for e.g. (5221, www.google.com)
3.we return to the user the encoded url: http://tinyurl.com/ ++ (5221.convertToBase(62))

4.the user wants to decode : http://tinyurl.com/ ++ (5221.convertedToBase(62))
5.we take only what's after the ++ and convert it to decimal base again to get 52221
6.go to table row number 5221 and get www.google.com

NOTE: what's so special about base62 ? well it just shortens the big int which 
acts as an ID, base62 uses [A-Z,a-z,0-9], of course we could use for e.g. base(100)
if we added up some chars in order to have a total of 100

the data type used to represent the row can be like a python number
*/

public class Codec {
    private static String fixedURL = "http://tinyurl.com/";
    private static ArrayList<String> table = new ArrayList<>();
    private static int ID = 0;

    // Encodes a URL to a shortened URL.
    public String encode(String longUrl) {
        table.add(longUrl);
        return Integer.toHexString(ID++);
    }

    // Decodes a shortened URL to its original URL.
    public String decode(String shortUrl) {
        int index = Integer.valueOf(shortUrl, 16);
        return table.get(index);
    }
}
