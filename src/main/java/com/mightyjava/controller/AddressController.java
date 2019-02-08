package com.mightyjava.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mightyjava.model.Address;
import com.mightyjava.service.HelperService;
import com.mightyjava.service.UserService;
import com.mightyjava.utils.ErrorUtils;
import com.mightyjava.utils.MethodUtils;

@Controller
@RequestMapping("/address")
public class AddressController {
	@Autowired
	private HelperService<Address> addressService;
	
	@Autowired
	private UserService userService;

	@GetMapping("/form")
	public String addressForm(Model model) {
		model.addAttribute("isNew", true);
		model.addAttribute("addressForm", new Address());
		model.addAttribute("addressTypes", MethodUtils.addressTypes());
		model.addAttribute("users", userService.list());
		model.addAttribute("user", userService.findByUsername(MethodUtils.findLoggedInUser().getUsername()));
		return "address/form";
	}
	
	@GetMapping("/edit/{id}")
	public String addressOne(@PathVariable Long id, Model model) {
		model.addAttribute("isNew", false);
		model.addAttribute("addressForm", addressService.findOne(id));
		model.addAttribute("addressTypes", MethodUtils.addressTypes());
		model.addAttribute("users", userService.list());
		return "address/form";
	}
	
	@GetMapping(value = "/delete/{id}", produces=MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody String addressDelete(@PathVariable Long id) {
		return addressService.delete(id);
	}
	
	@PostMapping(value = "/add", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody String addressAdd(@Valid @RequestBody Address address, BindingResult result) {
		if(result.hasErrors()) {
			return ErrorUtils.customErrors(result.getAllErrors());
		} else {
			return addressService.add(address);
		}
	}
	
	@GetMapping("/list")
	public String addressList(Model model, Pageable pageable) {
		Page<Address> pages = addressService.findAll(pageable);
		model.addAttribute("addresses", pages.getContent());
		MethodUtils.pageModel(model, pages);
		return "/address/list";
	}
	
	@GetMapping("{userId}/list")
	public String addressOneList(@PathVariable Long userId, Model model, Pageable pageable) {
		Page<Address> pages = addressService.findAll(userId, pageable);
		model.addAttribute("addresses", pages.getContent());
		MethodUtils.pageModel(model, pages);
		return "/address/list";
	}
	
}