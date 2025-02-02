package com.example.haruProject.service.js;

import java.util.List;
import java.util.Map;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Pet;

public interface ReservationService {

	List<Pet> getPetList(int memno);
	int getResTotalCnt(Map<String, Object> params);
	List<Appointment> getReservation(Map<String, Object> params);

}
