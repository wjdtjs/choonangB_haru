package com.example.haruProject.service.hj;

import java.util.List;

import org.apache.catalina.User;
import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hj.UserMainDao;
import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Notice;
import com.example.haruProject.dto.Pet;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserMainServiceImpl implements UserMainService {
	private final UserMainDao ud;

	@Override
	public List<Notice> getNoticeList() {
		List<Notice> notices = ud.getNoticeList();
		return notices;
	}

	@Override
	public List<Pet> getPetList(int memno) {
		List<Pet> pets = ud.getPetList(memno);
		return pets;
	}

	@Override
	public Appointment getCommingRes(int memno) {
		Appointment comingRes = ud.getCommingRes(memno);
		return comingRes;
	}
}
