package com.example.haruProject.service.hj;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.example.haruProject.dto.Admin;
import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.ScheRegularOff;
import com.example.haruProject.dto.Schedule;

public interface ScheduleService {

	List<Schedule> 			getScheduleList(String current);
	List<Schedule> 			getRegScheduleList(String current, String currentEnd);
	List<Common> 			getSchtypes();
	Date					getChangedOff(Schedule schedule);
	List<String> 			getDocOffdays(Schedule schedule, String currentEnd);
	List<Admin> 			searchAdmin(String keyword);
	int						insertSchedule(Schedule schedule);
	Schedule 				getSchedule(int schno);
	int						deleteSchedule(int schno);
	int						updateSchedule(Schedule sch);

}
