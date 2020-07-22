
package com.so2.Trabalho2.repository;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

import com.so2.Trabalho2.model.User;

public interface UserRepository extends JpaRepository<User, Long>
{
    public Optional<User> findByUsername(String username);
    public List<User> findByRoles(String role);
}