package com.so2.Trabalho2.services;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.so2.Trabalho2.dto.OcupationRequestDTO;
import com.so2.Trabalho2.dto.OcupationResponseDTO;
import com.so2.Trabalho2.model.Ocupation;
import com.so2.Trabalho2.model.Store;
import com.so2.Trabalho2.model.User;
import com.so2.Trabalho2.model.UserStore;
import com.so2.Trabalho2.repository.OcupationRepository;
import com.so2.Trabalho2.repository.StoreRepository;
import com.so2.Trabalho2.repository.UserRepository;

@Service
public class OcupationServices
{
    @Autowired
    private OcupationRepository autowired;

    @Autowired
    private StoreRepository storeRepository;

    @Autowired
    private UserRepository userRepository;

    public void createRegister(OcupationRequestDTO ocupationRequestDTO)
    {
        Optional<Store> store = this.storeRepository.findByStoreName(ocupationRequestDTO.getStore());
        Optional<User> user = this.userRepository.findByUsername(ocupationRequestDTO.getUsername());
        
        if(!store.isEmpty() && !user.isEmpty())
        {
        	
            UserStore userStore = new UserStore();
            userStore.setUser(user.get());
            userStore.setStore(store.get());
            userStore.setTimeStamp(new Date().getTime());

            Ocupation ocupation = new Ocupation();
            ocupation.setUserStore(userStore);
            ocupation.setLotacao(ocupationRequestDTO.getLotacao());
            this.autowired.save(ocupation);
        }
    }

    public List<Ocupation> findUser(Long userId)
    {
    	return this.autowired.findByUserStoreUserId(userId);
    }
    
    
    public Optional<Ocupation> findId(Long userId,Long id)
    {
    	return this.autowired.findByIdAndUserStoreUserId(id, userId);
    }

    public List<OcupationResponseDTO> getRegistos(String username)
    {
        Optional<User> opuser = this.userRepository.findByUsername(username);
        List <OcupationResponseDTO> listRespostas = new ArrayList<>();

        if(!opuser.isEmpty())
        {
            List <Ocupation> list = this.autowired.findByUserStoreUserId(opuser.get().getId());

            for(int i = 0; i < list.size(); i++)
            {
                OcupationResponseDTO ob = new OcupationResponseDTO();

                ob.setUsername(list.get(i).getUserStore().getUser().getUsername());
                ob.setStore(list.get(i).getUserStore().getStore().getStoreName());
                ob.setLotacao(list.get(i).getLotacao());

                listRespostas.add(ob);
            }
        }
        return listRespostas;
    }

    public ArrayList<Integer> getGrauOcupacaoLoja(String storeName)
    {
        long actualTimeStamp = new Date().getTime();
        Optional<Store> storeId = this.storeRepository.findByStoreName(storeName);

        ArrayList<Integer> grauOcupacao = new ArrayList<>();

        if(!storeId.isEmpty())
        {
        	Store store = storeId.get();
            List<Ocupation> opuser = this.autowired.findByUserStoreStoreId(store.getId());
            
            if(!opuser.isEmpty())
            {
                grauOcupacao.add(opuser.get(opuser.size()-1).getLotacao());
               
                for(int i = opuser.size()-2; i >= 0; i--)
                {
                    long actualOcupation = opuser.get(i).getUserStore().getTimeStamp();

                    if((actualTimeStamp - actualOcupation < 3600000))
                    {
                        grauOcupacao.add(opuser.get(i).getLotacao());
                    }
                }
            }
            else
            {
            	grauOcupacao.add(0);
            }
        }
        else
        {
        	grauOcupacao.add(-1);
        }
        return grauOcupacao;
    }

    public boolean removeRegisto(long id, long storeId, long userId)
    {

        List<Ocupation> ocupation = this.autowired.findByUserStoreUserIdAndUserStoreStoreId(userId, storeId);
        if(!ocupation.isEmpty())
        {
        	for(int i = 0; i< ocupation.size();i++)
            {
            	if(ocupation.get(i).getId() == id)
            	{
            		this.autowired.delete(ocupation.get(i));
            		return true;
            	}
            	
            }
        }
        
        return false;
    }
}
