package com.ktdsuniversity.edu.goodgag.member.dao;

import java.util.List;

import com.ktdsuniversity.edu.goodgag.member.vo.MemberVO;
import com.ktdsuniversity.edu.goodgag.utils.db.AbstractDaoPoolSupport;

public class MemberDAOImpl extends AbstractDaoPoolSupport<MemberVO> implements MemberDAO{

	@Override
	public List<MemberVO> getAllMembers() {
		StringBuffer query = new StringBuffer();
		query.append(" SELECT EMAIL ");
	    query.append("      , NICKNAME ");
	    query.append("      , VERIFIED_YN ");
	    query.append("      , PASSWORD ");
	    query.append("      , TO_CHAR(JOIN_DATE, 'YYYY-MM-DD HH24:MI:SS') JOIN_DATE ");
	    query.append("   FROM MEMBER ");
	    
		return select(query.toString(), null, (rs) -> {
			MemberVO memberVO = new MemberVO();
			memberVO.setEmail(rs.getString("EMAIL"));
			memberVO.setNickname(rs.getString("NICKNAME"));
			memberVO.setVerifiedYn(rs.getString("VERIFIED_YN"));
			memberVO.setPassword(rs.getString("PASSWORD"));
			memberVO.setJoinDate(rs.getString("JOIN_DATE"));
			
			return memberVO;
		});
	}

	@Override
	public MemberVO getOneMember(String email, String password) {
		StringBuffer query = new StringBuffer();
		query.append(" SELECT EMAIL ");
	    query.append("      , NICKNAME ");
	    query.append("      , VERIFIED_YN ");
	    query.append("      , PASSWORD ");
	    query.append("      , TO_CHAR(JOIN_DATE, 'YYYY-MM-DD HH24:MI:SS') JOIN_DATE ");
	    query.append("   FROM MEMBER ");
	    query.append("  WHERE EMAIL = ? ");
	    query.append("    AND PASSWORD = ? ");
	    
		return selectOne(query.toString(), (pstmt) -> {
			pstmt.setString(1, email);
			pstmt.setString(2, password);
		}, (rs) -> {
			MemberVO memberVO = new MemberVO();
			memberVO.setEmail(rs.getString("EMAIL"));
			memberVO.setNickname(rs.getString("NICKNAME"));
			memberVO.setVerifiedYn(rs.getString("VERIFIED_YN"));
			memberVO.setPassword(rs.getString("PASSWORD"));
			memberVO.setJoinDate(rs.getString("JOIN_DATE"));
			
			return memberVO;
		});
	}

	@Override
	public int createMember(MemberVO memberVO) {
		StringBuffer query = new StringBuffer();
		query.append(" INSERT INTO MEMBER         ");
		query.append("  (EMAIL                    ");
		query.append(" , NICKNAME                 ");
		query.append(" , VERIFIED_YN              ");
		query.append(" , PASSWORD                 ");
		query.append(" , JOIN_DATE)               ");
		query.append(" VALUES                     ");
		query.append("  (?	/* EMAIL */           ");
		query.append(" , ?	/* NICKNAME */        ");
		query.append(" , 'N'  /* VERIFIED_YN */   ");
		query.append(" , ? /* PASSWORD  */        ");
		query.append(" , SYSDATE) /* JOIN_DATE */ ");
		
		return insert(query.toString(), (pm)-> {
			pm.setString(1, memberVO.getEmail());
			pm.setString(2, memberVO.getNickname());
			pm.setString(3, memberVO.getPassword());
		});
	}

}
