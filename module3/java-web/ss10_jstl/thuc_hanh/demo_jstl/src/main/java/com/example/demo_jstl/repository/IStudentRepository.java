package com.example.demo_jstl.repository;

import com.example.demo_jstl.dto.StudentDto;
import com.example.demo_jstl.model.Student;

import java.util.List;

public interface IStudentRepository {
    List<StudentDto> findAll();
    List<StudentDto> seach(String searchName, String classId);
    boolean add(Student student);
    boolean deleteById(int id);
}
