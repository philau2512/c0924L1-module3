package com.example.demo_jstl.repository;

import com.example.demo_jstl.model.Student;

import java.util.ArrayList;
import java.util.List;

public class StudentRepository implements IStudentRepository {
    // chuyên kết nối với db

    private static List<Student> studentList = new ArrayList<>();
    static {
        studentList.add(new Student(1, "lau1", true, 9, 1));
        studentList.add(new Student(1, "Thảo", false, 3, 1));
        studentList.add(new Student(1, "lau1", true, 7, 1));
        studentList.add(new Student(1, "Trang", false, 5, 1));
        studentList.add(new Student(1, "lau1", true, 6, 1));
    }

    @Override
    public List<Student> findAll() {
        return studentList;
    }

    @Override
    public boolean add(Student student) {
        return studentList.add(student);
    }
}
