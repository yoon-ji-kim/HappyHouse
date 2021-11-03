package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.mapper.HouseMapMapper;

@Service
public class HappyHouseMapServiceImpl implements HappyHouseMapService {
	
	@Autowired
	private SqlSession sqlsession;

	@Override
	public List<SidoGugunCodeDto> getSido() throws Exception {
		return sqlsession.getMapper(HouseMapMapper.class).getSido();
	}

	@Override
	public List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception {
		return sqlsession.getMapper(HouseMapMapper.class).getGugunInSido(sido);
	}

	@Override
	public List<HouseInfoDto> getDongInGugun(String gugun) throws Exception {
		return sqlsession.getMapper(HouseMapMapper.class).getDongInGugun(gugun);
	}

	@Override
	public List<HouseInfoDto> getAptInDong(String dong) throws Exception {
		return sqlsession.getMapper(HouseMapMapper.class).getAptInDong(dong);
	}
	
	@Override
	public void registInterest(String id, String sidocode,String guguncode, String dongcode) throws Exception{
		sqlsession.getMapper(HouseMapMapper.class).registInterest(id, sidocode, guguncode, dongcode);
	}
	
	@Override
	public List<HouseInfoDto> getAll(String word) throws Exception{
		return sqlsession.getMapper(HouseMapMapper.class).getAll(word);
	}
}
