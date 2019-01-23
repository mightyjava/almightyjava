package com.mightyjava.model;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;

import org.springframework.data.jpa.domain.AbstractPersistable;

import com.mightyjava.utils.ConstantUtils;
import com.mightyjava.validator.Validate;

@Entity
public class User extends AbstractPersistable<Long> {
	private static final long serialVersionUID = -7302800336276816169L;
	private transient Long id;
	
	@Validate(min=5, max=30, regexp=ConstantUtils.CHAR_PATTERN, message="Please enter between {min}-{max} characters and no digits")
	private String fullName;
	
	private String userId;
	
	@NotNull
	@Validate(min=3, max=15, regexp=ConstantUtils.ID_PATTERN, message="Please enter between {min}-{max} characters and digits")
	private String userName;
	
	private String password;
	
	@NotNull
	@Validate(min=10, max=100, regexp=ConstantUtils.EMAIL_PATTERN, message="Please enter between {min}-{max} characters and valid input")
	private String email;
	
	@Validate(min=10, max=10, regexp=ConstantUtils.MOBILE_PATTERN, message="Please enter atleast {min} digits and no characters")
	private String mobile;
	
	private transient Long roleId;
	private transient String inputSource;
	private transient String captcha;

	@ManyToOne
	@JoinColumn(name = "role_id")
	private Role role;

	@OneToMany(targetEntity = Address.class, mappedBy = "user", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private Set<Address> addresses;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	public String getInputSource() {
		return inputSource;
	}

	public void setInputSource(String inputSource) {
		this.inputSource = inputSource;
	}

	public String getCaptcha() {
		return captcha;
	}

	public void setCaptcha(String captcha) {
		this.captcha = captcha;
	}
	
}
