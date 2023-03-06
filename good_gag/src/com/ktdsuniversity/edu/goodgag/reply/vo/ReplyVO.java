package com.ktdsuniversity.edu.goodgag.reply.vo;

import com.ktdsuniversity.edu.goodgag.article.vo.ArticleVO;
import com.ktdsuniversity.edu.goodgag.member.vo.MemberVO;

public class ReplyVO {

	private String replyNo;
	private String articleNo;
	private String email;
	private String reply;
	private String registDate;
	private String modifyDate;
	private String parentReplyNo;

	/**
	 * 댓글이 달린 게시글의 정보
	 */
	private ArticleVO articleVO;
	/**
	 * 댓글을 작성한 회원의 정보
	 */
	private MemberVO memberVO;
	/**
	 * 현재 댓글이 대댓글일 경우 상위 댓글의 정보
	 */
	private ReplyVO parentReplyVO;

	public String getReplyNo() {
		return replyNo;
	}

	public void setReplyNo(String replyNo) {
		this.replyNo = replyNo;
	}

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

	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

	public String getRegistDate() {
		return registDate;
	}

	public void setRegistDate(String registDate) {
		this.registDate = registDate;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getParentReplyNo() {
		return parentReplyNo;
	}

	public void setParentReplyNo(String parentReplyNo) {
		this.parentReplyNo = parentReplyNo;
	}

	public ArticleVO getArticleVO() {
		return articleVO;
	}

	public void setArticleVO(ArticleVO articleVO) {
		this.articleVO = articleVO;
	}

	public MemberVO getMemberVO() {
		return memberVO;
	}

	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}

	public ReplyVO getParentReplyVO() {
		return parentReplyVO;
	}

	public void setParentReplyVO(ReplyVO parentReplyVO) {
		this.parentReplyVO = parentReplyVO;
	}

}
