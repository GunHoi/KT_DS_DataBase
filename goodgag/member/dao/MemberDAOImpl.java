package com.ktdsuniversity.edu.goodgag.member.dao;

import java.util.List;

import com.ktdsuniversity.edu.goodgag.member.vo.MemberVO;
import com.ktdsuniversity.edu.goodgag.utils.db.AbstractDaoSupport;

public class MemberDAOImpl extends AbstractDaoSupport<MemberVO> implements MemberDAO{

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

}
