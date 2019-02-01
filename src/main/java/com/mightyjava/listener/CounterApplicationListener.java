package com.mightyjava.listener;

import java.util.concurrent.atomic.AtomicInteger;

import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationListener;
import org.springframework.security.authentication.event.AbstractAuthenticationFailureEvent;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class CounterApplicationListener implements ApplicationListener<AbstractAuthenticationFailureEvent> {

	@Override
	public void onApplicationEvent(AbstractAuthenticationFailureEvent failureEvent) {
		AtomicInteger counter = (AtomicInteger) getSession().getAttribute("counter");
		counter.incrementAndGet();
	}
	
	private HttpSession getSession() {
		ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		return attributes.getRequest().getSession(false);
	}

}
