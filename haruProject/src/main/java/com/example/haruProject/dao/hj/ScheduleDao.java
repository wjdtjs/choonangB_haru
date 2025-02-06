package com.example.haruProject.dao.hj;

import java.util.Date;
import java.util.List;

import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.ScheRegularOff;
import com.example.haruProject.dto.Schedule;

public interface ScheduleDao {

	List<Schedule> 			getScheduleList(String current);
	List<Schedule> 			getRegScheduleList(String current);
	List<Common> 			getSchtypes();
	Date			 		getChangedOff(Schedule schedule);
	List<String> 			getDocOffdays(Schedule schedule, String currentEnd);

}
