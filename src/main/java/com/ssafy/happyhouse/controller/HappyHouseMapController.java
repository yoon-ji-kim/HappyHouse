package com.ssafy.happyhouse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.service.HappyHouseMapService;

@RestController
@RequestMapping("/map")
public class HappyHouseMapController {
	
	@Autowired
	private HappyHouseMapService happyHouseMapService;
	
	@GetMapping(value = "/sido")
		//ResponseEntity:상태값 가져감
	public ResponseEntity<List<SidoGugunCodeDto>> sido() throws Exception{ 		//시도 얻어오기
		return new ResponseEntity<List<SidoGugunCodeDto>> (happyHouseMapService.getSido(), HttpStatus.OK);
	}
	
	@GetMapping(value = "/gugun")
	public ResponseEntity<List<SidoGugunCodeDto>> gugun(@RequestParam("sido") String sido) throws Exception{ 	// 구군
	return new ResponseEntity<List<SidoGugunCodeDto>> (happyHouseMapService.getGugunInSido(sido), HttpStatus.OK);
	}
	
	@GetMapping(value = "/dong")
	public ResponseEntity<List<HouseInfoDto>> dong(@RequestParam("gugun") String gugun) throws Exception{ 		//동
	return new ResponseEntity<List<HouseInfoDto>> (happyHouseMapService.getDongInGugun(gugun), HttpStatus.OK);
	}
	
	@GetMapping(value = "/apt")
	public ResponseEntity<List<HouseInfoDto>> apt(@RequestParam("dong") String dong) throws Exception{ 		//아파트 정보
	return new ResponseEntity<List<HouseInfoDto>> (happyHouseMapService.getAptInDong(dong), HttpStatus.OK);
	}
	
	@GetMapping(value ="/getAll")
	public ResponseEntity<List<HouseInfoDto>> all(@RequestParam("word") String word) throws Exception{
		word = "%"+word+"%";
		return new ResponseEntity<List<HouseInfoDto>>(happyHouseMapService.getAll(word), HttpStatus.OK);
	}
}
