package com.ssafy.happyhouse.model.mapper;

import java.sql.SQLException;
import java.util.Map;

import com.ssafy.happyhouse.model.User;

public interface UserMapper {
	int idCheck(String id) throws SQLException; //아이디 체크
	void registerUser(User user) throws SQLException; //회원 가입
	User login(Map<String, String> map) throws SQLException; //로그인
	User getUser(String id) throws SQLException; //회원정보 
	void updatePwd(String id,String pass) throws SQLException; //회원정보 수정
	void deleteUser(String id)throws SQLException; //회원탈퇴
}
