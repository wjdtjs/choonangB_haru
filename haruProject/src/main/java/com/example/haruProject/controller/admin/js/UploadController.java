package com.example.haruProject.controller.admin.js;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UploadController {


	/**
	 * 이미지 업로드
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping(value="/api/uploadFile")
	public ResultVO uploadForm(@RequestParam("type") String type, 
            					@RequestPart("file") MultipartFile file, 
            					HttpServletRequest request, 
            					Model model) throws Exception {
		
		ResultVO vo = new ResultVO();
		
		try {
			Part image = request.getPart("file");
			InputStream inputStream = image.getInputStream();
			
			// 파일 확장자 구하기
			String fileName = image.getSubmittedFileName();
			String[] split = fileName.split("\\.");
			String originalName = split[split.length -2];
			String suffix = split[split.length -1];
			
			log.info("fileName -> {}", fileName);
			log.info("originalName -> {}", originalName);
			log.info("suffix -> {}",suffix);
			
			// Servlet 상속 받지 못했을 때 realPath 불러오는 방법
			String type_path = "/upload/"+type+"/";
			String uploadPath = request.getSession().getServletContext().getRealPath(type_path);
			System.out.println("real path : "+uploadPath);
			
			log.info("uploadForm() POST Start..");
			String savedName = uploadFile(type, inputStream, uploadPath, suffix);
			
			log.info("Return savedName: {}", savedName);
			model.addAttribute("savedName", savedName);
			
			vo.setCode(200);
			vo.setResult(true);
			vo.setMessage("이미지 업로드 성공");
			vo.setData(savedName);
			
		} catch (Exception e) {
			
			vo.setCode(300);
			vo.setResult(false);
			vo.setMessage(e.getMessage());
			
			log.error("image upload error : ", e.getMessage());
		}
		
		return vo;
	}

	
	/**
	 * 이미지 저장 메소드
	 * @param originalName
	 * @param inputStream
	 * @param uploadPath
	 * @param suffix
	 * @return
	 * @throws IOException 
	 * @throws FileNotFoundException 
	 */
	private String uploadFile(String type, 
							  InputStream inputStream, 
							  String uploadPath, 
							  String suffix) throws FileNotFoundException, IOException {
		
		//이미지 이름 지정
		String uid = UUID.randomUUID().toString();
		byte[] uuidStringBytes = uid.getBytes(StandardCharsets.UTF_8);
        byte[] hashBytes;

        try{
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
            hashBytes = messageDigest.digest(uuidStringBytes);
        }catch (NoSuchAlgorithmException e){
            throw new RuntimeException(e);
        }

        StringBuilder sb = new StringBuilder();
        for (int j=0;j<4;j++){
            sb.append(String.format("%02x", hashBytes[j]));
        }
        System.out.println(sb.toString());
		
		String savedName = sb + "_" + type + "." + suffix;
		log.info("uploadFile() savedName -> {}", savedName);
		////
		
		
		log.info("uploadPath -> {}", uploadPath);
		File fileDirectory = new File(uploadPath);
		
		// Directory 생성
		if(!fileDirectory.exists()) {
			// 신규 폴더(Directory) 생성
			fileDirectory.mkdirs();
			System.out.println("업로드용 폴더 생성 : "+uploadPath);
		}
		
		
		// 임시 파일 생성
		File tempFile = new File(uploadPath + savedName);
		
		// 생성된 임시 파일에 요청으로 넘어온 file의 inputStream 복사
		try (FileOutputStream outputStream = new FileOutputStream(tempFile)) 
		{
			int read;
			byte[] bytes = new byte[2048000];
			while((read = inputStream.read(bytes))!=-1) {
				// Target File에 요청으로 넘어온 file의 inputStream 복사
				outputStream.write(bytes, 0, read);
				// backup 파일에 요청으로 넘어온 file의 inputStream 복사
				
			}
		} finally {
			System.out.println("Upload The End");
		}
		
		return savedName;
	}
	
	
	/**
	 * api 결과 class
	 */
	@Data
	@RequiredArgsConstructor
	@AllArgsConstructor
	class ResultVO {
		private int code;
		private Boolean result;
		private String message;
		private String data;
	}
}





