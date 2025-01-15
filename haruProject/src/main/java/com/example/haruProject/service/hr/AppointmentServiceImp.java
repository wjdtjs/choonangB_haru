package com.example.haruProject.service.hr;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hr.AppointmentDao;
import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.SearchItem;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class AppointmentServiceImp implements AppointmentService {
	private final AppointmentDao ad;
	

	// 예약 내역
	@Override
	public int getTotalCnt(SearchItem si) {
		System.out.println("AppointmentServiceImp getTotalCnt() start ,,,");
		
		int totalCnt = ad.getTotalCnt(si);
		
		return totalCnt;
	}

	@Override
	public List<Appointment> appointmentList(int startRow, int endRow, SearchItem si) {
		System.out.println("AppointmentServiceImp appointmentList() start ,,,");
		
		List<Appointment> aList = new ArrayList<>();
		
		aList = ad.appointmentList(startRow, endRow, si);
		
		return aList;
	}

	

	// 진료 내역
	@Override
	public int getTotalCntChart() {
		System.out.println("AppointmentServiceImp getTotalCntChart() start ,,,");
		
		int totalCnt = ad.getTotalCntChart();
		
		return totalCnt;
	}

	@Override
	public List<Appointment> consultationListChart(int startRow, int endRow) {
		System.out.println("AppointmentServiceImp consultationListChart() start ,,,");
		
		List<Appointment> cList = new ArrayList<>();
		
		cList = ad.consultationListChart(startRow, endRow);
		
		return cList;
	}

}
