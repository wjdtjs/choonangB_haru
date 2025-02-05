package com.example.haruProject.dao.hj;

import java.util.Date;
import java.util.List;

import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.ScheRegularOff;
import com.example.haruProject.dto.Schedule;

public interface ScheduleDao {

	List<Schedule> 			getScheduleList();
	List<Common> 			getSchtypes();
	List<ScheRegularOff> 	getDocOffInfo();
	List<Date> 				getDocOffdays(ScheRegularOff regOffnfo);
	List<Schedule> 			getRegScheduleList();

}
