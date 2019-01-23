package com.mightyjava.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.mightyjava.model.Role;
import com.mightyjava.model.User;

public interface UserService {
	
	User findByUsername(String username);
	
	List<User> userList();
	
	Page<User> findAll(Pageable pageable);
	
	Page<User> findAll(Long userId, Pageable pageable);
	
	User findOne(Long id);
	
	String addUser(User user);
	
	String deleteUser(Long id);
	
	List<Role> roleList();
	
}
