package com.ktdsuniversity.edu.goodgag.articlelikedislike.service;

import com.ktdsuniversity.edu.goodgag.articlelikedislike.dao.ArticleLikeDislikeDAO;
import com.ktdsuniversity.edu.goodgag.articlelikedislike.dao.ArticleLikeDislikeDAOImpl;
import com.ktdsuniversity.edu.goodgag.articlelikedislike.vo.ArticleLikeDislikeVO;

public class ArticleLikeDislikeServiceImpl implements ArticleLikeDislikeService {

	private ArticleLikeDislikeDAO likeDislikeDAO;

	public ArticleLikeDislikeServiceImpl() {
		likeDislikeDAO = new ArticleLikeDislikeDAOImpl();
	}

	public boolean createArticleLikeDislike(ArticleLikeDislikeVO likeDislikeVO) {
		
		return false;
	}
}
