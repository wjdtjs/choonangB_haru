package com.example.haruProject.dao.hj;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.catalina.util.ParameterMap;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Chart;
import com.example.haruProject.dto.ChartDetail;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ConsultationDaoImpl implements ConsultationDao {
	
	private final SqlSession session;

	@Override
	public Appointment getConsulatation(String resno) {
		System.out.println("ConsultationDaoImpl getConsulatation...");
		Appointment apm = null;
		
		try {
			apm = session.selectOne("HJSelectApointment", resno);
			System.out.println("ConsultationController addConsultation apm->"+apm);
		} catch (Exception e) {
			System.out.println("ConsultationDao getConsulatation error->"+e.getMessage());
		}
		return apm;
	}

	@Override
	public Chart getChart(String resno) {
		System.out.println("ConsultationDaoImpl getConsulatation...");
		
		Chart result = null;
		try {
			result = session.selectOne("HJSelectChart",resno);
			System.out.println("ConsultationDaoImpl getConsulatation result ->"+result);
		} catch (Exception e) {
			System.out.println("ConsultationDao getChart error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int addChart(Chart ch) {
		System.out.println("ConcultationDao addChart ...");
		
		int result = 0;
		try {
			result = session.insert("HJInsertChart",ch);

		} catch (Exception e) {
			System.out.println("ConsultationDao addChart error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int chartImgSave(List<String> imgPaths, Chart ch) {
		System.out.println("ConcultationDao addChart ...");
		System.out.println("ConcultationDao imgPaths ->"+imgPaths);
		System.out.println("ConcultationDao ch.getResno() ->"+ch.getResno());
		String cno = 'C'+ch.getResno();
		int result = 0;
		for(String imgPath : imgPaths) {
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("cno", cno);
			paramMap.put("imgPath", imgPath);
			try {
				result = session.insert("HJSaveChartImg", paramMap);
			} catch (Exception e) {
				System.out.println("ConsultationDao chartImgSave error->"+e.getMessage());
			}		
		}
		return result;
	}

	@Override
	public List<ChartDetail> getChartImage(String resno) {
		System.out.println("consultation getChartImage ...");
		List<ChartDetail> imgList = new ArrayList();
		try {
			imgList = session.selectList("HJSelectChartImgs",resno);
		} catch (Exception e) {
			System.out.println("ConsultationDao getChartImage error->"+e.getMessage());
		}
		return imgList;
	}

	@Override
	public Appointment userDetailConsultation(String cno) {
		System.out.println("consultation userDetailConsultation ...");
		Appointment apm = null;
		try {
			apm = session.selectOne("HJSelectUserApm",cno);
		} catch (Exception e) {
			System.out.println("ConsultationDao userDetailConsultation error->"+e.getMessage());
		}
		return apm;
	}

	@Override
	public Chart userChart(String cno) {
		System.out.println("Consultation userChart ...");
		Chart chart = new Chart();
		try {
			chart = session.selectOne("HJSelectUserChart",cno);
		} catch (Exception e) {
			System.out.println("Consultation userChart e.getMessage()"+e.getMessage());
		}
		return chart;
	}

	@Override
	public List<ChartDetail> userChartImages(String cno) {
		List<ChartDetail> chartImages = new ArrayList<>();
		try {
			chartImages = session.selectList("HJSelectUserChartImages",cno);
			System.out.println("Consultation userChartImgs-> "+chartImages);
		} catch (Exception e) {
			System.out.println("Consultation userChartImages e.getMessage()"+e.getMessage());
		}
		return chartImages;
	}

	@Override
	public void updateConsultation(Chart ch, List<String> imgPaths) {
		System.out.println("ConsultationDao updateConsultation ...");
		System.out.println("ConsultationDao updateConsultation ch-> "+ch);
		System.out.println("ConsultationDao updateConsultation imgPaths->"+imgPaths);
		int upResult = 0;
		int delResult = 0;
		int addResult = 0;
		try {
			// update
			upResult = session.update("HJ_UpdateConsulataion",ch);
			System.out.println("upResult-> "+upResult);
			
			//boardimg에서 삭제할 이미지 있는지 확인
			int [] arr = ch.getImgno();
			String cno = ch.getCno();
			if(arr.length > 0) {
				for (int i : arr) {
					Map<String, Object> delMap = new HashMap<>();
					delMap.put("cno", cno);
					delMap.put("imgno", i);
					delResult=session.delete("HJ_DeleteChartImg",delMap);
					System.out.println("delResult-> "+delResult);
				}
			}
			//추가할 이미지가 있을 경우
			if(imgPaths.size() > 0) {
				for(String imgPath : imgPaths) {
					Map<String, Object> paramMap = new HashMap<>();
					paramMap.put("cno", ch.getCno());
					paramMap.put("imgPath", imgPath);
					System.out.println("ConsultationDao chartImgSave paramMap-> "+paramMap);
					try {
						addResult = session.insert("HJSaveChartImg", paramMap);
						System.out.println("addResult-> "+addResult);
					} catch (Exception e) {
						System.out.println("ConsultationDao chartImgSave error->"+e.getMessage());
					}		
				}
			}

		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}



}
