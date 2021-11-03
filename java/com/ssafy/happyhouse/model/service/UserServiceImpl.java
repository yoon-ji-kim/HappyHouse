package com.ssafy.happyhouse.model.service;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.User;
import com.ssafy.happyhouse.model.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private SqlSession sqlsession;
	
	@Override
	public int idCheck(String id) throws Exception {
		return sqlsession.getMapper(UserMapper.class).idCheck(id);
	}

	@Override
	public void registerUser(User user) throws Exception {
		sqlsession.getMapper(UserMapper.class).registerUser(user);
	}

	@Override
	public User login(Map<String, String> map) throws Exception {
		return sqlsession.getMapper(UserMapper.class).login(map);
	}

	@Override
	public User getUser(String id) throws Exception {
		return sqlsession.getMapper(UserMapper.class).getUser(id);
	}

	@Override
	public void updatePwd(String id,String pass) throws Exception {
		sqlsession.getMapper(UserMapper.class).updatePwd(id, pass);
	}

	@Override
	public void deleteUser(String id) throws Exception {
		sqlsession.getMapper(UserMapper.class).deleteUser(id);
	}
}
