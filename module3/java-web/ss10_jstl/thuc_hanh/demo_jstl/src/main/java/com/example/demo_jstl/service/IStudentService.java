package com.example.demo_jstl.service;

import com.example.demo_jstl.dto.StudentDto;
import com.example.demo_jstl.model.Student;

import java.util.List;

public interface IStudentService {
    List<StudentDto> findAll();
    List<StudentDto> search(String studentName, String classId);
    boolean add(Student student);
    boolean deleteById(int id);
}
