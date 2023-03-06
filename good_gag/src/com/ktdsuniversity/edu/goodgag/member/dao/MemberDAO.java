package com.ktdsuniversity.edu.goodgag.member.dao;

import java.util.List;

import com.ktdsuniversity.edu.goodgag.member.vo.MemberVO;

public interface MemberDAO {
	
	public List<MemberVO> getAllMembers();
	
	public MemberVO getOneMember(String email, String password);
	
	public int createMember(MemberVO memberVO);
}