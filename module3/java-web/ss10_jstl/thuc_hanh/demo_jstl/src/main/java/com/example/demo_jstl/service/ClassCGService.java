package com.example.demo_jstl.service;

import com.example.demo_jstl.model.ClassCG;
import com.example.demo_jstl.repository.ClassCGRepository;
import com.example.demo_jstl.repository.IClassCGRepository;

import java.util.List;

public class ClassCGService implements IClassCGService {
    private IClassCGRepository classCGRepository = new ClassCGRepository();
    @Override
    public List<ClassCG> findAll() {
        return classCGRepository.findAll();
    }
}
