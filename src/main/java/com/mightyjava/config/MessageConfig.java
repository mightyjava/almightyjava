package com.mightyjava.config;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;

@Component
public class MessageConfig {
	
	@Autowired
	private MessageSource messageSource;
	
	public String getMessage(String key) {
		Locale locale = LocaleContextHolder.getLocale();
		return messageSource.getMessage(key, null, locale);
	}
	
	public String getMessage(String key, String [] strArray) {
		Locale locale = LocaleContextHolder.getLocale();
		return messageSource.getMessage(key, strArray, locale);
	}

}
