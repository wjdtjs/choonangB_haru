package com.example.haruProject.controller.admin.hr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.Pagination;
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
							Model model) 
	{
		System.out.println("admin/board start...");
		List<Board> bList = new ArrayList<>();

		// 전체 게시글 수
		int totalCnt = bs.getTotalCnt();

		// 페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, Integer.parseInt(blockSize));

		bList = bs.boardList(pagination.getStartRow(), pagination.getEndRow());
		System.out.println(bList);

		model.addAttribute("pagination", pagination);
		model.addAttribute("bList", bList);

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
		List<Board> bdList_content = bdList.stream().filter(board -> board.getBseq() == 0).collect(Collectors.toList());
		System.out.println("BoardController boardDetailList() bdList_content ->" + bdList_content);

		List<Board> bdList_re = bdList.stream().filter(board -> board.getBseq() != 0).collect(Collectors.toList());
		System.out.println("BoardController boardDetailList() bdList_re ->" + bdList_re);

		if (bdList_re == null) {
			model.addAttribute("bdList_content", bdList_content);
		} else if (bdList_re != null) {
			model.addAttribute("bdList_content", bdList_content);
			model.addAttribute("bdList_re", bdList_re);
		}

		return "admin/board_detail";
	}

}
