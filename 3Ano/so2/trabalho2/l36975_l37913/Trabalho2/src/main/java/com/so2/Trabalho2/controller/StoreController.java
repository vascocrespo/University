package com.so2.Trabalho2.controller;

import com.so2.Trabalho2.services.StoreServices;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.so2.Trabalho2.model.Store;

import java.util.List;
import java.util.Optional;


@Controller
public class StoreController
{
	@Autowired
    private StoreServices storeServices;
	
	@GetMapping("/createStore")
    public String createStore1(Model model)
    {
		SecurityContext securityContext = SecurityContextHolder.getContext();
    	String username = securityContext.getAuthentication().getName();
    	model.addAttribute("username",username);
    	
		Store store = new Store();
		model.addAttribute("store",store);
		return "storeAdd";
    }
	
	@PostMapping("/createStore")
    public String createStore2(@ModelAttribute("ocupation") Store store)
    {
        Optional<Store> storeId = this.storeServices.findStore(store.getStoreName());
        if(storeId.isEmpty())
        {
        	this.storeServices.createStore(store);
        	return "storeAdded";
        }
        
        return "storeAlreadyExists";
        
    }
	
	@GetMapping("/remStore")
    public String removeStore1(Model model)
    {
		SecurityContext securityContext = SecurityContextHolder.getContext();
    	String username = securityContext.getAuthentication().getName();
    	model.addAttribute("username",username);
    	List<Store> stores = this.storeServices.getStores();
    	model.addAttribute("stores",stores);
		String storeName = new String();
		model.addAttribute("storeName",storeName);
		return "storeRem";
    }
	
	@PostMapping("/remStore")
    public String remStore2(@RequestParam(name = "storeName") String storeName)
    {
		Optional<Store> stores = this.storeServices.findStore(storeName);
        if(stores.isEmpty())
            return "storeNotFound";
        
        this.storeServices.deleteStore(stores.get());
        return "remStoreSuccess";
    }
}
