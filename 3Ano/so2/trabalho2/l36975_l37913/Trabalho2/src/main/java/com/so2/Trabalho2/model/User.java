package com.so2.Trabalho2.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="Utilizador")
public class User implements Serializable{
	@Id
    @Column(name="id")
    @GeneratedValue(strategy=GenerationType.SEQUENCE)   //SERIAL 
    private long id;
	
    
    @Column(name= "username",length=20) 
    private String username;
    
    @Column(name="password")
    private String password;
    
    @Column(name="roles",length = 20)
    private String roles;
    
    @Column(name="active")
    private boolean active;
    

	public User()
    {
        
    }
    
    public void setId(long id)
    {
        this.id = id;
    }
    
    public long getId()
    {
        return id;
    }
    
    public void setUsername(String username)
    {
        this.username = username;
    }
    
    public String getUsername()
    {
        return username;
    }
    
    public void setPassword(String password)
    {
        this.password = password;
    }
    
    public String getPassword()
    {
        return password;
    }
    
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
}
