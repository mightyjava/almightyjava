package com.mightyjava.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.mightyjava.model.Role;

@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {
	@Query("FROM Role r WHERE r.name=:name")
	Role findByName(@Param("name") String name);
}
