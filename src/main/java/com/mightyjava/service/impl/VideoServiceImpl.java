package com.mightyjava.service.impl;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
import com.mightyjava.model.Video;
import com.mightyjava.repository.CategoryRepository;
import com.mightyjava.repository.VideoRepository;
import com.mightyjava.service.VideoService;
import com.mightyjava.utils.ConstantUtils;

@Service
@Transactional(readOnly = true)
public class VideoServiceImpl implements VideoService {

	@Autowired
	private CategoryRepository categoryRepository;
	
	@Autowired
	private VideoRepository videoRepository;
	
	@Autowired
	private MessageConfig messageConfig;
	
	@Override
	public List<Video> videoList() {
		return (List<Video>) videoRepository.findAll();
	}
	
	@Override
	public Page<Video> findAll(Pageable pageable) {
		return videoRepository.findAll(new PageRequest(pageable.getPageNumber() - 1, ConstantUtils.PAGINATION_SIZE));
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
	public String addVideo(Video video) {
		String message = null;
		JSONObject jsonObject = new JSONObject();
		try {
			if(video.getId() == null) {
				message = messageConfig.getMessage("label.added");
			} else {
				message = messageConfig.getMessage("label.updated");
			}
			video.setDate(new Date());
			jsonObject.put("status", "success");
			String[] msg = {message};
			
			jsonObject.put("title", messageConfig.getMessage("label.confirmation", msg));
			video.setYouTubeURL(video.getYouTubeURL().replace("watch?v=", "embed/"));
			
			Set<Category> categorySet = new HashSet<Category>();
			Long[] categories = video.getSelectedCategories();
			for (Long categoryId : categories) {
				categorySet.add(categoryRepository.findOne(categoryId));
			}
			video.setCategories(categorySet);
			
			String[] msg2 = {videoRepository.save(video).getTitle(), message};
			jsonObject.put("message", messageConfig.getMessage("video.save.success", msg2));
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return jsonObject.toString();

	}

	@Override
	public Video findOne(Long id) {
		return videoRepository.findOne(id);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
	public String deleteVideo(Long id) {
		JSONObject jsonObject = new JSONObject();
		try {
			videoRepository.delete(id);
			jsonObject.put("message", messageConfig.getMessage("video.delete.success"));
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return jsonObject.toString();
	}

}
