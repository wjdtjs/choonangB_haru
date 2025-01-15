package com.example.haruProject.dao.hr;

import java.util.List;

import com.example.haruProject.dto.Appointment;

public interface AppointmentDao {

	int getTotalCnt();

	List<Appointment> appointmentList(int startRow, int endRow);

}
