package com.mightyjava.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.validation.constraints.NotNull;

import org.springframework.data.jpa.domain.AbstractPersistable;

@Entity
public class Video extends AbstractPersistable<Long> {

	private static final long serialVersionUID = 6925700222524694956L;

	@NotNull
	private String title;

	@NotNull
	private String youTubeURL;
	
	private Date date;
	
	@ManyToMany(cascade = CascadeType.ALL)
	@JoinTable(name = "video_category", joinColumns = { @JoinColumn(name = "video_id") }, inverseJoinColumns = { @JoinColumn(name = "category_id") })
	private Set<Category> categories = new HashSet<Category>();
	
	private transient Long[] selectedCategories;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getYouTubeURL() {
		return youTubeURL;
	}

	public void setYouTubeURL(String youTubeURL) {
		this.youTubeURL = youTubeURL;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Set<Category> getCategories() {
		return categories;
	}

	public void setCategories(Set<Category> categories) {
		this.categories = categories;
	}

	public Long[] getSelectedCategories() {
		return selectedCategories;
	}

	public void setSelectedCategories(Long[] selectedCategories) {
		this.selectedCategories = selectedCategories;
	}
	
}