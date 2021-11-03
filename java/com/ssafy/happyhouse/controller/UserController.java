package com.ssafy.happyhouse.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.User;
import com.ssafy.happyhouse.model.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
	@PostMapping("/login")
	public String login(@RequestParam Map<String, String> map,  Model model, HttpSession session
			,HttpServletResponse response) throws Exception {
		logger.debug("map: {}",map.get("id"));
		User user = userService.login(map);
		if(user != null ) {
			session.setAttribute("userinfo", user);
			return "redirect:/";
		}else {
			model.addAttribute("msg", "아이디 또는 비밀번호를 확인해 주세요");
			return "user/login";
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@PostMapping("/register")
	public String register(User user, Model model) throws Exception{
		logger.debug("user : {}",user.getId());
		userService.registerUser(user);
		return "redirect:/";
	}
	
	@PutMapping("/passChange") //비밀번호 변경
	public  ResponseEntity<Map<String,Object>> passchange(@RequestParam("id")String id, @RequestParam("pass")String pass,
																	HttpSession session) {
		ResponseEntity<Map<String,Object>> resEntity=null;
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			userService.updatePwd(id,pass);
			session.invalidate();
			map.put("resMsg", "비밀번호변경업무 성공");
			resEntity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
			return resEntity;
		} catch (Exception e) {
			e.printStackTrace();
			map.put("resMsg", "비밀번호변경업무 실패");
			resEntity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
			return resEntity;
		}
	}
	
	@DeleteMapping("/{id}") //회원탈퇴
	public  ResponseEntity<Map<String,Object>> deleteUser(@PathVariable("id") String id, HttpSession session) {
		System.out.println("삭제업무처리");
		
		ResponseEntity<Map<String,Object>> resEntity=null;
		Map<String,Object> map = new HashMap();
		try {
			userService.deleteUser(id);
			map.put("resMsg", "회원삭제업무 성공");
			resEntity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
			
		} catch (Exception e) {
			map.put("resMsg", "회원삭제업무 실패");
			resEntity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}
		session.invalidate();
		return resEntity;
	}
	
	@GetMapping("/list") //추가
    public String list() {
        return "user/list";
    }
}
