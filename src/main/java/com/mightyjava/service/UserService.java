package com.mightyjava.service;

import java.util.List;

import com.mightyjava.model.Role;
import com.mightyjava.model.User;

public interface UserService extends HelperService<User> {
	
	User findByUsername(String username);
	
	List<Role> roleList();
	
}
