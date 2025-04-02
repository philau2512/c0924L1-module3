package com.example.demo_jstl.repository;

import com.example.demo_jstl.model.ClassCG;
import com.example.demo_jstl.util.BaseRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClassCGRepository implements IClassCGRepository {
    private final String SELECT_ALL = "select * from class";

    @Override
    public List<ClassCG> findAll() {
        List<ClassCG> classCGList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String className = resultSet.getString("name");
                ClassCG classCG = new ClassCG(id, className);
                classCGList.add(classCG);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return classCGList;
    }
}
