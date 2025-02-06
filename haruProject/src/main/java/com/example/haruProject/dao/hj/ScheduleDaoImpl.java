package com.example.haruProject.dao.hj;

import static org.hamcrest.CoreMatchers.nullValue;

import java.text.SimpleDateFormat;
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
	public List<Schedule> getScheduleList(String current) {
		List<Schedule> schedules = null;
		System.out.println("Dao getScheduleList current->" + current);
		
	try {
		schedules = session.selectList("HJSelectScheduleList",current);
		System.out.println("Dao getScheduleList schedules->" + schedules);
	} catch (Exception e) {
		System.out.println("ScheduleDao getScheduleList() Error-> "+e.getMessage());
	}
		return schedules;
	}
	
	// 의사 정기 휴무
	@Override
	public List<Schedule> getRegScheduleList(String current) {
		List<Schedule> reg_schedules = new ArrayList<>();
		try {
			reg_schedules = session.selectList("HJRegScheduleList" ,current);

			System.out.println("ScheduleDao getRegScheduleList reg_schedules-> "+current);
			System.out.println("ScheduleDao getRegScheduleList reg_schedules-> "+reg_schedules);
		} catch (Exception e) {
			System.out.println("ScheduleDao getRegScheduleList() Error-> "+e.getMessage());
			}
		return reg_schedules;
	}
	
	/* 중분류 */
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
	public Date getChangedOff(Schedule schedule) {
		Date changedoff= null;
		try {
			changedoff = session.selectOne("HJGetChangedOff",schedule);
			System.out.println("ScheduleDao getChangedOff() changedoff-> "+changedoff);
		} catch (Exception e) {
			System.out.println("ScheduleDao getChangedOff() Error-> "+e.getMessage());

		}
		return changedoff;
	}

	@Override
	public List<String> getDocOffdays(Schedule schedule,String currentEnd) {
		List<String> offdays = null;
		Map<String,Object> parammap = new HashMap<>();
		Date currentEndStr = null;
		try {
            SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd"); // 날짜 포맷 지정
            currentEndStr = sdf.parse(currentEnd); // 문자열을 Date로 변환
		} catch (Exception e) {
			System.out.println("currentEnd 변환 실패");
		}
		parammap.put("currentEnd", currentEndStr);
		parammap.put("sche", schedule);
		
		System.out.println("ScheduleDao getDocOffdays paramMap-> "+parammap);
		try {
			offdays = session.selectList("HJGetDocOffdays",parammap);
			System.out.println("ScheduleDao getDocOffdays offdays-> "+offdays);
		} catch (Exception e) {
			System.out.println("ScheduleDao getDocOffdays() Error-> "+e.getMessage());
		}
		return offdays;
	}

}
