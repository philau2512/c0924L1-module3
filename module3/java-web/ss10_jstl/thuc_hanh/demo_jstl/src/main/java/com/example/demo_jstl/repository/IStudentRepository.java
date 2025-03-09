package com.example.demo_jstl.repository;

import com.example.demo_jstl.model.Student;

import java.util.List;

public interface IStudentRepository {
    List<Student> findAll();
    boolean add(Student student);
}
