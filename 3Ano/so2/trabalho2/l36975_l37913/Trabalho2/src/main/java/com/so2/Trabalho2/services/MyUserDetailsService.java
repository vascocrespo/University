package com.so2.Trabalho2.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.so2.Trabalho2.model.MyUserDetails;
import com.so2.Trabalho2.model.User;
import com.so2.Trabalho2.repository.UserRepository;

@Service
public class MyUserDetailsService implements UserDetailsService
{
	@Autowired
	UserRepository userRepository;
	
	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException
	{
		Optional<User> user = userRepository.findByUsername(userName);
		
		user.orElseThrow(() -> new UsernameNotFoundException("Not found: " + userName));
		
		return user.map(MyUserDetails::new).get();
	}
}
