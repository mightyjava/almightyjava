package com.mightyjava.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.mightyjava.model.Category;

@Repository
public interface CategoryRepository extends PagingAndSortingRepository<Category, Long> {
	@Query("FROM Category c ORDER BY c.name")
	List<Category> categoryList();
	
	@Query("FROM Category c ORDER BY c.date DESC")
	Page<Category> findAll(Pageable pageable);
	
	@Query("FROM Category c WHERE c.name=:name")
	Category findByName(@Param("name") String name);
}
