package com.example.haruProject.service.js;

import java.util.List;
import java.util.Map;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.Schedule;

public interface ReservationService {

	List<Pet> getPetList(int memno);
	int getResTotalCnt(Map<String, Object> params);
	List<Appointment> getReservation(Map<String, Object> params);
	List<Common> getBCDList();
	List<Schedule> getDayOffSchedule(Map<String, Object> d);
	List<Schedule> getRegScheduleList(int ano, String currentEnd);
	void doAppointmentAction(Appointment app);

}
