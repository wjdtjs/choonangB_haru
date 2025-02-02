package com.example.haruProject.service.hr;

import java.util.List;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.Weight;

public interface UserPetService {

	List<Pet> getPetList(int memno);

	List<Pet> getSpeciesBcd();

	List<Pet> getSpeciesMcd(int bcd);

	Pet getPetDetail(int petno);

	List<Weight> getPetWeightList(int petno);

	List<Appointment> getPAppointmentList(int petno);

	int deletePet(int petno);

}
