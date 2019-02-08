package com.mightyjava.controller;

import java.util.concurrent.atomic.AtomicInteger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.mightyjava.captcha.CaptchaGenerator;
import com.mightyjava.captcha.CaptchaUtils;
import com.mightyjava.model.User;
import com.mightyjava.service.UserService;
import com.mightyjava.utils.ConstantUtils;
import com.mightyjava.utils.ErrorUtils;
import com.mightyjava.utils.MethodUtils;

import nl.captcha.Captcha;

@Controller
@RequestMapping("/user")
@SessionAttributes("counter")
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private CaptchaGenerator captchaGenerator;
	
	@ModelAttribute("counter")
	public AtomicInteger failureCounter() {
		return new AtomicInteger(0);
	}

	@RequestMapping("/login")
	public String login(ModelMap model, HttpSession httpSession) {
		Object error = httpSession.getAttribute("error");
		if (error != null) {
			model.addAttribute("error", error);
			httpSession.removeAttribute("error");
		}
		
		Object message = httpSession.getAttribute("message");
		if (message != null) {
			model.addAttribute("message", message);
			httpSession.removeAttribute("message");
		}
		
		AtomicInteger counter = (AtomicInteger) model.get("counter");
		if(counter.intValue() >= ConstantUtils.MAX_CAPTCHA_TRIES) {
			Captcha captcha = captchaGenerator.createCaptcha(200, 50);
			httpSession.setAttribute("captcha", captcha);
			model.addAttribute("captchaEncode", CaptchaUtils.encodeBase64(captcha));
		}
		return "login";
	}

	@GetMapping("/register")
	public String register(Model model, HttpSession httpSession) {
		model.addAttribute("userForm", new User());
		
		Captcha captcha = captchaGenerator.createCaptcha(200, 50);
		httpSession.setAttribute("captcha", captcha.getAnswer());
		model.addAttribute("captchaEncode", CaptchaUtils.encodeBase64(captcha));
		return "register";
	}

	@GetMapping("/form")
	public String userForm(Model model) {
		model.addAttribute("isNew", true);
		model.addAttribute("userForm", new User());
		model.addAttribute("roles", userService.roleList());
		return "user/form";
	}

	@GetMapping("/edit/{id}")
	public String userOne(@PathVariable Long id, Model model) {
		model.addAttribute("isNew", false);
		model.addAttribute("userForm", userService.findOne(id));
		model.addAttribute("roles", userService.roleList());
		return "user/form";
	}

	@GetMapping(value = "/delete/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody String userDelete(@PathVariable Long id) {
		return userService.delete(id);
	}

	@PostMapping(value = "/add", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody String userAdd(@Valid @RequestBody User user, BindingResult result, HttpServletRequest request) {
		String response = null;
		if (result.hasErrors()) {
			response = ErrorUtils.customErrors(result.getAllErrors());
		} else {
			if(user.getCaptcha().equals(request.getSession().getAttribute("captcha"))) {
				response = userService.add(user);
			} else {
				response = ErrorUtils.captchaError();
			}
		}
		return response;
	}
	
	@PostMapping(value = "/save", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody String saveUser(@Valid @RequestBody User user, BindingResult result) {
		return (result.hasErrors()) ? ErrorUtils.customErrors(result.getAllErrors()) : userService.add(user);
	}

	@GetMapping("/list")
	public String userList(Model model, Pageable pageable) {
		Page<User> pages = userService.findAll(pageable);
		model.addAttribute("users", pages.getContent());
		MethodUtils.pageModel(model, pages);
		return "/user/list";
	}

	@GetMapping("{userId}/list")
	public String userOneList(@PathVariable Long userId, Model model, Pageable pageable) {
		Page<User> pages = userService.findAll(userId, pageable);
		model.addAttribute("users", pages.getContent());
		MethodUtils.pageModel(model, pages);
		return "/user/list";
	}
	
	@GetMapping("/changePassword/{id}")
	public String changePassword(@PathVariable Long id, Model model) {
		model.addAttribute("user", userService.findOne(id));
		return "/user/changePassword";
	}
	
}
