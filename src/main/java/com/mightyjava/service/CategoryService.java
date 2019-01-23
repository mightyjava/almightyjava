package com.mightyjava.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.mightyjava.model.Category;

public interface CategoryService {
	List<Category> categoryList();
	
	Page<Category> findAll(Pageable pageable);
	
	String addCategory(Category category);
	
	Category findOne(Long id);
	
	String deleteCategory(Long id);
}
