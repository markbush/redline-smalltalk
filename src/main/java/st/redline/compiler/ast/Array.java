/* Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution */
package st.redline.compiler.ast;

import java.util.ArrayList;

public class Array extends Primary implements ArrayElement {

    private final ArrayList<ArrayElement> elements;
    private int index;
    private int elementIndex = 0;
    private boolean insideArray = false;

    public Array() {
        elements = new ArrayList<ArrayElement>();
    }

    public void add(ArrayElement arrayElement) {
        if (arrayElement != null) {
            arrayElement.insideArray();
            arrayElement.index(++elementIndex);
            elements.add(arrayElement);
        }
    }

    public int size() {
        return elements.size();
    }

    public ArrayElement get(int index) {
        return elements.get(index);
    }

    public int index() {
        return index;
    }

    public void insideArray() {
        insideArray = true;
    }

    public boolean isInsideArray() {
        return insideArray;
    }

    public void index(int index) {
        this.index = index;
    }

    public String value() {
        return "<array>";
    }

    public int line() {
        return elements.size() > 0 ? elements.get(0).line() : 0;
    }

    public void accept(NodeVisitor nodeVisitor) {
        nodeVisitor.visitBegin(this);
        for (ArrayElement arrayElement : elements)
            arrayElement.accept(nodeVisitor);
        nodeVisitor.visitEnd(this, index, insideArray, line());
    }
}
