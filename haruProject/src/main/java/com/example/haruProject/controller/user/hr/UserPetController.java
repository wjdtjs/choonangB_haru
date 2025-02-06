package com.example.haruProject.controller.user.hr;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.haruProject.common.utils.SessionUtil;
import com.example.haruProject.controller.admin.js.UploadController;
import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.Weight;
import com.example.haruProject.service.hr.UserPetService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class UserPetController {	
	private final UserPetService ps;
	
	/*
	 * 사용자 동물 추가하기 뷰
	 * insert
	 * 사진, 이름, 생년월일, 종(대분류,중분류), 성별(+중성화 유무), 키, 몸무게, 특이사항
	 */	
	@GetMapping("/user/addPetView")
	public String addPetView(Model model, HttpServletRequest request) {
		log.info("addPet view start ,,,");
		
		List<Pet> pList = new ArrayList<>();
		pList = ps.getSpeciesBcd();
		
		int memno = SessionUtil.getNo(request);
		
		model.addAttribute("pList", pList);
		model.addAttribute("memno", memno);
		
		
		return "user/addPet";
	}
	
	
	/*
	 * 동물 추가
	 * 
	 */	
	@PostMapping("/user/addPet")
	public String addPet(Pet pet, HttpServletRequest request) {
	    log.info("addPet() start ,,,");
	    
	    System.out.println("pet : "+pet);
	    
	    String type = "pet";
	    String imgPath = saveImage(type, request);
	    
	    if (imgPath == null) {
			return "redirect:/user/myPage";
		} else {
			pet.setPetimg(imgPath);	// 사진 이름 petimg 객체에 저장			
		}
	    
	    String gender1 = pet.getGender1();
	    String gender2 = pet.getGender2();
	    System.out.println("gender1 : "+gender1 + ", gender2 : "+gender2);
	    
	    if (gender1.equals("female") && gender2.equals("O")) {
	        pet.setPetgender_mcd(110); // 중성화 O 여자
	    } else if (gender1.equals("female") && gender2.equals("X")) {
	        pet.setPetgender_mcd(120); // 중성화 X 여자
	    } else if (gender1.equals("male") && gender2.equals("O")) {
	        pet.setPetgender_mcd(210); // 중성화 O 남자
	    } else if (gender1.equals("male") && gender2.equals("X")) {
	        pet.setPetgender_mcd(220); // 중성화 X 남자
	    }
	    
	    System.out.println("pet -> "+pet);
	    
	    ps.addPet(pet);

	    return "redirect:/user/myPage";
	}

	
	
	// 이미지 저장
	private String saveImage(String type, HttpServletRequest request) {
		System.out.println("UserPetController saveImage start ,,,");
		UploadController uc = new UploadController();
		String imgPath = null;
		
		// 동물 사진 저장
		try {
			Part image = request.getPart("main_img");
			System.out.println(image);
			InputStream inputStream = image.getInputStream();
			
			// 파일 확장자 구하기
			String fileName = image.getSubmittedFileName();
			String[] split = fileName.split("\\.");
			String suffix = split[split.length -1];
			
			System.out.println("fileName -> {}"+fileName);
			System.out.println("suffix -> {}"+suffix);
			
			// Servlet 상속 받지 못했을 때 realPath 불러오기
			String type_path = "/upload/"+type+"/";
			String uploadPath = request.getSession().getServletContext().getRealPath(type_path);
			System.out.println("real path : "+uploadPath);
			
			log.info("uploadForm() POST Start..");
			String savedName = uc.uploadFile(type, inputStream, uploadPath, suffix);
			
			log.info("Return savedName: {}", savedName);			
			imgPath = type_path+savedName;
			System.out.println(imgPath);
			
		} catch (Exception e) {
			log.error("image upload error : ", e);
		}
		
		return imgPath;
	}


	/*
	 * 사용자 동물 상세 페이지 뷰
	 * 
	 */	
	@GetMapping("/user/detailPet")
	public String detailPetView(@RequestParam(value = "petno", required = true) int petno, Model model) throws ParseException {
		log.info("detailPet view start ,,,");
		System.out.println("UserPetController detailPetView() petno ->"+petno);
		
		// 동물 정보 불러오기
		Pet pet = new Pet();
		pet = ps.getPetDetail(petno);
		
		
		// 동물 체중 정보 불러오기
		List<Weight> wList = new ArrayList<>();
		wList = ps.getPetWeightList(petno);
		
		// 진료 날짜 형태 전처리	    
	    SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy.MM.dd");  // 변환할 형식
	    
	    for(Weight w : wList) {
		   Date reg_date = w.getReg_date();
		   String formattedDate = outputFormat.format(reg_date);
           
           w.setRreg_date(formattedDate); // 변환된 날짜를 다시 저장
           // System.out.println("변환된 rreg_date -> " + w.getRreg_date());
	    }
		
		
		// 동물 예약 정보 불러오기
		List<Appointment> aList = new ArrayList<>();
		aList = ps.getPAppointmentList(petno);
		
		// 시작시간 형태 전처리
	    aList.forEach(appointment -> {
	        String startTime = String.valueOf(appointment.getStart_time());
	        if (startTime.length() == 4) { // 1530 -> 15:30
	            appointment.setStart_time(startTime.substring(0, 2) + ":" + startTime.substring(2));
	        }
	    });
	    
	    // 진료 날짜 형태 전처리	    
	    for(Appointment a : aList) {
		   Date rdate = a.getRdate();
		   String formattedDate = outputFormat.format(rdate);
           
           a.setRrdate(formattedDate); // 변환된 날짜를 다시 저장
           System.out.println("변환된 rrdate -> " + a.getRrdate());
	    }
	    
	    System.out.println("aList ->"+aList);

		model.addAttribute("pet", pet);
		model.addAttribute("wList", wList);
		model.addAttribute("aList", aList);
		
		
		return "user/detailPet";
	}
	

	/*
	 * 종 중분류 값 가져오기
	 */	
	@ResponseBody
	@GetMapping("/api/add-mcd/{bcd}")
	public List<Pet> getSpeciesMcd(@PathVariable(value = "bcd", required = true) int bcd,
								   Model model)
	{
		System.out.println("getSpeciesMcd() start ,,,");
		System.out.println("getSpeciesMcd() bcd ->"+bcd);
		
		List<Pet> pList = ps.getSpeciesMcd(bcd);
		
		return pList;
	}
	

	/*
	 * 사용자 동물 정보 수정하기 뷰
	 * update
	 * 사진, 이름, 생년월일, 종(대분류,중분류), 성별(+중성화 유무), 키, 몸무게, 특이사항
	 */	
	@GetMapping("/user/editPet")
	public String editPetView(@RequestParam(value = "petno", required = true) int petno, Model model) {
		log.info("editPet view start ,,,");
		System.out.println("UserPetController editPetView() start ,,,");
		System.out.println("UserPetController editPetView() petno ->"+petno);
		
		List<Pet> pList = new ArrayList<>();
		pList = ps.getSpeciesBcd();
		
		Pet p = new Pet();
		p = ps.getPetDetail(petno);
		
//		SimpleDateFormat outputFormat = new SimpleDateFormat("20"+"yy-MM-dd");  // 변환할 형식
//		System.out.println("petbirth: "+p.getPetbirth());
//		String formattedDate = outputFormat.format(p.getPetbirth());
//		p.setFpetbirth(formattedDate);
		
		model.addAttribute("pList", pList);
		model.addAttribute("pet", p);
		
		return "user/editPet";
	}
	

	/*
	 * 사용자 동물 정보 수정하기
	 * update 상태변경
	 * 동물 번호
	 */	
	@RequestMapping("/user/updatePet")
	public String updatePet(Pet pet, HttpServletRequest request) throws IOException, ServletException {
		System.out.println("UserPetController updatePet() start ,,,");
		System.out.println("UserPetController updatePet() pet ->"+pet);

	    boolean img_change = false;
		String type = "pet";
		String imgPath = null;
		
		Part image = request.getPart("main_img");
		if(image.getSize() == 0) {
			System.out.println("이미지 변경 안함");
		} else  {
			System.out.println("이미지 변경함");
			
			imgPath = saveImage(type, request);
			if(imgPath==null) {
				return "redirect:stock";
			} else {
				pet.setPetimg(imgPath); //썸네일 이름 객체에 저장
				img_change = true;
			}
		}
	    
	    String gender1 = pet.getGender1();
	    String gender2 = pet.getGender2();
	    System.out.println("gender1 : "+gender1 + ", gender2 : "+gender2);
	    
	    if (gender1.equals("female") && gender2.equals("O")) {
	        pet.setPetgender_mcd(110); // 중성화 O 여자
	    } else if (gender1.equals("female") && gender2.equals("X")) {
	        pet.setPetgender_mcd(120); // 중성화 X 여자
	    } else if (gender1.equals("male") && gender2.equals("O")) {
	        pet.setPetgender_mcd(210); // 중성화 O 남자
	    } else if (gender1.equals("male") && gender2.equals("X")) {
	        pet.setPetgender_mcd(220); // 중성화 X 남자
	    }
	    
	    System.out.println("pet -> "+pet);
		
		ps.updatePet(pet, img_change);
		
		return "redirect:/user/myPage";
	}
	
	
	
	/*
	 * 동물 몸무게 뷰
	 */	
	@GetMapping("/user/petWeight")
	public String petWeightView(@RequestParam(value = "pageNum", required = true, defaultValue="1") String pageNum,
								@RequestParam(value = "blockSize", required = false, defaultValue="10") int blockSize,
								@RequestParam(value = "petno", required = true) int petno, Model model) {
		System.out.println("UserPetController petWeightView() start ,,,");
		System.out.println("UserPetController petWeightView() petno ->"+petno);
		
		// 몸무게 전제 수
		int totalCnt = ps.getWeightCnt(petno);
		// 페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, blockSize);
		System.out.println(pagination);
		
		List<Weight> wList = ps.getPetWeightList(petno, pagination.getStartRow(), pagination.getEndRow());
		Pet pet = ps.getPetDetail(petno);
		
		// 진료 날짜 형태 전처리	    
	    SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy.mm.dd");  // 변환할 형식
	    
	    for(Weight w : wList) {
		   Date reg_date = w.getReg_date();
		   String formattedDate = outputFormat.format(reg_date);
           
           w.setRreg_date(formattedDate); // 변환된 날짜를 다시 저장
           // System.out.println("변환된 rreg_date -> " + w.getRreg_date());
	    }
		
		model.addAttribute("wList", wList);
		model.addAttribute("pet", pet);
		model.addAttribute("pagination", pagination);
		
		return "user/weight";
	}
	
	/*
	 * 동물 몸무게 수정(추가)
	 */	
	@RequestMapping("/user/updateWeight")
	public String updateWeight(Weight weight, RedirectAttributes redirectAttributes) {
		System.out.println("UserPetController updateWeight() start ,,,");
		System.out.println("UserPetController petWeightView() weight ->"+weight);
		
		ps.updateWeight(weight);
		
		int petno = weight.getPetno();
		System.out.println("petno ->"+petno);
		
		redirectAttributes.addAttribute("petno", petno);
		
		return "redirect:/user/petWeight";
	}
	
	
	/*
	 * 사용자 동물 정보 삭제하기
	 * update 상태변경
	 * 동물 번호
	 */	
	@RequestMapping("/user/deletePet")
	public String deletePet(@RequestParam(value = "petno", required = true) int petno) {
		System.out.println("UserPetController deletePet() start ,,,");
		System.out.println("UserPetController deletePet() petno ->"+petno);
		
		int result = ps.deletePet(petno);
		
		return "redirect:/user/myPage";
	}
	
}
