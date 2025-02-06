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
	public List<Schedule> getScheduleList(String current) {
		List<Schedule> schedule = sd.getScheduleList(current);
		return schedule ;
	}

	@Override
	public List<Schedule> getRegScheduleList(String current) {
		List<Schedule> reg_schedules = sd.getRegScheduleList(current);
		return reg_schedules;
	}

	@Override
	public List<Common> getSchtypes() {
		List<Common> schTypeList = sd.getSchtypes();
		return schTypeList;
	}

	@Override
	public Date getChangedOff(Schedule schedule) {
		Date offInfo = sd.getChangedOff(schedule);
		return offInfo;
	}

	@Override
	public List<String> getDocOffdays(Schedule schedule, String currentEnd) {
		List<String> offdays = sd.getDocOffdays(schedule, currentEnd);
		return offdays;
	}



}
