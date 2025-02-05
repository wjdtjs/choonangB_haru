package com.example.haruProject.service.hj;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hj.ScheduleDao;
import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.ScheRegularOff;
import com.example.haruProject.dto.Schedule;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ScheduleServiceImpl implements ScheduleService{
	
	private final ScheduleDao sd;

	@Override
	public List<Schedule> getScheduleList() {
		List<Schedule> schedule = sd.getScheduleList();
		return schedule ;
	}

	@Override
	public List<Common> getSchtypes() {
		List<Common> schTypeList = sd.getSchtypes();
		return schTypeList;
	}

	@Override
	public List<ScheRegularOff> getDocOffInfo() {
		List<ScheRegularOff> offInfo = sd.getDocOffInfo();
		return offInfo;
	}

	@Override
	public List<Date> getDocOffdays(ScheRegularOff regOffnfo) {
		List<Date> offdays = sd.getDocOffdays(regOffnfo);
		return offdays;
	}

	@Override
	public List<Schedule> getRegScheduleList() {
		List<Schedule> reg_schedules = sd.getRegScheduleList();
		return reg_schedules;
	}


}
