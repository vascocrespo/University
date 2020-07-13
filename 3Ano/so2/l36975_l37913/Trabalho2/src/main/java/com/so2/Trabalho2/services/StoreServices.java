package com.so2.Trabalho2.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.so2.Trabalho2.model.Store;
import com.so2.Trabalho2.repository.StoreRepository;


@Service

public class StoreServices
{
    @Autowired
    private StoreRepository autowired;

    public void createStore(Store store)
    {
    	this.autowired.save(store);
    }
    
    public Optional<Store> findStore(String storeName)
    {
    	return this.autowired.findByStoreName(storeName);
    }

    public List<Store> getStores()
    {
        return this.autowired.findAll();
    }

    public void deleteStore(Store store)
    {
    	this.autowired.delete(store);
    }
    
    
    public void deleteStores()
    {
        this.autowired.deleteAll();
    }
}
