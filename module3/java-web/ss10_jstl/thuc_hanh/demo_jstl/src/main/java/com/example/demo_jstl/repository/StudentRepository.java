package com.example.demo_jstl.repository;

import com.example.demo_jstl.model.Student;
import com.example.demo_jstl.util.BaseRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StudentRepository implements IStudentRepository {
    private final String SELECT_ALL = "select * from student";
    private final String DELETE_BY_ID = "delete from student where id =?";
    private final String INSERT_INTO = "insert into student(name,gender,point,class_id) values (?,?,?,?)";

    @Override
    public List<Student> findAll() {
        List<Student> studentlist = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();

        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                boolean gender = resultSet.getBoolean("gender");
                float point = resultSet.getFloat("point");
                int classId = resultSet.getInt("class_id");
                Student student = new Student(id, name, gender, point, classId);
                studentlist.add(student);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return studentlist;
    }

    @Override
    public List<Student> seachByName(String name) {
        List<Student> searchList = new ArrayList<>();
        return searchList;
    }

    @Override
    public boolean add(Student student) {
        // kết nối DB để thêm dữ liệu vào
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(INSERT_INTO);
            preparedStatement.setString(1, student.getName());
            preparedStatement.setBoolean(2, student.isGender());
            preparedStatement.setFloat(3, student.getScore());
            preparedStatement.setInt(4, student.getClassId());
            int effectedRows = preparedStatement.executeUpdate();
            return effectedRows == 1;
        } catch (SQLException e) {
            System.out.println("Error connect database: " + e.getMessage());
            return false;
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    @Override
    public boolean deleteById(int id) {
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE_BY_ID);
            preparedStatement.setInt(1, id);
            int effectedRows = preparedStatement.executeUpdate();
            return effectedRows == 1;
        } catch (SQLException e) {
            System.out.println("Error connect database: " + e.getMessage());
            return false;
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
