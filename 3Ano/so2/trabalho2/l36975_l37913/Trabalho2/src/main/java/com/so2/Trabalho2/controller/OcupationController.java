package com.so2.Trabalho2.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.so2.Trabalho2.dto.OcupationRequestDTO;
import com.so2.Trabalho2.dto.OcupationResponseDTO;
import com.so2.Trabalho2.model.Location;
import com.so2.Trabalho2.model.Ocupation;
import com.so2.Trabalho2.model.Store;
import com.so2.Trabalho2.model.User;
import com.so2.Trabalho2.services.OcupationServices;
import com.so2.Trabalho2.services.StoreServices;
import com.so2.Trabalho2.services.UserServices;


@Controller
public class OcupationController
{
	@Autowired
    private OcupationServices ocupationServices;

	@Autowired
    private UserServices userServices;
	
	@Autowired
    private StoreServices storeServices;

	@GetMapping ("/getOcupation")
	public String getGrauOcupacaoStore(Model model)
	{
		SecurityContext securityContext = SecurityContextHolder.getContext();
		String username = securityContext.getAuthentication().getName();

		String storeName = new String();
		model.addAttribute("storeName",storeName);
		model.addAttribute("username",username);

		if(username == "anonymousUser")
		{
			return "getOcupationSemLogin";
		}
		return "getOcupationComLogin";
	}

	@PostMapping("/getOcupation")
	public String getGrauOcupacao(@RequestParam(name = "storeName") String storeName,Model model)
	{
		ArrayList<Integer> grausOcupacao = this.ocupationServices.getGrauOcupacaoLoja(storeName);

		if(grausOcupacao.get(0) == -1)
		{
			return "storeNotFound";
		}
		else if(grausOcupacao.get(0) == 0)
		{
			return "storeSemStats";
		}
		else
		{
			model.addAttribute("grausOcupacao",grausOcupacao);
			return "getOcupationLoja";
		}
	}

	@GetMapping("/setOcupation")
	public String getRegister(Model model)
    {
		SecurityContext securityContext = SecurityContextHolder.getContext();

		String username = securityContext.getAuthentication().getName();
		model.addAttribute("username",username);

		OcupationRequestDTO ocupation = new OcupationRequestDTO();
		model.addAttribute("ocupation",ocupation);

		return "setOcupation1";
    }

	@PostMapping("/setOcupation")
    public String createRegister(@ModelAttribute("ocupation") OcupationRequestDTO ocupation,Model model)
    {
		SecurityContext securityContext = SecurityContextHolder.getContext();
		String username = securityContext.getAuthentication().getName();
		ocupation.setUsername(username);

		Optional<Store> checkStores = this.storeServices.findStore(ocupation.getStore());

		if(!checkStores.isEmpty())
		{
			this.ocupationServices.createRegister(ocupation);
			model.addAttribute("ocupation",ocupation);
			
			return "setOcupation2";
		}
		return "storeNotFound";
    }

    @RequestMapping ("/getRegistos")
    public String getRegistos(Model model)
    {
    	SecurityContext securityContext = SecurityContextHolder.getContext();
    	String username = securityContext.getAuthentication().getName();

		List<OcupationResponseDTO> ocupations = this.ocupationServices.getRegistos(username);
		if(ocupations.isEmpty())
		{
			return "semMyRegistos";
		}
		model.addAttribute("ocupations",ocupations);
		model.addAttribute("username",username);

		return "getMyRegistos";
    }
    
    @GetMapping("/remRegisto")
    public String removeRegisto(Model model)
    {
    	SecurityContext securityContext = SecurityContextHolder.getContext();
		String username = securityContext.getAuthentication().getName();

		Optional<User> users = this.userServices.findUser(username);
		long userId = users.get().getId();

		List <Ocupation> userStoresPossiveis = this.ocupationServices.findUser(userId);
		if(!userStoresPossiveis.isEmpty())
		{
			List<OcupationRequestDTO> stores1 = new ArrayList<>();

			for(int i = 0; i < userStoresPossiveis.size(); i++)
			{
				OcupationRequestDTO ocupations = new OcupationRequestDTO();
				ocupations.setId(userStoresPossiveis.get(i).getId());
				ocupations.setStore(userStoresPossiveis.get(i).getUserStore().getStore().getStoreName());
				ocupations.setUsername(userStoresPossiveis.get(i).getUserStore().getUser().getUsername());
				ocupations.setLotacao(userStoresPossiveis.get(i).getLotacao());
				stores1.add(ocupations);
			}

			long ocupationId = 0;

	    	model.addAttribute("ocupationId",ocupationId);
	    	model.addAttribute("username",username);
			model.addAttribute("storess",stores1);
			return "remRegisto"; 
		}
		
		return "nothingToRem";
        
    }
    
    @PostMapping("/remRegisto")
    public String removerRegisto2(@RequestParam(name = "ocupationId") long ocupationId)
    {
    	
    	SecurityContext securityContext = SecurityContextHolder.getContext();
		String username = securityContext.getAuthentication().getName();

		Optional<User> user = userServices.findUser(username);
		long userId = user.get().getId();
		Optional<Ocupation> rightOcupation = ocupationServices.findId(userId, ocupationId);
		

		if(rightOcupation.isEmpty())
		{
			return "storeNotFound";
		}
		else
		{
			boolean isIt = this.ocupationServices.removeRegisto(rightOcupation.get().getId(),rightOcupation.get().getUserStore().getStore().getId(),rightOcupation.get().getUserStore().getUser().getId());
			if(isIt)
				return "remRegistoSuccess";
			
			return "remRegistoFailed";
			
		}
    }
    
    @GetMapping("/nearStore")
    public String getLocation(Model model)
    {
    	SecurityContext securityContext = SecurityContextHolder.getContext();

    	String username = securityContext.getAuthentication().getName();
     	
    	model.addAttribute("username",username);

    	Location location = new Location();
    	model.addAttribute("location",location);

    	return "nearStore1";
    }
    
    @PostMapping("/nearStore")
    public String getNearStore(@ModelAttribute("location") Location location, Model model)
    {
    	List<Store> stores = this.storeServices.getStores();
    	double difference1 = stores.get(0).getLatitude() - location.getLatitude();
    	double difference2 = stores.get(0).getLongitude() - location.getLongitude();
    	double differenceTotal = Math.abs(difference1 + difference2);
    	double differenteCompare = differenceTotal;

    	Store theOneStore = stores.get(0);
    	
    	for(int i = 0; i < stores.size();i++)
    	{
    		difference1 = stores.get(i).getLatitude() - location.getLatitude();
    		difference2 = stores.get(i).getLongitude() - location.getLongitude();
    		differenceTotal = Math.abs(difference1 + difference2);

    		if(differenceTotal < differenteCompare)
    		{
    			differenteCompare = differenceTotal;
    			theOneStore = stores.get(i);
			}
    	}
    	model.addAttribute("theOneStore",theOneStore);


    	return "nearStore2";
    }
}
