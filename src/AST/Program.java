package AST;

import java.util.ArrayList;

public class Program {
    ArrayList declarations =  new ArrayList();
    ArrayList functions = new ArrayList();

    public ArrayList getDeclarations() {
        return declarations;
    }

    public void setDeclarations(ArrayList declarations) {
        this.declarations = declarations;
    }

    public ArrayList getFunctions() {
        return functions;
    }

    public void setFunctions(ArrayList functions) {
        this.functions = functions;
    }

}
