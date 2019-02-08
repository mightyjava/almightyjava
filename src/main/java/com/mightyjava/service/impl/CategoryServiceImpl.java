package com.mightyjava.service.impl;

import java.util.Date;
import java.util.List;

import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mightyjava.config.MessageConfig;
import com.mightyjava.model.Category;
import com.mightyjava.repository.CategoryRepository;
import com.mightyjava.service.HelperService;
import com.mightyjava.utils.ConstantUtils;

@Service
@Transactional(readOnly = true)
public class CategoryServiceImpl implements HelperService<Category> {

	@Autowired
	private CategoryRepository categoryRepository;
	
	@Autowired
	private MessageConfig messageConfig;
	
	@Override
	public List<Category> list() {
		return categoryRepository.categoryList();
	}
	
	@Override
	public Page<Category> findAll(Pageable pageable) {
		return categoryRepository.findAll(new PageRequest(pageable.getPageNumber() - 1, ConstantUtils.PAGINATION_SIZE));
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
	public String add(Category category) {
		String message = null;
		JSONObject jsonObject = new JSONObject();
		try {
			if(category.getId() == null) {
				message = messageConfig.getMessage("label.added");
			} else {
				message = messageConfig.getMessage("label.updated");
			}
			category.setDate(new Date());
			jsonObject.put("status", "success");
			String[] msg = {message};
			jsonObject.put("title", messageConfig.getMessage("label.confirmation", msg));
			
			String[] msg2 = {categoryRepository.save(category).getName(), message};
			jsonObject.put("message", messageConfig.getMessage("category.save.success", msg2));
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return jsonObject.toString();

	}

	@Override
	public Category findOne(Long id) {
		return categoryRepository.findOne(id);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
	public String delete(Long id) {
		JSONObject jsonObject = new JSONObject();
		try {
			categoryRepository.delete(id);
			jsonObject.put("message", messageConfig.getMessage("category.delete.success"));
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return jsonObject.toString();
	}

	@Override
	public Page<Category> findAll(Long id, Pageable pageable) {
		return null;
	}

}
