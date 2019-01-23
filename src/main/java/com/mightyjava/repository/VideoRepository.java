package com.mightyjava.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.mightyjava.model.Video;

@Repository
public interface VideoRepository extends PagingAndSortingRepository<Video, Long> {
	@Query("FROM Video c ORDER BY c.date DESC")
	Page<Video> findAll(Pageable pageable);
}
