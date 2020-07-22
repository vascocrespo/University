package com.so2.Trabalho2.repository;

import java.util.Optional;

import com.so2.Trabalho2.model.Store;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StoreRepository extends JpaRepository<Store, Long>
{
    Optional <Store> findByStoreName(String storeName);
    
}
