package com.example.haruProject.dao.hr;

import java.util.List;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.Weight;

public interface UserPetDao {

	List<Pet> getPetList(int memno);

	List<Pet> getSpeciesBcd();

	List<Pet> getSpeciesMcd(int bcd);

	Pet getPetDetail(int petno);

	List<Weight> getPetWeightList(int petno, int startRow, int endRow);
	List<Weight> getPetWeightList(int petno);

	List<Appointment> getPAppointmentList(int petno);

	int deletePet(int petno);

	void addPet(Pet pet);

	void updatePet(Pet pet, boolean img_change);

	void updateWeight(Weight weight);

	int getWeightCnt(int petno, int startRow, int endRow);

	int getWeightCnt(int petno);


}
