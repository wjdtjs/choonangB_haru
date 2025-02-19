package com.example.haruProject.controller.admin.hj;

import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
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
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.Weight;
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

	/* 차트작성 뷰 */
	@RequestMapping(value = "/admin/addConsultationView")
	public String addConsultation(@RequestParam("resno") String resno, Model model) {
		
		System.out.println("ConsultationController addConsultation ...");
		System.out.println("ConsultationController addConsultation resno->"+resno);
		Appointment apm =  cs.getConsultation(resno);
		Weight weight = cs.getPetWeight(apm.getPetno(),apm.getMemno(),apm.getRdate());
		System.out.println("ConsultationController addConsultation weight->"+weight);
		
		model.addAttribute("apm",apm);
		model.addAttribute("weight",weight);
		
		return "admin/addConsultation";
	}
	
	/* 차트 추가 */
	@PostMapping(value = "/admin/addChart")
	public String addChart(Chart ch,
							Pet pet,
							Weight weight,
							@RequestParam("file") List<MultipartFile> files,
							HttpServletRequest request, Model model) {
		System.out.println("ConsultController addChart Start ...");
		System.out.println("ConsultController addChart ch ->"+ch);
		System.out.println("ConsultController addChart pet ->"+pet);
		System.out.println("ConsultController addChart weight ->"+weight);
		System.out.println("ConsultController addChart files->"+files);
		
		String type = "chart";
		List<String> imgPaths = saveImages(type,files,request);
		
		if (pet.getPetheight() != null) { 
			int updateResult = cs.updatePetHight(pet);
		}
		if(weight.getPetweight() != null) {
			int insertResult = cs.insertPetWeight(weight);
		}
		cs.addChart(ch);
		cs.chartImgSave(imgPaths,ch);
		
		return "redirect:/admin/consultation";
	}

	/**
	 * 이미지 저장
	 * @param type
	 * @param request
	 * @return
	 */
	private List<String> saveImages(String type, List<MultipartFile> files, HttpServletRequest request) {
		UploadController uc = new UploadController();
		List<String> imgPaths = new ArrayList<>();
		
		// 이미지 저장
		try {
			for(MultipartFile file : files) {
				// 파일 이름 및 확장자 추출
				String fileName = file.getOriginalFilename();
				String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
				log.info("fileName -> {}", fileName);
				log.info("suffix -> {}",suffix);
				
				// 빈 파일 체크
	            if (file.isEmpty()) {
	                log.warn("첨부된 파일이 비어 있음: {}", file.getOriginalFilename());
	                continue; // 빈 파일이면 건너뛰기
	            }
	            
				// 저장파일 경로 설정
				// Servlet 상속 받지 못했을 때 realPath 불러오는 방법
				String type_path = "/upload/"+type+"/";
				String uploadPath = request.getSession().getServletContext().getRealPath(type_path);
				System.out.println("upload Path: {}"+ uploadPath);
				
				// 파일 저장
				InputStream inputStream = file.getInputStream();
                String savedName = uc.uploadFile(type, inputStream, uploadPath, suffix);
                
                // 저장된 경로를 리스트에 추가
                String imgPath = type_path + savedName;
                imgPaths.add(imgPath);
                System.out.println("imgPath: " + imgPath);
			}	
		} catch (Exception e) {
			System.out.println("image upload error :"+e.getMessage());
		}
		return imgPaths;
	}
	
	/* 차트수정 뷰 */
	@RequestMapping(value = "/admin/detailConsultation")
	public String detailConsulatation(@RequestParam("resno") String resno, Model model) {
		System.out.println("ConsultationController detailConsulatation ...");

		Appointment apm =  cs.getConsultation(resno);
		Chart chart = cs.getChart(resno);
		List<ChartDetail> chartImgs = cs.getImages(resno);
		
		Weight weight = cs.getPetWeight(apm.getPetno(),apm.getMemno(),apm.getRdate());
		System.out.println("ConsultationController addConsultation weight->"+weight);
		
		System.out.println("ConsultationController detailConsulatation chartImgs->"+chartImgs);
		
		model.addAttribute("apm",apm);
		model.addAttribute("chart",chart);
		model.addAttribute("chartImgs",chartImgs);
		model.addAttribute("weight",weight);
		 
		return "admin/detailConsultation";
	}
	
	/* 차트수정 */
	@RequestMapping(value = "/admin/updChart")
	public String updateConsultation(Chart ch,
									Weight weight,
									@RequestParam("file") List<MultipartFile> files,
									HttpServletRequest request, Model model) throws ParseException {
		
		System.out.println("ConsultationController updateConsultation weight..."+weight);
		
		// 이미지저장
		List<String> imgPaths = saveImages("chart",files,request);
		// 업데이트, 수정한 이미지 삭제
		cs.updateConsultation(ch, imgPaths);
		//몸무게 수정
		if(weight.getPetweight() != null || weight.getPetweight() != "") {
			System.out.println("==================== "+weight.getPetweight());
			// SimpleDateFormat을 사용하여 날짜 형식 지정
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			// String을 Date로 변환
			String dateString = weight.getRreg_date();
			Date date = formatter.parse(dateString);
			System.out.println("==================== format date"+date);

			// 등록되어있다면 수정
			if(date != ch.getRdate() ){ 
				System.out.println("==================== if"+weight.getPetweight());
				
				
				//System.out.println("==================== date"+weight.getRreg_date());
				
	            
				weight.setReg_date(date);
				System.out.println("==================== weight"+weight);
				int updateWeight = cs.UpdatePetWeight(weight);
			}
			
			// 등록된 값이 없다면 추가
			else {
				System.out.println("==================== else"+weight.getPetweight());
				int insertResult = cs.insertPetWeight(weight);
			}
		}
		
		
		return "redirect:/admin/consultation";
	}

}
