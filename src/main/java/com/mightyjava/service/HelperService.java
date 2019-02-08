package com.mightyjava.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface HelperService<C> {
	List<C> list();
	
	Page<C> findAll(Pageable pageable);
	
	Page<C> findAll(Long id, Pageable pageable);
	
	C findOne(Long id);
	
	String add(C type);
	
	String delete(Long id);
}
