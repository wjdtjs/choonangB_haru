package com.example.haruProject.service.hj;

import java.util.List;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Notice;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.Product;

public interface UserMainService {

	List<Notice> 			getNoticeList();
	List<Pet> 				getPetList(int memno);
	Appointment				getCommingRes(int memno);
	List<Product>			getPopProductList();

}
