package com.example.haruProject.dao.hj;

import java.util.List;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Notice;
import com.example.haruProject.dto.Pet;

public interface UserMainDao {

	List<Notice> 		getNoticeList();
	List<Pet> 			getPetList(int memno);
	Appointment 		getCommingRes(int memno);

}
