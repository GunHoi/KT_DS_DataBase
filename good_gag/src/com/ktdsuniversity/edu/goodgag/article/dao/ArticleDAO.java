package com.ktdsuniversity.edu.goodgag.article.dao;

import java.util.List;

import com.ktdsuniversity.edu.goodgag.article.vo.ArticleVO;

public interface ArticleDAO {

	/**
	 * 게시글의 새로운 PK값을 조회한다.
	 * @return 게시글의 PK값 (AR-날짜-시퀀스)
	 */
	public String createNewArticleNo();

	/**
	 * 게시글 등록
	 * @param articleVO 게시글의 정보
	 * @return Insert한 개수
	 */
	public int createArticle(ArticleVO articleVO);
	
	/**
	 * 모든 게시글의 목록을 조회한다.
	 * @return 게시글 목록
	 */
	public List<ArticleVO> getAllArticles();
	
	public int deleteArticle(ArticleVO articleVO);
}
