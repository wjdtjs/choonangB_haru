package com.example.haruProject.controller.admin.hr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.service.hr.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class BoardController {
	private final BoardService bs;

	// 게시판 글 조회


	/**
	 * 관리자페이지 게시판관리 뷰
	 * 
	 * @return
	 */

	// 게시판 글 조회
	@GetMapping("/admin/board")
	public String boardView(@RequestParam(value = "pageNum", required = false, defaultValue = "1") String pageNum,
							@RequestParam(value = "blockSize", required = false, defaultValue = "10") String blockSize,
							@RequestParam(value = "type1", required = false, defaultValue = "0") String type1,
   						 	@RequestParam(value = "search1", required = false, defaultValue = "") String search1,
							Model model) 
	{
		System.out.println("admin/board start...");
		System.out.println("pagenNum ->"+pageNum);
		System.out.println("blockSize ->"+blockSize);
		System.out.println("type1 ->"+type1);
		System.out.println("search1 ->"+search1);
		
		List<Board> bList = new ArrayList<>();
		
		SearchItem si = new SearchItem(type1, search1);

		// 전체 게시글 수
		int totalCnt = bs.getTotalCnt(si);

		// 페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, Integer.parseInt(blockSize));

		bList = bs.boardList(pagination.getStartRow(), pagination.getEndRow());
		System.out.println(bList);

		model.addAttribute("pagination", pagination);
		model.addAttribute("bList", bList);
		model.addAttribute("type1", type1);
		model.addAttribute("search1", search1);

		System.out.println(bList);

		return "admin/board";
	}

	/**
	 * 관리자페이지 게시판관리 뷰 > 후기 상세페이지 뷰
	 * 
	 * @return
	 */
	@GetMapping("/admin/board_detail")
	//public String boardDetailView(@RequestParam(value = "bno", required = true) int bno, Model model) {
	public String boardDetailView(Board board1, Model model) {
		System.out.println("BoardController boardDetailList() start ,,,");
		System.out.println("BoardController boardDetailList() bno ->" + board1.getBno());

		// 상세페이지 전체 데이터 조회 - 게시글 + 댓글
		List<Board> bdList = new ArrayList<>();
		bdList = bs.boardDetailList(board1.getBno());

		// bseq에 따른 데이터 분리
//		List<Board> bdList_content = bdList.stream().filter(board -> board.getBseq() == 0).collect(Collectors.toList());
//		System.out.println("BoardController boardDetailList() bdList_content ->" + bdList_content); 
		
		// 게시글 불러오기
		Board board_c = bs.boardDetailContent(board1.getBno());
		System.out.println("BoardController boardDetailList() boardDetailContent board ->"+board_c);

		// 댓글 불러오기
		List<Board> bdList_re = bdList.stream().filter(board -> board.getBseq() != 0).collect(Collectors.toList());
		System.out.println("BoardController boardDetailList() bdList_re ->" + bdList_re);

		if (bdList_re == null) {
			model.addAttribute("board", board_c);
		} else if (bdList_re != null) {
			model.addAttribute("board", board_c);
			model.addAttribute("bdList_re", bdList_re);
		}
		
		for(Board b: bdList_re) {
			System.out.println("deleteBoardRe board ->"+b);
			if (b.getBstatus_mcd() == 200) {
				b.setMname("-");
				b.setReg_date(null);
				b.setBcontents("존재하지 않는 글입니다.");
				System.out.println("최종 bdList_re:"+bdList_re);
			} 
		}
		

		return "admin/board_detail";
	}
	
	// 게시글 지우기
	@RequestMapping("/boardDelete")
	public String deleteBoard(Board board1, Model model) {
		System.out.println("BoardController DeleteBoard() start ,,,");
		System.out.println("BoardController DeleteBoard() bno ->"+board1.getBno());
		
		model.addAttribute("bno", board1.getBno());
		
		int result = bs.deleteBoard(board1.getBno());
		
		if (result > 0) {
	        System.out.println("게시글 삭제 성공!");
	    } else {
	        System.out.println("게시글 삭제 실패");
	    }
		
		return "redirect:/admin/board";		
	}
	
	// 댓글 지우기
	@RequestMapping("/boardDelete_re")
	public String deleteBoardRe(@RequestParam("bno") int bno,
								@RequestParam("bgroup") int bgroup,
								Model model) {
		System.out.println("BoardController deleteBoardRe() start ,,,");
		System.out.println("BoardController deleteBoardRe() bno ->"+bno);
		System.out.println("BoardController deleteBoardRe() bgroup ->"+bgroup);
		
		// 댓글 비노출로 상태 변경
		int result = bs.deleteBoardRe(bno);
		
		if (result > 0) {
            System.out.println("댓글 삭제 성공!");
        } else {
            System.out.println("댓글 삭제 실패!");
            return "error_page"; // 실패 시 에러 페이지로 이동
        }

		return "redirect:/admin/board_detail?bno="+bgroup;
	}
	
	
	
	
	

}
