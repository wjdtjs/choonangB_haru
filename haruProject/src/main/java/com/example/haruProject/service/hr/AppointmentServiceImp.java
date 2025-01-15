package com.example.haruProject.service.hr;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hr.AppointmentDao;
import com.example.haruProject.dto.Appointment;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class AppointmentServiceImp implements AppointmentService {
	private final AppointmentDao ad;

	@Override
	public int getTotalCnt() {
		System.out.println("AppointmentServiceImp getTotalCnt() start ,,,");
		
		int totalCnt = ad.getTotalCnt();
		
		return totalCnt;
	}

	@Override
	public List<Appointment> appointmentList(int startRow, int endRow) {
		System.out.println("AppointmentServiceImp appointmentList() start ,,,");
		
		List<Appointment> aList = new ArrayList<>();
		
		aList = ad.appointmentList(startRow, endRow);
		
		return aList;
	}

}
