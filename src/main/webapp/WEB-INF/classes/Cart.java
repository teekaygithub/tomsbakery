package mypackage;

import java.util.Vector;

public class Cart {
// Members
private final Vector<String> items = new Vector<>();
private String item = null;
private String submit = null;

// Constructor
public Cart () {}

// Methods
public void addItem(String product) {
    items.addElement(product);
}

public void removeItem(String product) {
    items.removeElement(product);
}

public void setItem(String product) {
    System.out.println("Setting property item");
    item = product;
}

public void setSubmit(String input) {
    System.out.println("Setting property submit");
    submit = input;
}

public String[] getItems() {
    String [] s = new String[items.size()];
    items.copyInto(s);
    return s;
}

public void process() {
    if (submit != null) {
        if (submit.equals("add")) {
            addItem(item);
        } else if (submit.equals("remove")) {
            removeItem(item);
        }
        
        reset();
    }
}

private void reset() {
    submit = null;
    item = null;
}

}