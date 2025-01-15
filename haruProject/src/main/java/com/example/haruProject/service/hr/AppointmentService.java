package com.example.haruProject.service.hr;

import java.util.List;

import com.example.haruProject.dto.Appointment;

public interface AppointmentService {

	int getTotalCnt();

	List<Appointment> appointmentList(int startRow, int endRow);

}
