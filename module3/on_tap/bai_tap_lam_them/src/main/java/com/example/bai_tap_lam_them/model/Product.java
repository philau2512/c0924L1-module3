package com.example.bai_tap_lam_them.model;

public class Product {
    private String code;
    private String name;
    private String unit;
    private double pricePerUnit;
    private int categoryId;

    public Product() {
    }

    public Product(String code, String name, String unit, double pricePerUnit, int categoryId) {
        this.code = code;
        this.name = name;
        this.unit = unit;
        this.pricePerUnit = pricePerUnit;
        this.categoryId = categoryId;
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

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
}