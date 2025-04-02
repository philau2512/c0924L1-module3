package com.example.demo_jstl.repository;

import com.example.demo_jstl.dto.StudentDto;
import com.example.demo_jstl.model.Student;
import com.example.demo_jstl.util.BaseRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StudentRepository implements IStudentRepository {
    private final String SELECT_ALL = "select s.*, c.name as class_name from student s join class c on s.class_id=c.id";
    private final String DELETE_BY_ID = "delete from student where id =?";
    private final String INSERT_INTO = "insert into student(name,gender,point,class_id) values (?,?,?,?)";
    private final String SEARCH = "select s.*, c.name as class_name from student s join class c on s.class_id=c.id where s.name like ? and c.id = ?";
    private final String SEARCH2 = "select s.*, c.name as class_name from student s join class c on s.class_id=c.id where s.name like ?";

    @Override
    public List<StudentDto> findAll() {
        List<StudentDto> studentlist = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();

        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                boolean gender = resultSet.getBoolean("gender");
                float point = resultSet.getFloat("point");
                String className = resultSet.getString("class_name");
                StudentDto student = new StudentDto(id, name, gender, point, className);
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
    public List<StudentDto> seach(String searchName, String classId) {
        List<StudentDto> searchList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = null;
            if (classId.equals("")){
                preparedStatement = connection.prepareStatement(SEARCH2);
                preparedStatement.setString(1, "%" + searchName + "%");
            } else {
                preparedStatement = connection.prepareStatement(SEARCH);
                preparedStatement.setString(1, "%" + searchName + "%");
                preparedStatement.setString(2, classId);
            }

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                boolean gender = resultSet.getBoolean("gender");
                float point = resultSet.getFloat("point");
                String className = resultSet.getString("class_name");
                StudentDto student = new StudentDto(id, name, gender, point, className);
                searchList.add(student);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
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
