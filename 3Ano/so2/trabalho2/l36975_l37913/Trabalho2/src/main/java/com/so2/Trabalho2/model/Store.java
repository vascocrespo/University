package com.so2.Trabalho2.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="store")

public class Store implements Serializable
{
    @Id
    @Column(name="identificador")
    @GeneratedValue(strategy=GenerationType.SEQUENCE)
    private long id;

    @Column(name="storeName",length=50)
    private String storeName;
    
    @Column(name="latitude")
    private double latitude;
    
    @Column(name="longitude")
    private double longitude;


	public Store()
    {

    }

    public void setId(long id)
    {
        this.id = id;
    }

    public long getId()
    {
        return id;
    }

    public String getStoreName()
    {
        return storeName;
    }

    public void setStoreName(String storeName)
    {
        this.storeName = storeName;
    }
    
    public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

}
