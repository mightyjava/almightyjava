package com.mightyjava.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import com.mightyjava.captcha.CaptchaAuthenticationProvider;
import com.mightyjava.captcha.CaptchaDetailsSource;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SpringSecurityConfiguration extends WebSecurityConfigurerAdapter {

	@Autowired
	private CaptchaAuthenticationProvider authenticationProvider;

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.authenticationProvider(authenticationProvider);
	}
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/webjars/**", "/js/**", "/css/**");
	}
	
	@Autowired
	private CaptchaDetailsSource detailsSource;

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable().authorizeRequests()
			.antMatchers("/user/register", "/user/add").permitAll()
			.anyRequest().authenticated().and()
			.formLogin().loginPage("/user/login")
			.successHandler(loginSuccessHandler())
			.failureHandler(loginFailureHandler())
			.authenticationDetailsSource(detailsSource).permitAll().and()
			.logout().logoutSuccessHandler(logoutSuccessHandler())
			.deleteCookies("remember-me").permitAll().and()
			.rememberMe().tokenValiditySeconds(180); 
	}
	
	@Autowired
	private Environment environment;
	
	@Autowired
	private MessageConfig messageConfig;
	
	private AuthenticationSuccessHandler loginSuccessHandler() {
		return (request, response, authentication) -> response
				.sendRedirect(environment.getProperty("server.context-path"));
	}
	
	private AuthenticationFailureHandler loginFailureHandler() {
		return (request, response, exception) -> {
			request.getSession().setAttribute("error", messageConfig.getMessage("user.invalid.credentials"));
			response.sendRedirect(environment.getProperty("server.context-path") + "/user/login");
		};
	}
	
	private LogoutSuccessHandler logoutSuccessHandler() {
		return (request, response, authentication) -> {
			request.getSession().setAttribute("message", messageConfig.getMessage("user.logout.success"));
			response.sendRedirect(environment.getProperty("server.context-path") + "/user/login");
		};
	}
}