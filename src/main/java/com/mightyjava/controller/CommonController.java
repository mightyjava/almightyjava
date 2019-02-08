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
import org.springframework.web.bind.annotation.ResponseBody;

import com.mightyjava.model.Category;
import com.mightyjava.model.Video;
import com.mightyjava.service.HelperService;
import com.mightyjava.utils.ErrorUtils;
import com.mightyjava.utils.MethodUtils;

@Controller
public class CommonController {
	
	@Autowired	
	private HelperService<Category> categoryService;
	
	@Autowired	
	private HelperService<Video> videoService; 
	
	@GetMapping("/category/list")
	public String categoryList(Model model, Pageable pageable) {
		Page<Category> pages = categoryService.findAll(pageable);
		model.addAttribute("categories", pages.getContent());
		MethodUtils.pageModel(model, pages);
		return "/category/list";
	}
	
	@GetMapping("/category/form")
	public String categoryForm(Model model) {
		model.addAttribute("isNew", true);
		model.addAttribute("categoryForm", new Category());
		return "/category/form";
	}
	
	@PostMapping(value = "/category/add", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody String categoryAdd(@Valid @RequestBody Category category, BindingResult result) {
		return (result.hasErrors()) ? ErrorUtils.customErrors(result.getAllErrors()) : categoryService.add(category);
	}
	
	@GetMapping("/category/edit/{id}")
	public String categoryOne(@PathVariable Long id, Model model) {
		model.addAttribute("isNew", false);
		model.addAttribute("categoryForm", categoryService.findOne(id));
		return "/category/form";
	}

	@GetMapping(value = "/category/delete/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody String categoryDelete(@PathVariable Long id) {
		return categoryService.delete(id);
	}
	
	@GetMapping("/video/list")
	public String videoList(Model model, Pageable pageable) {
		Page<Video> pages = videoService.findAll(pageable);
		model.addAttribute("videos", pages.getContent());
		MethodUtils.pageModel(model, pages);
		return "/video/list";
	}
	
	@GetMapping("/video/form")
	public String videoForm(Model model) {
		model.addAttribute("isNew", true);
		model.addAttribute("videoForm", new Video());
		model.addAttribute("categories", categoryService.list());
		return "/video/form";
	}
	
	@PostMapping(value = "/video/add", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody String videoAdd(@Valid @RequestBody Video video, BindingResult result) {
		return (result.hasErrors()) ? ErrorUtils.customErrors(result.getAllErrors()) : videoService.add(video);
	}
	
	@GetMapping("/video/edit/{id}")
	public String videoOne(@PathVariable Long id, Model model) {
		model.addAttribute("isNew", false);
		model.addAttribute("videoForm", videoService.findOne(id));
		model.addAttribute("categories", categoryService.list());
		return "/video/form";
	}

	@GetMapping(value = "/video/delete/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody String videoDelete(@PathVariable Long id) {
		return videoService.delete(id);
	}
	
	@GetMapping("/blog/list")
	public String blogList(Model model) {
		return "/blog/list";
	}
	
}
