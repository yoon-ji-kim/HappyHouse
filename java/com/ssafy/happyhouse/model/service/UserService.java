package com.ssafy.happyhouse.model.service;

import java.util.Map;

import com.ssafy.happyhouse.model.User;

public interface UserService {
	int idCheck(String id) throws Exception; //아이디 체크
	void registerUser(User user) throws Exception; //회원 가입
	User login(Map<String, String> map) throws Exception; //로그인
	User getUser(String id) throws Exception; //회원정보 
	void updatePwd(String id,String pass)  throws Exception; //회원정보 수정
	void deleteUser(String id) throws Exception; //회원탈퇴
}
