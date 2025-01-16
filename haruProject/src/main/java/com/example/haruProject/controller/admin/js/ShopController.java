package com.example.haruProject.controller.admin.js;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.Product;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.service.js.ShopService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
//@RestController
@Controller
@RequiredArgsConstructor
public class ShopController {
	
	private final ShopService ss;
	
	/**
	 * 상품 목록 조회 api
	 * @param pageNum 현재 페이지
	 * @param blockSize 한페이지에서 볼 게시글 수
	 * @return
	 */
	@ResponseBody
	@GetMapping("/api/product-list")
	public Map<String, Object> productList(@RequestParam(value = "pageNum", required = true) String pageNum,
            						 @RequestParam(value = "blockSize", required = false, defaultValue="10") String blockSize,
            						 @RequestParam(value = "search1", required = false) String search1,
            						 @RequestParam(value = "search2", required = false) String search2
            						 ) 
	{
		log.info("productList() start..");
		List<Product> pList = new ArrayList<>();
		Map<String, Object> pListMap = new HashMap<>();
				
		//검색 필터
		SearchItem si = new SearchItem(search1, search2);
		
		//상품 전체 수 (필터 적용)
		int totalCnt = ss.getTotalCnt(si);
		
		//페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, Integer.parseInt(blockSize)); 
		
		//페이지네이션 적용된 상품 목록		
		pList = ss.productList(pagination.getStartRow(), pagination.getEndRow(), si);
//		System.out.println(pList);
		
		pListMap.put("pagination", pagination);
		pListMap.put("list", pList);
		
//		System.out.println(pList);

		return pListMap;
		
	}
	
	/**
	 * 상품 분류 공통데이터-대분류 리스트 조회 api
	 * @return
	 */
	@ResponseBody
	@GetMapping("/api/product-bcd")
	public List<Map<String, Object>> productBCD() {
		log.info("productBCD() start..");
		
		List<Map<String, Object>> cdList = new ArrayList<>();
		cdList = ss.getBCDList();
		
//		System.out.println(cdList);
		
		return cdList;
	}
	
	/**
	 * 상품 분류 공통데이터-중분류 리스트 조회 api
	 * @param bcd 대분류 값
	 * @return
	 */
	@ResponseBody
	@GetMapping("/api/product-mcd/{bcd}")
	public List<Map<String, Object>> productMCD(@PathVariable("bcd") int bcd) {
		log.info("productMCD start..");
		
		List<Map<String, Object>> cdList = new ArrayList<>();
		cdList = ss.getMCDList(bcd);
		
//		System.out.println(cdList);
		
		return cdList;
	}
	
	/**
	 * 상품 등록
	 * @param request
	 * @param model
	 * @return
	 */
	@PostMapping("/admin/uploadProduct")
	public String uploadProduct(Product pd, HttpServletRequest request, Model model) {
		log.info("uploadProduct() start..");
//		System.out.println(pd);
		
		String type = "thumb";
		String imgPath = saveImage(type, request);
		
		if(imgPath==null) {
			return "redirect:stock";
		} else {
			pd.setPimg_main(imgPath); //썸네일 이름 객체에 저장			
		}
		
//		System.out.println("=========================");
//		System.out.println(pd);
		////상품데이터 db 저장
		ss.uploadProduct(pd);
		
		return "redirect:stock";
	}
	
	
	/**
	 * 상품 정보 조회
	 * @return
	 */
	@ResponseBody
	@GetMapping("/api/getProductDetail/{pno}")
	public Product getProductDetail(@PathVariable("pno") String pno) {
		log.info("getProductDetail() start..");
//		System.out.println(pno);
		Product pd = new Product();
		
		pd = ss.getProductDetail(pno);
//		System.out.println(pd);
		
		return pd;
	}
	
	
	/**
	 * 상품 수정
	 * @param request
	 * @param model
	 * @return
	 */
	@PostMapping("/admin/updateProduct")
	public String updateProduct(Product pd, HttpServletRequest request, Model model) {
		log.info("uploadProduct() start..");
		System.out.println(pd);
		
		String type = "thumb";
		
		//TODO: 같은 이름의 이미지가 있는지 확인
		System.out.println(pd.getPimg_main());
		
		System.out.println("=========================");
		System.out.println(pd);
		////상품데이터 db 저장
//		ss.updateProduct(pd);
		
		return "redirect:stock";
	}
	
	
	
	/**
	 * 이미지 저장
	 * @param type
	 * @param request
	 * @return
	 */
	private String saveImage(String type, HttpServletRequest request) {
		UploadController uc = new UploadController();
		String imgPath = null;
		
		////썸네일 저장
		try {
			Part image = request.getPart("main_img");
			System.out.println(image);
			InputStream inputStream = image.getInputStream();
			
			// 파일 확장자 구하기
			String fileName = image.getSubmittedFileName();
			String[] split = fileName.split("\\.");
			String suffix = split[split.length -1];
			
			log.info("fileName -> {}", fileName);
			log.info("suffix -> {}",suffix);
			
			// Servlet 상속 받지 못했을 때 realPath 불러오는 방법
			String type_path = "/upload/"+type+"/";
			String uploadPath = request.getSession().getServletContext().getRealPath(type_path);
			System.out.println("real path : "+uploadPath);
			
			log.info("uploadForm() POST Start..");
			String savedName = uc.uploadFile(type, inputStream, uploadPath, suffix);
			
			log.info("Return savedName: {}", savedName);			
			imgPath = type_path+savedName;
			System.out.println(imgPath);
			
		} catch (Exception e) {
			log.error("image upload error : ", e.getMessage());
		}
		
		return imgPath;
	}
	
	
	/**
	 * 상품 등록 페이지 뷰
	 * @param model
	 * @return
	 */
	@GetMapping("/admin/upload-product")
	public String uploadProductView(Model model) {
		log.info("uploadProductView() start..");
		List<Map<String, Object>> cdList = new ArrayList<>();
		cdList = ss.getBCDList();
		
		model.addAttribute("bcdList", cdList); //상품 대분류
		
		return "admin/uploadProduct";
	}
	
	/**
	 * 상품 상세 페이지 뷰
	 * @param pd
	 * @param model
	 * @return
	 */
	@GetMapping("/admin/details-product")
	public String detailsProductView(Product pd, Model model, @RequestParam("pno") String pno) {
		log.info("detailsProductView() start..");
		List<Map<String, Object>> cdList = new ArrayList<>();
		List<Map<String, Object>> statusList = new ArrayList<>();

		cdList = ss.getBCDList(); //상품 대분류
		statusList = ss.getStatusList(); //상태
		pd = ss.getProductDetail(pno); //정보
		
		model.addAttribute("statusList", statusList);
		model.addAttribute("bcdList", cdList); 
		model.addAttribute("product", pd);
		
		return "admin/detailsProduct";
	}
	
}
