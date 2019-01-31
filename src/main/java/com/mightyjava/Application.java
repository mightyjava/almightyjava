package com.mightyjava;

import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import com.mightyjava.captcha.CaptchaGenerator;

@EnableBatchProcessing
@SpringBootApplication
public class Application {
 
	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}
	
	@Bean
	public CaptchaGenerator getCaptchaGenerator() {
		return new CaptchaGenerator();
	}
}
