package Parser;

import java.net.URL;

public class SyntacticalGenerator {
    public static void main(String[] args) {
        URL url = SyntacticalGenerator.class.getResource("Syntactical.cup");
        URL parser = SyntacticalGenerator.class.getResource("Syntactical.cup");
        System.out.println(parser.getPath());

                

        
        String params[] = {"-destdir","src/Parser/", "-parser",  "Parser", "src/Parser/Syntactical.cup"};
        try {
            java_cup.Main.main(params);
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}