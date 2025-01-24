package com.example.haruProject.controller.admin.hj;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.haruProject.controller.admin.js.UploadController;
import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Chart;
import com.example.haruProject.dto.ChartDetail;
import com.example.haruProject.service.hj.ConsultationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class ConsultationController {
	
	private final ConsultationService cs;
	
	@RequestMapping(value = "/admin/addConsultationView")
	public String addConsultation(@RequestParam("resno") String resno, Model model) {
		
		System.out.println("ConsultationController addConsultation ...");
		System.out.println("ConsultationController addConsultation resno->"+resno);
		Appointment apm =  cs.getConsultation(resno);
		
		model.addAttribute("apm",apm);
		
		return "admin/addConsultation";
	}
	
	@PostMapping(value = "/admin/addChart")
	public String addChart(Chart ch,
							@RequestParam("content") List<MultipartFile> files,
							HttpServletRequest request, Model model) {
		System.out.println("ConsultController addChart Start ...");
		System.out.println("ConsultController addChart files->"+files);
		
		
		String type = "chart";
		List<String> imgPaths = saveImages(type,request);
		
		String img1 = imgPaths.size() > 0 ? imgPaths.get(0) : null;
		String img2 = imgPaths.size() > 1 ? imgPaths.get(1) : null;
		String img3 = imgPaths.size() > 2 ? imgPaths.get(2) : null;
		String img4 = imgPaths.size() > 3 ? imgPaths.get(3) : null;
		String img5 = imgPaths.size() > 4 ? imgPaths.get(4) : null;
		ch.setImg1(img1);
		ch.setImg2(img2);
		ch.setImg3(img3);
		ch.setImg4(img4);
		ch.setImg5(img5);
		System.out.println("ConsultController addChart ch->"+ch);

		
		int result = cs.addChart(ch);
		
		return "redirect:admin/addConsultation";
	}

	/**
	 * 이미지 저장
	 * @param type
	 * @param request
	 * @return
	 */
	private List<String> saveImages(String type, HttpServletRequest request) {
		UploadController uc = new UploadController();
		List<String> imgPaths = new ArrayList<>();
		
		// 이미지 저장
		try {
			// 여러 이미지 파일 가져오기
			Collection<Part> parts = request.getParts();
			for(Part image : parts) {
				System.out.println(image);
				if(image.getName().startsWith("main_img") && image.getSize()>0) {
					InputStream inputStream = image.getInputStream();
					
					//파일 확장자 구하기
					String fileName = image.getSubmittedFileName();
					String[] split = fileName.split("\\.");
					String suffix = split[split.length -1];

					log.info("fileName -> {}", fileName);
					log.info("suffix -> {}",suffix);
					
					// 저장파일 경로 설정
					// Servlet 상속 받지 못했을 때 realPath 불러오는 방법
					String type_path = "/upload/"+type+"/";
					String uploadPath = request.getSession().getServletContext().getRealPath(type_path);
					System.out.println("upload Path: {}"+ uploadPath);
					
					// 파일저장
					System.out.println("uploadForm() PostStart...");
					String savedName = uc.uploadFile(type, inputStream, uploadPath, suffix);

					// 저장된 경로를 리스트에 춧가
					System.out.println("Return savedName: {}"+savedName);
					String imgPath = type_path+savedName;
					imgPaths.add(imgPath);
					System.out.println("imgPath"+imgPaths);
				}
			}	
		} catch (Exception e) {
			System.out.println("image upload error :"+e.getMessage());
		}
		return imgPaths;
	}
	
	@RequestMapping(value = "/admin/detailConsultation")
	public String detailConsulatation(@RequestParam("resno") String resno, Model model) {
		System.out.println("ConsultationController detailConsulatation ...");
		System.out.println("ConsultationController detailConsulatation resno->"+resno);
		Appointment apm =  cs.getConsultation(resno);
		Chart chart = cs.getChart(resno);
		
		
		model.addAttribute("apm",apm);
		model.addAttribute("chart",chart);
		
		return "admin/detailConsultation";
	}

}
