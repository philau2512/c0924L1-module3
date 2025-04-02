package com.example.demo_jstl.dto;

public class StudentDto {
    private int id;
    private String name;
    private boolean gender;
    private float score;
    private String className;

    public StudentDto() {
    }

    public StudentDto(int id, String name, boolean gender, float score, String className) {
        this.id = id;
        this.name = name;
        this.gender = gender;
        this.score = score;
        this.className = className;
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

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }
}
