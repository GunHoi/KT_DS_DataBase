package com.ktdsuniversity.edu.goodgag.article.vo;

import java.util.List;

import com.ktdsuniversity.edu.goodgag.member.vo.MemberVO;
import com.ktdsuniversity.edu.goodgag.reply.vo.ReplyVO;

public class ArticleVO {

	private String articleNo;
	private String email;
	private String title;
	private String descript;
	private String registDate;
	private String source;
	private String notiYn;

	/**
	 * 게시글을 작성한 회원의 정보
	 */
	private MemberVO memberVO;

	/**
	 * 게시글에 등록된 댓글의 목록
	 */
	private List<ReplyVO> replyList;

	public String getArticleNo() {
		return articleNo;
	}

	public void setArticleNo(String articleNo) {
		this.articleNo = articleNo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescript() {
		return descript;
	}

	public void setDescript(String descript) {
		this.descript = descript;
	}

	public String getRegistDate() {
		return registDate;
	}

	public void setRegistDate(String registDate) {
		this.registDate = registDate;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getNotiYn() {
		return notiYn;
	}

	public void setNotiYn(String notiYn) {
		this.notiYn = notiYn;
	}

	public MemberVO getMemberVO() {
		return memberVO;
	}

	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}

	public List<ReplyVO> getReplyList() {
		return replyList;
	}

	public void setReplyList(List<ReplyVO> replyList) {
		this.replyList = replyList;
	}
}
