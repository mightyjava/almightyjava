package com.mightyjava.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.mightyjava.model.Video;

public interface VideoService {
	List<Video> videoList();
	
	Page<Video> findAll(Pageable pageable);

	String addVideo(Video video);

	Video findOne(Long id);

	String deleteVideo(Long id);
}
