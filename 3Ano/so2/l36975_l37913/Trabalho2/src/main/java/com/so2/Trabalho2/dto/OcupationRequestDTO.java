package com.so2.Trabalho2.dto;

public class OcupationRequestDTO
{
    private String username;
    private String store;
    private int lotacao;
    private long id;

    

	public OcupationRequestDTO()
    {

    }

    public String getUsername() {
        return username ;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getStore() {
        return store;
    }

    public void setStore(String store) {
        this.store = store;
    }

    public int getLotacao() {
        return lotacao;
    }

    public void setLotacao(int lotacao) {
        this.lotacao = lotacao;
    }
    
    public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

}
