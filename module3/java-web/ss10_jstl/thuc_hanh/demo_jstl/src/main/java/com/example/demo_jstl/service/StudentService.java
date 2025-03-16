package com.example.demo_jstl.service;

import com.example.demo_jstl.model.Student;
import com.example.demo_jstl.repository.IStudentRepository;
import com.example.demo_jstl.repository.StudentRepository;

import java.util.ArrayList;
import java.util.List;

public class StudentService implements IStudentService {
    // xử l nghiệp vụ
    private IStudentRepository studentRepository = new StudentRepository();

    @Override
    public List<Student> findAll() {
        // gọi repository lấy dữ liệu
        return studentRepository.findAll();
    }

    @Override
    public List<Student> searchByName(String studentName) {
        return studentRepository.seachByName(studentName);
    }

    @Override
    public boolean add(Student student) {
        //validate trước khi add
        return studentRepository.add(student);
    }

    @Override
    public boolean deleteById(int id) {
        return studentRepository.deleteById(id);
    }
}
