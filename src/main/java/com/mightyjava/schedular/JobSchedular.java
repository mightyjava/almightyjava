package com.mightyjava.schedular;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mightyjava.model.Address;
import com.mightyjava.service.HelperService;
import com.mightyjava.service.UserService;

@Component
public class JobSchedular {
	
	private static Logger logger = Logger.getLogger(JobSchedular.class);
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private HelperService<Address> addressService;
	
	//@Scheduled(cron = "*/5 * * * * *")
	public void scheduleUsingCron() {
		logger.info(userService.list());
	}

	//@Scheduled(fixedDelay = 1000, initialDelay = 1000)
	public void scheduleUsingFixedDelayWithInitialDelay() {
		logger.info(userService.findOne(1L)); 
	}

	//@Scheduled(fixedDelay = 1000)
	public void scheduleUsingDelay() {
		logger.info(addressService.list());
	}

	//@Scheduled(fixedRate = 5000) 
	public void scheduleUsingRate() {
		logger.info(addressService.findOne(1L));
	}
}
