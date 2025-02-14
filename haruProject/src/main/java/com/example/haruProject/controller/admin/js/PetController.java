package com.example.haruProject.controller.admin.js;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.haruProject.dto.Notice;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.Schedule;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.dto.Weight;
import com.example.haruProject.service.hr.AppointmentService;
import com.example.haruProject.service.hr.UserPetService;
import com.example.haruProject.service.js.PetService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class PetController {
	
	private final PetService ps;
	private final AppointmentService as;
	private final UserPetService us;
	
	/**
	 * 동물 전체 리스트
	 * @param pageNum
	 * @param blockSize
	 * @param si
	 * @param model
	 * @return
	 */
	@GetMapping("/admin/pets")
	public String petManageView(@RequestParam(value = "pageNum", required = true, defaultValue="1") String pageNum,
							 @RequestParam(value = "blockSize", required = false, defaultValue="10") int blockSize, 
							 SearchItem si, Model model) 
	{
		log.info("petManageView() start..");
		System.out.println("pageNum : "+pageNum);
		System.out.println("blockSize : "+blockSize);
		System.out.println("search itme : "+si);
		
		//동물 전체 수 (필터 적용)
		int totalCnt = ps.getTotalCnt(si);
		//페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, blockSize);
		System.out.println(pagination);
		
		List<Pet> petList = new ArrayList<>();
		petList = ps.getPetList(pagination, si);
		
		System.out.println("petManageView() petList ==> "+petList);
		
		model.addAttribute("petList", petList);
		model.addAttribute("search1", si.getSearch1());
		model.addAttribute("search2", si.getSearch2());
		model.addAttribute("pagination", pagination);
		
		return "admin/pet";
	}
	
	
	/**
	 * 동물 상세
	 * @param petno
	 * @param model
	 * @return
	 */
	@GetMapping("/admin/details-pet")
	public String petDetailView(Pet pet, Model model ) {
		log.info("petDetailView() start..");
		
		Pet pet_detail = new Pet();
		pet_detail = ps.getPetDetail(pet);
		System.out.println("petDetailView() 동물 상세 ==> "+pet_detail);
		
		List<Map<String, Object>> docList = new ArrayList<>(); 	//의사 정보
		docList = as.getDocList();
		
		List<Pet> bcdList = new ArrayList<>();
		bcdList = us.getSpeciesBcd();
		System.out.println("==== "+ bcdList);
		
		List<Weight> wList = new ArrayList<>();
		wList = us.getPetWeightList(pet.getPetno(), 1, 10);
		System.out.println("petDetailView() 동물 몸무게 ==> "+wList);
		
		List<String> labels = new ArrayList<>();
		List<String> weight = new ArrayList<>();
		
		for(int i = wList.size()-1; i>=0; i--) {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
			String strNowDate = simpleDateFormat.format(wList.get(i).getReg_date()); 

			labels.add(strNowDate);
			weight.add(wList.get(i).getPetweight());
		}
		
		System.out.println("labels========> "+labels);
		System.out.println("weight========> "+weight);
		
		model.addAttribute("bcd", bcdList);
		model.addAttribute("pet", pet_detail);
		model.addAttribute("vet", docList);
		model.addAttribute("labels", labels);
		model.addAttribute("weight", weight);
		
		return "admin/detailsPet";
	}
	
	/**
	 * 몸무게 추가 api
	 * @param weight
	 * @return
	 */
	@ResponseBody
	@PostMapping("/api/add-weight")
	public boolean addWeight(@RequestBody Weight weight) {
		log.info("addWeight() api start..");
		boolean result = false;
		
		System.out.println("addWeight() weight ==> "+weight);
		
		int insert_result = ps.addWeight(weight);
		if(insert_result == 1) {
			result = true;
		}
		
		return result;
	}
	
	/**
	 * 동물 정보 수정
	 * @param gender
	 * @param gender2
	 * @param pet
	 * @param model
	 * @return
	 */
	@PostMapping("/admin/updatePet")
	public String updatePetInfo(Pet pet, Model model) 
	{
		log.info("updatePetInfo() start..");
		System.out.println("updatePetInfo() pet ==> "+ pet);
		
		String gender1 = pet.getGender1();
	    String gender2 = pet.getGender2();
	    System.out.println("gender1 : "+gender1 + ", gender2 : "+gender2);
	    
	    if (gender1.equals("2") && gender2.equals("1")) {
	        pet.setPetgender_mcd(110); // 중성화 O 여자
	    } else if (gender1.equals("2") && gender2.equals("2")) {
	        pet.setPetgender_mcd(120); // 중성화 X 여자
	    } else if (gender1.equals("1") && gender2.equals("1")) {
	        pet.setPetgender_mcd(210); // 중성화 O 남자
	    } else if (gender1.equals("1") && gender2.equals("2")) {
	        pet.setPetgender_mcd(220); // 중성화 X 남자
	    }
	    
	    ps.updatePetInfo(pet);
		
		int petno = pet.getPetno();
		return "redirect:/admin/details-pet?petno="+petno;
	}
	
	
	/**
	 * 동물 추가 뷰
	 * @param model
	 * @return
	 */
	@GetMapping("/admin/upload-pet")
	public String uploadPetView(Model model, 
					@RequestParam(value="no", required = false, defaultValue = "0") int memno,
					@RequestParam(value="name", required = false, defaultValue = "") String name) {
		log.info("addPet() start..");
		
		List<Map<String, Object>> docList = new ArrayList<>(); 	//의사 정보
		docList = as.getDocList();
		
		List<Pet> bcdList = new ArrayList<>();
		bcdList = us.getSpeciesBcd();
		
		model.addAttribute("vet", docList);
		model.addAttribute("bcd", bcdList);
		if(memno!=0) {
			model.addAttribute("memno", memno);
			model.addAttribute("mname", name);
		}
		
		return "admin/uploadPet";
	}
	
	
	/**
	 * 동물 추가
	 * @param pet
	 * @return
	 */
	@PostMapping("/admin/uploadPet")
	public String uploadPetAction(Pet pet) {
		log.info("uploadPetAction() start..");
		System.out.println("uploadPetAction() pet ==> " + pet);
		
		String gender1 = pet.getGender1();
	    String gender2 = pet.getGender2();
	    
	    if (gender1.equals("2") && gender2.equals("1")) {
	        pet.setPetgender_mcd(110); // 중성화 O 여자
	    } else if (gender1.equals("2") && gender2.equals("2")) {
	        pet.setPetgender_mcd(120); // 중성화 X 여자
	    } else if (gender1.equals("1") && gender2.equals("1")) {
	        pet.setPetgender_mcd(210); // 중성화 O 남자
	    } else if (gender1.equals("1") && gender2.equals("2")) {
	        pet.setPetgender_mcd(220); // 중성화 X 남자
	    }
		
		ps.uploadPet(pet);
		
		return "redirect:/admin/pets";
	}
	
}
