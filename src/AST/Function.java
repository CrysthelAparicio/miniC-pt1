package AST;

import java.util.ArrayList;


public class Function {
    String name, type;
    ArrayList parameters = new ArrayList();

    public Function(String name, String type){
        this.name = name;
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public ArrayList getParameters() {
        return parameters;
    }

    public void setParameters(ArrayList parameters) {
        this.parameters = parameters;
    }

    @Override
    public String toString() {
        return "{" +
                "\"name\":\"" + name + '\"' +
                ", \"type\":\"" + type + '\"' +
                ", \"parameters\":" + parameters.toString() +
                '}';
    }
}
