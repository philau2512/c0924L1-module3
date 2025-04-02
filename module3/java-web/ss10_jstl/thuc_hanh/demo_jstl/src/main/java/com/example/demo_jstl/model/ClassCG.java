package com.example.demo_jstl.model;

public class ClassCG {
    private int id;
    private String className;

    public ClassCG() {
    }

    public ClassCG(int id, String className) {
        this.id = id;
        this.className = className;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
