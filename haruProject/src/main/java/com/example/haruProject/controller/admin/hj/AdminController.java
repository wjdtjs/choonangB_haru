package com.example.haruProject.controller.admin.hj;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.haruProject.dto.Admin;
import com.example.haruProject.service.hj.AdminService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminController {
	
	private final AdminService as;
	
	@RequestMapping(value = "/api/adminList")
	public List<Admin> adminListAll() {
		System.out.println("AdminController adminListAll Start...");
		List<Admin> adminList = as.adminListAll();
		System.out.println("AdminController adminListAll adminList-> "+adminList);
		return adminList;
		
	}
	

}
