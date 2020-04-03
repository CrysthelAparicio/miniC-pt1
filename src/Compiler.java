import Parser.Parser;
import Parser.SyntacticalGenerator;
import Scanner.Lexical;
import Scanner.LexicalGenerator;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.Reader;
import java.net.URL;





public class Compiler {
    public static void main(String[] args) throws Exception {
        LexicalGenerator.main(args);
        SyntacticalGenerator.main(args);
       
        URL url = Compiler.class.getResource("source.c");
        Reader reader = new BufferedReader(new FileReader("src/source.c"));
       Lexical lexer = new Lexical(reader);
       Parser test = new Parser(lexer);
       test.parse();
    }
}
