package com.mightyjava.service.impl;

import java.util.List;

import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.mightyjava.config.MessageConfig;
import com.mightyjava.model.Address;
import com.mightyjava.model.User;
import com.mightyjava.repository.AddressRepository;
import com.mightyjava.repository.UserRepository;
import com.mightyjava.service.HelperService;
import com.mightyjava.utils.ConstantUtils;

@Service
public class AddressServiceImpl implements HelperService<Address> {
	@Autowired
	private AddressRepository addressRepository;
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private MessageConfig messageConfig;

	@Override
	public List<Address> list() {
		return addressRepository.addressList();
	}
	
	@Override
	public Page<Address> findAll(Pageable pageable) {
		return addressRepository.findAll(new PageRequest(pageable.getPageNumber() - 1, ConstantUtils.PAGINATION_SIZE));
	}
	
	@Override
	public Page<Address> findAll(Long userId, Pageable pageable) {
		return addressRepository.findAll(userRepository.findOne(userId), new PageRequest(pageable.getPageNumber() - 1, ConstantUtils.PAGINATION_SIZE));
	}

	@Override
	public Address findOne(Long id) {
		return addressRepository.findOne(id);
	}

	@Override
	public String add(Address address) { 
		String message = null;
		JSONObject jsonObject = new JSONObject();
		try {
			if (address.getId() == null) {
				message = messageConfig.getMessage("label.added");
			} else {
				message = messageConfig.getMessage("label.updated");
			}
			User user = userRepository.findOne(address.getUserId());
			address.setUser(user); 
			
			String[] msg = {message};
			jsonObject.put("title", messageConfig.getMessage("label.confirmation", msg));
			
			String[] msg2 = {user.getFullName(), message};
			if(addressRepository.findByAddressTypeAndUser(address.getAddressType(), user) == null) {
				jsonObject.put("status", "success");
				addressRepository.save(address);
				jsonObject.put("message", messageConfig.getMessage("address.save.success", msg2));
			} else {
				jsonObject.put("status", "failure");
				jsonObject.put("message", messageConfig.getMessage("address.save.failure", msg2));
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return jsonObject.toString();
	}

	@Override
	public String delete(Long id) {
		JSONObject jsonObject = new JSONObject();
		try {
			addressRepository.delete(id);
			jsonObject.put("message", messageConfig.getMessage("address.delete.success"));
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return jsonObject.toString();
	}


}
