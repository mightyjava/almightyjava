package com.mightyjava.service.impl;

import java.util.List;

import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mightyjava.config.MessageConfig;
import com.mightyjava.model.Role;
import com.mightyjava.model.User;
import com.mightyjava.repository.RoleRepository;
import com.mightyjava.repository.UserRepository;
import com.mightyjava.service.UserService;
import com.mightyjava.utils.ConstantUtils;

@Service
@Transactional(readOnly = true)
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private RoleRepository roleRepository;
	
	@Autowired
	private MessageConfig messageConfig;
	
	@Override
	public List<User> userList() {
		return userRepository.userList();
	}
	
	@Override
	public Page<User> findAll(Pageable pageable) {
		return userRepository.findAll(new PageRequest(pageable.getPageNumber() - 1, ConstantUtils.PAGINATION_SIZE));
	}
	
	@Override
	public Page<User> findAll(Long id, Pageable pageable) {
		return userRepository.findAll(id, new PageRequest(pageable.getPageNumber() - 1, ConstantUtils.PAGINATION_SIZE));
	}

	@Override
	public User findOne(Long id) {
		return userRepository.findOne(id);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
	public String addUser(User user) {
		String message = null;
		JSONObject jsonObject = new JSONObject();
		try {
			if(user.getId() == null) {
				user.setUserId("User" + System.currentTimeMillis());
				user.setPassword(new BCryptPasswordEncoder().encode(user.getPassword()));
				message = messageConfig.getMessage("label.added");
			} else {
				message = messageConfig.getMessage("label.updated");
			}
			if(user.getInputSource().equals("register")) {
				user.setRole(roleRepository.findByName("user"));
			} else {
				user.setRole(roleRepository.findOne(user.getRoleId()));
			}
			jsonObject.put("source", user.getInputSource());
			jsonObject.put("status", "success");
			String[] msg = {message};
			jsonObject.put("title", messageConfig.getMessage("label.confirmation", msg));
			
			String[] msg2 = {userRepository.save(user).getFullName(), message};
			jsonObject.put("message", messageConfig.getMessage("user.save.success", msg2));
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return jsonObject.toString();
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
	public String deleteUser(Long id) {
		JSONObject jsonObject = new JSONObject();
		try {
			userRepository.delete(id);
			jsonObject.put("message", messageConfig.getMessage("user.delete.success"));
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	@Override
	public List<Role> roleList() {
		return roleRepository.findAll();
	}

	@Override
	public User findByUsername(String username) {
		return userRepository.findByUsername(username); 
	}

}
