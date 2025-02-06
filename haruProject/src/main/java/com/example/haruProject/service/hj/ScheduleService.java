package com.example.haruProject.service.hj;

import java.util.Date;
import java.util.List;

import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.ScheRegularOff;
import com.example.haruProject.dto.Schedule;

public interface ScheduleService {

	List<Schedule> 			getScheduleList(String current);
	List<Schedule> 			getRegScheduleList(String current);
	List<Common> 			getSchtypes();
	Date					getChangedOff(Schedule schedule);
	List<String> 				getDocOffdays(Schedule schedule, String currentEnd);

}
