package com.so2.Trabalho2.dto;

public class UserRequestDTO {
	 private String username;
	 private String password;
	 private String roles;
	 private boolean active;
	 
	
	public String getRoles() {
		return roles;
	}
	public void setRoles(String roles) {
		this.roles = roles;
	}
	public boolean isActive() {
		return active;
	}
	public void setActive(boolean active) {
		this.active = active;
	}
	@Override
	public String toString() {
		return "UserRequestDTO [username=" + username + ", password=" + password + ", roles=" + roles + "]";
	}
	public UserRequestDTO() {
		
	 }
	 public String getUsername() {
		return username;

	 }

	 public void setUsername(String username) {
			this.username = username;
	 }

	 public String getPassword() {
			return password;
	 }

	 public void setPassword(String password) {
			this.password = password;

	 }
}
