package com.example.haruProject.service.hj;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hj.ScheduleDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ScheduleServiceImpl implements ScheduleService{
	
	private final ScheduleDao sd;
}
