package Scanner;

import java.io.File;
import java.net.URL;




public class LexicalGenerator {
    public static void main(String[] args){
        URL url = LexicalGenerator.class.getResource("Lexical.flex");
        File lexical = new File(url.getFile());
        jflex.Main.generate(lexical);
    }
}
