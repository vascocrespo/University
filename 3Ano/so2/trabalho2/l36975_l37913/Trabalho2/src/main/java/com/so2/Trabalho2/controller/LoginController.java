package com.so2.Trabalho2.controller;


import java.util.Collection;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.so2.Trabalho2.dto.UserRequestDTO;
import com.so2.Trabalho2.model.User;
import com.so2.Trabalho2.services.UserServices;

@Controller
public class LoginController
{
	@Autowired
	private UserServices userServices;

	@RequestMapping("/")
	public String style(Model model)
	{
		SecurityContext securityContext = SecurityContextHolder.getContext();
		String username = securityContext.getAuthentication().getName();

		if(username == "anonymousUser")
		{
			return "paginaInicial";
		}
		else 
		{
			model.addAttribute("username",username);
			return "index2";
		}
	}
	
	@GetMapping("/remUser")
	public String removeUser1(Model model)
	{
		SecurityContext securityContext = SecurityContextHolder.getContext();
    	String username = securityContext.getAuthentication().getName();
    	model.addAttribute("username",username);
    	
		List<User> users = this.userServices.getRegularUsers("ROLE_USER");
		model.addAttribute("users",users);
		String userToRemove = new String();
		model.addAttribute(userToRemove);
		
		return "remUser1";
	}
	
	@PostMapping("/remUser")
	public String removeUser2(@ModelAttribute("userToRemove") String userName)
	{
		Optional<User> user = this.userServices.findUser(userName);
		if(user.isEmpty())
		{
			return "userNotFound";
		}
		
		this.userServices.deleteUser(user.get());
		return "remUserSuccess";
	}
	
	
	@GetMapping("/register")
	public String showForm(Model model)
	{
		UserRequestDTO user = new UserRequestDTO();
		model.addAttribute("user", user);
		return "register_form";
	}

	@PostMapping("/register")
	public String submitForm(@ModelAttribute("user") UserRequestDTO user)
	{
		User newUser = new User();
		newUser.setUsername(user.getUsername());
		newUser.setPassword(user.getPassword());
		newUser.setActive(true);
		newUser.setRoles("ROLE_USER");

		Optional<User> userThere = this.userServices.findUser(newUser.getUsername());

		if(userThere.isEmpty() && newUser.getUsername() != "" && newUser.getPassword() != "")
		{
			this.userServices.createUser(newUser);

			return "register_success";
		}
		return "register_sem_success";
	}

	@RequestMapping("/menu")
	public String afterlogin(Model model)
	{
		SecurityContext securityContext = SecurityContextHolder.getContext();

		String username = securityContext.getAuthentication().getName();
		String admin = "ROLE_ADMIN";
    	Collection<? extends GrantedAuthority> authorities = securityContext.getAuthentication().getAuthorities();
    	model.addAttribute("username",username);
    	for(GrantedAuthority authority:authorities)
    	{
    		String i = authority.toString();
    		if(i.equalsIgnoreCase(admin))
    		{
    			return "menuAdmin";
    		}
    		
    		else
    		{
    			return "menuUser";
    		}
    			
    	}		
    	return "menuUser";
	}
	
	@RequestMapping("/menuAdmin")
	public String admin(Model model)
	{
		SecurityContext securityContext = SecurityContextHolder.getContext();

		String username = securityContext.getAuthentication().getName();
		model.addAttribute("username",username);
		
		return "admin";
	}
	
	
}
