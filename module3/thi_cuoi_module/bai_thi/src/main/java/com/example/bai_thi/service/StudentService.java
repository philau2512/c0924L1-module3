package com.example.bai_thi.service;

import com.example.bai_thi.model.Student;
import com.example.bai_thi.repository.IStudentRepository;
import com.example.bai_thi.repository.StudentRepository;

import java.util.List;

public class StudentService implements IStudentService {
    private IStudentRepository studentRepository = new StudentRepository();

    @Override
    public List<Student> getStudentList() {
        return studentRepository.getStudentList();
    }
}
