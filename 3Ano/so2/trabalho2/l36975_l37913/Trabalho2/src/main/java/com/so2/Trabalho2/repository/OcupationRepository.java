package com.so2.Trabalho2.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.so2.Trabalho2.model.Ocupation;
import com.so2.Trabalho2.model.UserStore;

public interface OcupationRepository extends JpaRepository<Ocupation, UserStore>
{
    public List <Ocupation> findByUserStoreUserId(long userId);
    public List <Ocupation> findByUserStoreStoreId(long storeName);
    public List <Ocupation> findByUserStoreUserIdAndUserStoreStoreId(long userId,long storeName);
    public Optional<Ocupation> findByIdAndUserStoreUserId(long id,long userId);
    public Optional<Ocupation> findById(long userId);
    //public void deleteByUserStoreStoreIdUserId(String storeName, String userId);

}
