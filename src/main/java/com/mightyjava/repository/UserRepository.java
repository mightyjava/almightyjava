package com.mightyjava.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.mightyjava.model.User;

@Repository
public interface UserRepository extends PagingAndSortingRepository<User, Long> {
	
	@Query("FROM User WHERE userName=:username")
	User findByUsername(@Param("username") String username);
	
	@Query("FROM User")
	List<User> userList();
	
	@Query("FROM User u WHERE u.id=:id")
	Page<User> findAll(@Param("id") Long id, Pageable pageable);
}
