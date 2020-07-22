package com.so2.Trabalho2.model;


import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="ocupation")

public class Ocupation implements Serializable
{
	         //chave primaria
    @Embedded
    private UserStore userStore;
	
	@Id
    @Column(name="id")
    @GeneratedValue(strategy=GenerationType.SEQUENCE)
    private long id;

	

    @Column (name="lotacao")
    private int lotacao;

    public Ocupation()
    {

    }

    public UserStore getUserStore() {
        return userStore;
    }

    public void setUserStore(UserStore userStore) {
        this.userStore = userStore;
    }

    public long getId() {
  		return id;
  	}

  	public void setId(long id) {
  		this.id = id;
  	}
    
    public int getLotacao() {
        return lotacao;
    }

    public void setLotacao(int lotacao) {
        this.lotacao = lotacao;
    }

}
