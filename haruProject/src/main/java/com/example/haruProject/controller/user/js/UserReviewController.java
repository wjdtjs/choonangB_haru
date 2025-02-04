package com.example.haruProject.controller.user.js;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.haruProject.common.utils.SessionUtil;
import com.example.haruProject.controller.admin.js.UploadController;
import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.BoardImg;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.Product;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.service.js.ReviewService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@Slf4j
@Controller
@RequiredArgsConstructor
public class UserReviewController {
	
	private final ReviewService rs;
	
	/**
	 * 진료/수술 후기 리스트
	 * @param pageNum
	 * @param blockSize
	 * @param search1
	 * @param type5
	 * @param mcd
	 * @param request
	 * @param board
	 * @param model
	 * @return
	 */
	@GetMapping("/user/community")
	public String communityView(@RequestParam(value = "pageNum", required = true, defaultValue="1") String pageNum,
								@RequestParam(value = "blockSize", required = false, defaultValue="10") int blockSize,
								@RequestParam(value = "search1", required = false, defaultValue="") String search1,
								@RequestParam(value = "type5", required = false, defaultValue="0") int type5,
								@RequestParam(value = "mcd", required = true, defaultValue = "999") int mcd,
								HttpServletRequest request,
								Board board, Model model) {
		log.info("communityView() start..");
		
		//후기 중분류
		List<Map<String, Object>> mcdList = new ArrayList<>();
		mcdList = rs.getMcdList();
	
		//제목 검색, 내가쓴후기 
		System.out.println("내가쓴거?? "+type5);
		int memno = 0;
		if(type5 == 1) {
			memno = SessionUtil.getNo(request);
		}
		SearchItem si = new SearchItem(mcd, memno, search1);
		
		//공지사항 전체 수 (필터 적용)
		int totalCnt = rs.getReviewCnt(si);
		//페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, blockSize);
		System.out.println(pagination);
		
		List<Board> rList = new ArrayList<>();
		rList = rs.getReviewList(pagination.getStartRow(), pagination.getEndRow(), si);
		
		System.out.println(rList);
		

		model.addAttribute("mcd", mcd);
		model.addAttribute("ismy", type5);
		model.addAttribute("title", search1);
		model.addAttribute("mcdList", mcdList);
		model.addAttribute("rList", rList);
		model.addAttribute("pagination", pagination);
		
		
		return "user/community";
	}
	
	
	/**
	 * 진료/수술 후기 상세
	 * @param board
	 * @param model
	 * @return
	 */
	@GetMapping("/user/details-review")
	public String detailsCommunity(Board board, Model model, HttpServletRequest request) {
		log.info("detailsCommunity() start..");
		
		int bno = board.getBno(); //후기 번호
		
		rs.plusViewCount(bno);
		
		// 글 상세 불러오기
		Board detail = new Board();
		detail = rs.getBoardDetail(bno);
		
		// 글 이미지 불러오기
		List<BoardImg> imgList = new ArrayList<>();
		imgList = rs.getBoardImg(bno);
		
		// 내가쓴 글인지 확인
		boolean ismy = false;
		int myno = SessionUtil.getNo(request);
		int memno = detail.getMemno();
		if(myno == memno) {
			ismy = true;
		}
		
		//댓글 수
		int totalCnt = rs.getCommentTotalCnt(bno);
		
		model.addAttribute("ismy", ismy);
		model.addAttribute("board", detail);
		model.addAttribute("imgList", imgList);
		model.addAttribute("cnt", totalCnt);
		
		return "user/detailsReview";
	}
	
	/**
	 * 진료/수술 후기 댓글 조회
	 * @return
	 */
	@ResponseBody
	@GetMapping("/user/api/review-comment")
	public Map<String, Object> reviewComment(@RequestParam(value = "bno", required = true) String bno,
											@RequestParam(value = "pageNum", required = true, defaultValue="1") String pageNum,
											@RequestParam(value = "blockSize", required = false, defaultValue="10") int blockSize,
											HttpServletRequest request) 
	{
		log.info("reviewComment() start..");
		
		Map<String, Object> commentMap = new HashMap<>();
		
		//댓글 전체 수
		//삭제된 댓글도 '삭제된댓글입니다'로 보여지기 때문에 삭제된거 포함된 수
		int totalCnt = rs.getCommentTotalCnt(Integer.parseInt(bno));
		
		//댓글 페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, blockSize);
		
		//댓글
		List<Board> comment = new ArrayList<>();
		for(Board c : comment) {
			if(c.getBstatus_mcd()!=100) {
				c.setBcontents("삭제된 댓글입니다.");
			}
		}
		comment = rs.getCommentList(pagination, Integer.parseInt(bno));
		System.out.println("reviewComment list : "+comment);
		
		commentMap.put("pagination", pagination);
		commentMap.put("comment", comment);
		
		return commentMap;
	}
	
	
	/**
	 * 댓글 작성
	 * @param board
	 * @return
	 */
	@ResponseBody
	@PostMapping("/user/api/write-comment")
	public Map<String, Object> writeComment(@RequestBody Board board, HttpServletRequest request) {
		
		log.info("writeComment() start..");
		 Map<String, Object> result = new HashMap<>();
		 result.put("success", false);
		
		int memno = SessionUtil.getNo(request);
		board.setMemno(memno);
		System.out.println("작성한 댓글 : "+board);
		
		int success_cnt = rs.writeComment(board);
		if(success_cnt == 1) {
			String email = SessionUtil.getEmail(request);
			System.out.println("이메일 "+email);
			result.put("success", true);
			result.put("email", email);
		}
		
		return result;
	}
	
	
	/**
	 * 후기 삭제
	 * @param bno
	 * @return
	 */
	@PostMapping("/user/deleteReviews")
	public String deleteReviews(Board board) {
		log.info("deleteReviews() start..");
		
		int bno = board.getBno();
		rs.deleteReviews(bno);
		
		return "redirect:community";
	}
	
	/**
	 * 후기 작성 뷰
	 * @param resno
	 * @param model
	 * @return
	 */
	@GetMapping("/user/write-review")
	public String writeReviewView(@RequestParam(value="resno", required = true) String resno, Model model) {
		log.info("writeReviewView() start..");
		
		//진료 정보
		Appointment appointment = new Appointment();
		appointment = rs.getAppointment(resno);
		
		model.addAttribute("resno", resno);
		model.addAttribute("bcd", appointment.getItem_bcd());
		model.addAttribute("mcd", appointment.getItem());
		
		return "user/uploadReview";
	}
	
	/**
	 * 후기 작성
	 * @param board
	 * @param model
	 * @return
	 * @throws ServletException 
	 * @throws IOException 
	 */
	@PostMapping("/user/WriteReview")
	public String writeReview(Board board, Model model, HttpServletRequest request) throws IOException, ServletException {
		log.info("writeReview() start..");
		
		int memno = SessionUtil.getNo(request);
		board.setMemno(memno);
		
		//이미지 저장
		List<String> imgPathList = saveImage("review", request);
		System.out.println("저장할 이미지 리스트 -> "+imgPathList);
		
		//프로시저를 사용해 board, boardimg 한번에 저장
		System.out.println("writeReview() Board -> "+board);
		rs.writeReview(board, imgPathList);
		
		return "redirect:reservation";
	}
	
	/**
	 * 이미지 저장
	 * @param type
	 * @param request
	 * @return
	 */
	private List<String> saveImage(String type, HttpServletRequest request) {
		UploadController uc = new UploadController();
		List<String> imgPathList = new ArrayList<>();
		
		//// 저장
		try {
			String imgPath = null;
			Collection<Part> parts = request.getParts();
			System.out.println("parts== "+parts);
			for (Part image : parts) {
				
				if (image.getContentType() != null) { // ContentType이 있는 경우 파일임			        
			        System.out.println("UserReviewController saveImage() -> "+image.getSubmittedFileName());
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
			        imgPathList.add(imgPath);
			    } 
			}
			
		} catch (Exception e) {
			log.error("image upload error : ", e);
		}
		
		return imgPathList;
	}
	
}
