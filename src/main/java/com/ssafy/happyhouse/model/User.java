package com.ssafy.happyhouse.model;

import java.io.Serializable;

public class User implements Serializable {
	private String id;
	private String name;
	private String pass;
	private String email;

	public User() {
		super();
	}
	public User(String id, String name, String pass, String email) {
		super();
		this.id = id;
		this.name = name;
		this.pass = pass;
		this.email= email;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", pass=" + pass + ", name=" + name + ",email="+email+"]";
	}

}
