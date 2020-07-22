package com.so2.Trabalho2.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.so2.Trabalho2.model.User;
import com.so2.Trabalho2.repository.UserRepository;

@Service

public class UserServices 
{
    @Autowired
    private UserRepository autowired;
    
    public void createUser(User user)
    {
    	this.autowired.save(user);
    }
   
    
    public List<User> getRegularUsers(String role) {
    	return this.autowired.findByRoles(role);	
	}
    
    public void deleteUser(User user)
    {
    	this.autowired.delete(user);
    }
    
    
    public Optional<User> findUser(String username)
    {
		return this.autowired.findByUsername(username);
	}
    
    
    public List<User> getUsers()
    {
        return this.autowired.findAll();
    }
    
    public void deleteUsers()
    {
        this.autowired.deleteAll();
    }
}