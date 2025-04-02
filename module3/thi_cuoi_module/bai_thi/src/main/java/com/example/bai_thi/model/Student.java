package com.example.bai_thi.model;

public class Student {
    private int studentId;
    private String studentName;
    private String className;

    public Student() {
    }

    public Student(int studentId, String studentName, String className) {
        this.studentId = studentId;
        this.studentName = studentName;
        this.className = className;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }
}
