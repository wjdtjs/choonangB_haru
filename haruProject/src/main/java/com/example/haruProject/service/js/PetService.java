package com.example.haruProject.service.js;

import java.util.List;

import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.dto.Weight;

public interface PetService {

	int getTotalCnt(SearchItem si);
	List<Pet> getPetList(Pagination pagination, SearchItem si);
	Pet getPetDetail(Pet pet);
	int addWeight(Weight weight);


}
