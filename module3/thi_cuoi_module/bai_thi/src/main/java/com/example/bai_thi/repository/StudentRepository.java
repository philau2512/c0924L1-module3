package com.example.bai_thi.repository;

import com.example.bai_thi.model.Student;
import com.example.bai_thi.util.BaseRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StudentRepository implements IStudentRepository {
    private final String GET_ALL_STUDENT = "select * from student";

    @Override
    public List<Student> getStudentList() {
        List<Student> studentList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_STUDENT);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int studentId = resultSet.getInt("student_id");
                String studentName = resultSet.getString("full_name");
                String className = resultSet.getString("class_name");
                Student student = new Student(studentId, studentName, className);
                studentList.add(student);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return studentList;
    }
}
