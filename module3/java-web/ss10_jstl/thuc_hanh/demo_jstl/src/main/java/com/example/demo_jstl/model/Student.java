package com.example.demo_jstl.model;

public class Student {
    private int id;
    private String name;
    private boolean gender;
    private float score;
    private int classId;

    public Student() {
    }

    public Student(int id, String name, boolean gender, float score, int classId) {
        this.id = id;
        this.name = name;
        this.gender = gender;
        this.score = score;
        this.classId = classId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public float getScore() {
        return score;
    }

    public void setScore(float score) {
        this.score = score;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }
}
