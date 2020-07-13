package com.so2.Trabalho2.model;

import java.io.Serializable;
import java.util.Objects;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Embeddable

public class UserStore implements Serializable
{
    @ManyToOne(cascade=CascadeType.ALL) //cada user pode ter varios registos
    @JoinColumn(name= "utilizador_id")
    @OnDelete(action=OnDeleteAction.CASCADE)
    private User user;

    @ManyToOne(cascade=CascadeType.ALL) //cada user pode ter varios registos
    @JoinColumn(name= "store_id")
    @OnDelete(action=OnDeleteAction.CASCADE)
    private Store store;

    @Column(name="timeStamp")
    private long timeStamp;

    public UserStore()
    {

    }

    public void setUser(User user)
    {
        this.user = user;
    }

    public User getUser()
    {
        return user;
    }

    public Store getStore() {
        return store;
    }

    public void setStore(Store store) {
        this.store = store;
    }

    public long getTimeStamp()
    {
        return timeStamp;
    }

    public void setTimeStamp(long timeStamp)
    {
        this.timeStamp = timeStamp;
    }


    @Override
    public int hashCode() {
        return Objects.hash(user,store);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final UserStore other = (UserStore) obj;
        if (!Objects.equals(this.user, other.user)) {
            return false;
        }
        if (!Objects.equals(this.store, other.store)) {
            return false;
        }
        return true;
    }

}
