package com.ktdsuniversity.edu.goodgag.articlelikedislike.vo;

import com.ktdsuniversity.edu.goodgag.article.vo.ArticleVO;

public class ArticleLikeDislikeVO {
	private String email;
	private String articleNo;
	private String type;

	private ArticleVO articleVO;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getArticleNo() {
		return articleNo;
	}

	public void setArticleNo(String articleNo) {
		this.articleNo = articleNo;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public ArticleVO getArticleVO() {
		return articleVO;
	}

	public void setArticleVO(ArticleVO articleVO) {
		this.articleVO = articleVO;
	}
}
