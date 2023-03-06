package com.ktdsuniversity.edu.goodgag;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.ktdsuniversity.edu.goodgag.member.dao.MemberDAO;
import com.ktdsuniversity.edu.goodgag.member.dao.MemberDAOImpl;
import com.ktdsuniversity.edu.goodgag.member.vo.MemberVO;

public class GoodGagDAO {
	
	public static void printAllReplies() {
		// 1. Oracle Driver Loading
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		}
		// 2. DB 연결
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "BBS", "BBS1234");
			// 3. Query 작성
			StringBuffer query = new StringBuffer();
			query.append(" SELECT REPLY_NO ");                                                 
		    query.append("      , ARTICLE_NO ");                                                      
		    query.append("      , EMAIL ");                                                      
		    query.append("      , REPLY ");                                                   
		    query.append("      , TO_CHAR(REGIST_DATE, 'YYYY-MM-DD HH24:MI:SS') REGIST_DATE ");  
		    query.append("      , TO_CHAR(MODIFY_DATE, 'YYYY-MM-DD HH24:MI:SS') MODIFY_DATE ");  
		    query.append("      , PARENT_REPLY_NO ");
		    query.append("   FROM REPLIES ");  
		    
			// 4. Query 실행
			pstmt = conn.prepareStatement(query.toString());
			// 5. Query 결과 받아서 출력
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String replyNo = rs.getString("REPLY_NO");
				String articleNo = rs.getString("ARTICLE_NO");
				String email = rs.getString("EMAIL");
				String reply = rs.getString("REPLY");
				String registDate = rs.getString("REGIST_DATE");
				String modifyDate = rs.getString("MODIFY_DATE");
				String parentReplyNo = rs.getString("PARENT_REPLY_NO");
				
				
				System.out.println(replyNo + "\t" + articleNo + "\t" + email + "\t" + reply + "\t" + registDate + "\t" + modifyDate + "\t" + parentReplyNo);
			}
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		} finally {
			// 6. DB 연결 해제
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException sqle) {}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException sqle) {}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {}
			}
		}
	}
	
	public static void printAllArticles() {
		// 1. Oracle Driver Loading
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		}
		// 2. DB 연결
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "BBS", "BBS1234");
			// 3. Query 작성
			StringBuffer query = new StringBuffer();
			query.append(" SELECT ARTICLE_NO ");                                                 
		    query.append("      , EMAIL ");                                                      
		    query.append("      , TITLE ");                                                      
		    query.append("      , DESCRIPT ");                                                   
		    query.append("      , TO_CHAR(REGIST_DATE, 'YYYY-MM-DD HH24:MI:SS') REGIST_DATE ");  
		    query.append("      , SOURCE ");                                                     
		    query.append("      , NOTI_YN ");                                                    
		    query.append("   FROM ARTICLE ");                                                    
		    
			// 4. Query 실행
			pstmt = conn.prepareStatement(query.toString());
			// 5. Query 결과 받아서 출력
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String articleNo = rs.getString("ARTICLE_NO");
				String email = rs.getString("EMAIL");
				String title = rs.getString("TITLE");
				String descript = rs.getString("DESCRIPT");
				String registDate = rs.getString("REGIST_DATE");
				String source = rs.getString("SOURCE");
				String notiYN = rs.getString("NOTI_YN");
				
				System.out.println(articleNo + "\t" + email + "\t" + title + "\t" + descript + "\t" + registDate + "\t" + source + "\t" + notiYN);
			}
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		} finally {
			// 6. DB 연결 해제
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException sqle) {}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException sqle) {}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {}
			}
			
		}
	}
	
	public static void printOneMembers(String pEmail, String pPassword) {
		// 1. Oracle Driver Loading
		// oracle.jdbc.driver.OracleDriver
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		}
		
		
		// 2. Oracle DB에 연결
		// jdbc:oracle:thin:@localhost:1521:XE
		Connection conn = null;
		PreparedStatement pstmt = null;	// DB에게 쿼리를 실행 요청하는 객체.
		ResultSet rs = null; 	//Query의 실행 결과를 받아오는 객체
		
		try {
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "BBS", "BBS1234");
			
			// 3. Query 작성
			// 여러 줄의 String을 작성할 때, 사용할 수 있는 객체
			StringBuffer query = new StringBuffer();
			query.append(" SELECT EMAIL ");
		    query.append("      , NICKNAME ");
		    query.append("      , VERIFIED_YN "); 
		    query.append("      , PASSWORD ");
		    query.append("      , TO_CHAR(JOIN_DATE, 'YYYY-MM-DD HH24:MI:SS') JOIN_DATE ");
		    query.append("   FROM MEMBER ");
		    query.append("  WHERE EMAIL = ? ");
		    query.append("    AND PASSWORD = ? ");
		    
		    // 3-1. Query 실행
		    pstmt = conn.prepareStatement(query.toString());
		    // 3-2. Query 파라미터 바인딩
		    pstmt.setString(1, pEmail);
		    pstmt.setString(2, pPassword);
		    // 4. Query 결과 받아오기
		    rs = pstmt.executeQuery();	//DB Query 실행 후 Result Set을 return
		    
		    // ResultSet
		    // rs.next() : Cursor를 한 칸 아래로 내린다.
		    // rs.get~(컬럼명) : Cursor가 가리키는 ROW의 COLUMN 데이터를 받아온다.
		    while (rs.next()) {
		    	String email = rs.getString("EMAIL");
		    	String nickName = rs.getString("NICKNAME");
		    	String verifiedYn = rs.getString("VERIFIED_YN");
		    	String password = rs.getString("PASSWORD");
		    	String joinDate = rs.getString("JOIN_DATE");	//날짜 type이어도 String으로 받아온다.
		    
		    	System.out.println(email + "\t" + nickName + "\t" + verifiedYn + "\t" + password + "\t" + joinDate);
		    }
		    
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		} finally {
			// 5. DB 연결 해제
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException sqle) {}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException sqle) {}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {}
			}
		}
	
	}
	
	public static void printAllMembers() {
		
		// 1. Oracle Driver Loading
		// oracle.jdbc.driver.OracleDriver
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		}
		
		
		// 2. Oracle DB에 연결
		// jdbc:oracle:thin:@localhost:1521:XE
		Connection conn = null;
		PreparedStatement pstmt = null;	// DB에게 쿼리를 실행 요청하는 객체.
		ResultSet rs = null; 	//Query의 실행 결과를 받아오는 객체
		
		try {
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "BBS", "BBS1234");
			
			// 3. Query 작성
			// 여러 줄의 String을 작성할 때, 사용할 수 있는 객체
			StringBuffer query = new StringBuffer();
			query.append(" SELECT EMAIL ");
		    query.append("      , NICKNAME ");
		    query.append("      , VERIFIED_YN "); 
		    query.append("      , PASSWORD ");
		    query.append("      , TO_CHAR(JOIN_DATE, 'YYYY-MM-DD HH24:MI:SS') JOIN_DATE ");
		    query.append("   FROM MEMBER ");
		    
		    // 3-1. Query 실행
		    pstmt = conn.prepareStatement(query.toString());
		    
		    // 4. Query 결과 받아오기
		    rs = pstmt.executeQuery();	//DB Query 실행 후 Result Set을 return
		    
		    // ResultSet
		    // rs.next() : Cursor를 한 칸 아래로 내린다.
		    // rs.get~(컬럼명) : Cursor가 가리키는 ROW의 COLUMN 데이터를 받아온다.
		    while (rs.next()) {
		    	String email = rs.getString("EMAIL");
		    	String nickName = rs.getString("NICKNAME");
		    	String verifiedYn = rs.getString("VERIFIED_YN");
		    	String password = rs.getString("PASSWORD");
		    	String joinDate = rs.getString("JOIN_DATE");	//날짜 type이어도 String으로 받아온다.
		    
		    	System.out.println(email + "\t" + nickName + "\t" + verifiedYn + "\t" + password + "\t" + joinDate);
		    }
		    
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		} finally {
			// 5. DB 연결 해제
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException sqle) {}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException sqle) {}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {}
			}
		}
	}
	
	public static void main(String[] args) {
		printAllMembers();
		System.out.println();
		printOneMembers("a@gmail.com", "PASSWORD1");
		System.out.println("===========================================================================");
		
		MemberDAO memberDAO = new MemberDAOImpl();
		List<MemberVO> allMemberList = memberDAO.getAllMembers();
		for(MemberVO members : allMemberList) {
			System.out.println(members.getEmail() + "\t" + members.getNickname() + "\t" + members.getVerifiedYn() + "\t" + members.getPassword() + "\t" + members.getJoinDate());
		}
		MemberVO member = memberDAO.getOneMember("a@gmail.com", "PASSWORD1");
		System.out.println();
		System.out.println(member.getEmail() + "\t" + member.getNickname() + "\t" + member.getVerifiedYn() + "\t" + member.getPassword() + "\t" + member.getJoinDate());
		
//		printOneMembers("b@gmail.com", "Wrong PW");	// 이상한 값을 넣어도 error가 발생하지 않는다. => where 조건에 의해 아무것도 안나온다.
//		printOneMembers("WrongId@gmail.com","PASSWORD3");
//		System.out.println();
//		
//		printAllArticles();
//		System.out.println();
//		
//		printAllReplies();
	}

}