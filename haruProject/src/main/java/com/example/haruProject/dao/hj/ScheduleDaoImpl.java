package com.example.haruProject.dao.hj;

import static org.hamcrest.CoreMatchers.nullValue;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.ScheRegularOff;
import com.example.haruProject.dto.Schedule;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ScheduleDaoImpl implements ScheduleDao {
	
	private final SqlSession session;

	@Override
	public List<Schedule> getScheduleList() {
		List<Schedule> schedules = new ArrayList<>();
		
	try {
		schedules = session.selectList("HJSelectScheduleList");
	} catch (Exception e) {
		System.out.println("ScheduleDao getScheduleList() Error-> "+e.getMessage());
	}
		return schedules;
	}

	@Override
	public List<Common> getSchtypes() {
		List<Common> schTypeList = new ArrayList<>();
		try {
			schTypeList = session.selectList("HJSelectSchtype");
			System.out.println("ScheduleDao getSchtypes() schTypeList-> "+schTypeList);
		} catch (Exception e) {
			System.out.println("ScheduleDao getSchtypes() Error-> "+e.getMessage());
		}
		return schTypeList;
	}

	@Override
	public List<ScheRegularOff> getDocOffInfo() {
		List<ScheRegularOff> offInfo = null;
		try {
			offInfo = session.selectList("HJGetDocOffInfo");
			System.out.println("ScheduleDao getDocOffInfo() offdays-> "+offInfo);
		} catch (Exception e) {
			System.out.println("ScheduleDao getDocOffInfo() Error-> "+e.getMessage());

		}
		return offInfo;
	}

	@Override
	public List<Date> getDocOffdays(ScheRegularOff regOffnfo) {
		List<Date> offdays = null;
		Map<String, Object> paramMap = new HashMap();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date()); // 현재 날짜 기준
		cal.add(Calendar.MONTH, 2); // 2개월 추가
		Date currentDatePlus2Months = cal.getTime();
		
		
		paramMap.put("regOffnfo", regOffnfo);
		paramMap.put("after2m", currentDatePlus2Months); 
		System.out.println("ScheduleDao getDocOffdays paramMap-> "+paramMap);
		try {
			offdays = session.selectList("HJGetDocOffdays",paramMap);
			System.out.println("ScheduleDao getDocOffdays offdays-> "+offdays);
		} catch (Exception e) {
			System.out.println("ScheduleDao getDocOffdays() Error-> "+e.getMessage());
		}
		return offdays;
	}

	@Override
	public List<Schedule> getRegScheduleList() {
		List<Schedule> reg_schedules = new ArrayList<>();
		try {
			reg_schedules = session.selectList("HJDocRegOffs");
			System.out.println("ScheduleDao getRegScheduleList reg_schedules-> "+reg_schedules);
		} catch (Exception e) {
			System.out.println("ScheduleDao getRegScheduleList() Error-> "+e.getMessage());

		}
		return reg_schedules;
	}

}
