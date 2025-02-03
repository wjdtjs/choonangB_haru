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
		
		int result = 0;
		for(String imgPath : imgPaths) {
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("resno", ch.getResno());
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



}
