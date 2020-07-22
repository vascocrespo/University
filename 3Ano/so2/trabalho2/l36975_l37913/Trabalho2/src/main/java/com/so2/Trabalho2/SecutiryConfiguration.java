package com.so2.Trabalho2;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;



@EnableWebSecurity
public class SecutiryConfiguration extends WebSecurityConfigurerAdapter{
	@Autowired
	UserDetailsService userDetailsService;
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception
	{
		auth.userDetailsService(userDetailsService);
	}

	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
			.antMatchers("/createStore","/menuAdmin","/remStore","/remUser").hasRole("ADMIN")
			.antMatchers("/menu","/getOcupation","/setOcupation","/getRegistos","/remRegisto","/nearStore").hasAnyRole("ADMIN","USER")
			.antMatchers("/","/register","/getOcupation").permitAll()
			.and().formLogin()
			.defaultSuccessUrl("/menu",true)
			.and().logout().logoutSuccessUrl("/")
			.logoutRequestMatcher(new AntPathRequestMatcher("/logout"));
	}
	
	@Bean
	public PasswordEncoder getPasswordEncoder()
	{
		return NoOpPasswordEncoder.getInstance();
	}
	

}
