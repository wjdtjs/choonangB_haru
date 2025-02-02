package com.example.haruProject.controller.user.hr;

import java.io.File;
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

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.Weight;
import com.example.haruProject.service.hr.UserPetService;

import jakarta.servlet.http.HttpServletRequest;
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
	public String addPetView(Model model) {
		log.info("addPet view start ,,,");
		
		List<Pet> pList = new ArrayList<>();
		pList = ps.getSpeciesBcd();
		
		model.addAttribute("pList", pList);
		
		return "user/addPet";
	}
	
	
	@PostMapping("/admin/addPet")
	public String addPet(@RequestParam("petimg") MultipartFile file,
	                     @RequestParam("petname") String petName,
	                     Model model,
	                     HttpServletRequest request) {
	    System.out.println("파일 업로드 시작: " + file.getOriginalFilename());

	    String imgPath = saveImage(file, request); // 이미지 저장

	    // 동물 정보 객체 생성 (DB에 저장할 때 사용)
	    Pet pet = new Pet();
	    //pet.setPetName(petName);
	    //pet.setImgPath(imgPath);

	    // DB에 저장하는 로직 추가 (예: petService.addPet(pet);)

	    model.addAttribute("pet", pet); // JSP에서 이미지를 다시 표시하기 위해 모델에 추가
	    return "admin/addPetView"; // 다시 등록 페이지로 이동
	}

	private String saveImage(MultipartFile file, HttpServletRequest request) {
	    if (file.isEmpty()) {
	        return null; // 파일이 없으면 저장하지 않음
	    }

	    try {
	        // 파일명 추출
	        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
	        String uploadDir = "/upload/pet/"; // 저장 폴더
	        String uploadPath = request.getServletContext().getRealPath(uploadDir);

	        // 디렉토리 없으면 생성
	        File uploadFolder = new File(uploadPath);
	        if (!uploadFolder.exists()) {
	            uploadFolder.mkdirs();
	        }

	        // 저장할 파일 경로 설정
	        File savedFile = new File(uploadPath, fileName);
	        file.transferTo(savedFile);

	        // DB에 저장할 경로 반환
	        return uploadDir + fileName;

	    } catch (Exception e) {
	        System.out.println("파일 업로드 실패: " + e.getMessage());
	        return null;
	    }
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
           System.out.println("변환된 rreg_date -> " + w.getRreg_date());
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

		model.addAttribute("pet", pet);
		model.addAttribute("wList", wList);
		model.addAttribute("aList", aList);
		
		
		return "user/detailPet";
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
		
		model.addAttribute("pList", pList);
		model.addAttribute("pet", p);
		
		return "user/editPet";
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
