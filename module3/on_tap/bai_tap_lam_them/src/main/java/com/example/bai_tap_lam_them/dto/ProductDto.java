package com.example.bai_tap_lam_them.dto;

public class ProductDto {
    private int id;
    private String code;
    private String name;
    private String unit;
    private double pricePerUnit;
    private String categoryName;
    private int categoryId;

    public ProductDto(int id, String code, String name, String unit, double pricePerUnit, String categoryName, int categoryId) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.unit = unit;
        this.pricePerUnit = pricePerUnit;
        this.categoryName = categoryName;
        this.categoryId = categoryId;
    }

    public ProductDto() {
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public double getPricePerUnit() {
        return pricePerUnit;
    }

    public void setPricePerUnit(double pricePerUnit) {
        this.pricePerUnit = pricePerUnit;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}