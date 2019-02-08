package com.mightyjava.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.mightyjava.model.Video;
import com.mightyjava.service.HelperService;
import com.mightyjava.service.UserService;
import com.mightyjava.utils.MethodUtils;

@Controller
public class WelcomeController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private HelperService<Video> videoService;
	
	@GetMapping("/")
	public String welcome(Model model) {
		model.addAttribute("user", userService.findByUsername(MethodUtils.findLoggedInUser().getUsername()));
		return "welcome";
	}

	@GetMapping("/home/list")
	public String welcome(Model model, Pageable pageable) {
		Page<Video> pages = videoService.findAll(pageable);
		model.addAttribute("videos", pages.getContent());
		MethodUtils.pageModel(model, pages);
		return "/video/videos";
	}
}
