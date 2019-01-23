package com.mightyjava.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.mightyjava.model.Address;
import com.mightyjava.model.User;

@Repository
public interface AddressRepository extends PagingAndSortingRepository<Address, Long> {
	@Query("FROM Address")
	List<Address> addressList();

	@Query("FROM Address a WHERE a.user=:user")
	Page<Address> findAll(@Param("user") User user, Pageable pageable);
	
	@Query("FROM Address a WHERE a.addressType=:addressType AND a.user=:user")
	Address findByAddressTypeAndUser(@Param("addressType") String addressType, @Param("user") User user);
}
