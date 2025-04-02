package com.example.bai_tap_lam_them.service;

import com.example.bai_tap_lam_them.model.Category;
import com.example.bai_tap_lam_them.repository.CategoryRepository;
import com.example.bai_tap_lam_them.repository.ICategoryRepository;

import java.util.List;

public class CategoryService implements ICategoryService{
    private ICategoryRepository categoryRepository = new CategoryRepository();
    @Override
    public List<Category> getAllCategory() {
        return categoryRepository.getAllCategory();
    }
}
