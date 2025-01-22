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
		System.out.println("AppointmentServiceImp getTotalCnt() si ->"+si);
		
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
	
	//예약 상세
	@Override
	public Appointment appointmentDetail(String resno) {
		System.out.println("AppointmentServiceImp appointmentDetail() start ,,,");
		System.out.println("AppointmentServiceImp appointmentDetail() resno ->"+resno);
		
		Appointment appointment_d = new Appointment();
		
		appointment_d = ad.appointmentDetail(resno);
		
		return appointment_d;
	}
	
	// 예약 수정
	@Override
	public int updateReservation(String resno, int rtime, String memo, int status) {
		System.out.println("AppointmentServiceImp updateReservation() start ,,,");
		System.out.println("AppointmentServiceImp updateReservation() resno ->"+resno);
		System.out.println("AppointmentServiceImp updateReservation() rtime ->"+rtime);
		System.out.println("AppointmentServiceImp updateReservation() memo ->"+memo);
		System.out.println("AppointmentServiceImp updateReservation() status ->"+status);
		
		int result = ad.updateReservation(resno, rtime, memo, status);
		
		return result;
	}



	

	// 진료 내역
	@Override
	public int getTotalCntChart(SearchItem si) {
		System.out.println("AppointmentServiceImp getTotalCntChart() start ,,,");
		System.out.println("AppointmentServiceImp getTotalCntChart() si ->"+si);
		
		int totalCnt = ad.getTotalCntChart(si);
		
		return totalCnt;
	}

	@Override
	public List<Appointment> consultationListChart(int startRow, int endRow, SearchItem si) {
		System.out.println("AppointmentServiceImp consultationListChart() start ,,,");
		System.out.println("AppointmentServiceImp consultationListChart() si ->"+si);
		
		List<Appointment> cList = new ArrayList<>();
		
		cList = ad.consultationListChart(startRow, endRow, si);
		
		return cList;
	}


}
