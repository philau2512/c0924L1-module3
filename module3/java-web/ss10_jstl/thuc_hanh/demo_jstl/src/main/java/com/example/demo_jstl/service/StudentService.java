package com.example.demo_jstl.service;

import com.example.demo_jstl.dto.StudentDto;
import com.example.demo_jstl.model.Student;
import com.example.demo_jstl.repository.IStudentRepository;
import com.example.demo_jstl.repository.StudentRepository;

import java.util.ArrayList;
import java.util.List;

public class StudentService implements IStudentService {
    // xử l nghiệp vụ
    private IStudentRepository studentRepository = new StudentRepository();

    @Override
    public List<StudentDto> findAll() {
        // gọi repository lấy dữ liệu
        return studentRepository.findAll();
    }

    @Override
    public List<StudentDto> search(String studentName, String classId) {
        return studentRepository.seach(studentName, classId);
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
