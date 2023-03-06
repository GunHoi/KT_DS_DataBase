package com.ktdsuniversity.edu.goodgag.articlelikedislike.dao;

import com.ktdsuniversity.edu.goodgag.article.vo.ArticleVO;
import com.ktdsuniversity.edu.goodgag.articlelikedislike.vo.ArticleLikeDislikeVO;
import com.ktdsuniversity.edu.goodgag.utils.db.AbstractDaoPoolSupport;

public class ArticleLikeDislikeDAOImpl extends AbstractDaoPoolSupport<ArticleVO> implements ArticleLikeDislikeDAO {

	@Override
	public int createArticleLikeDislike(ArticleLikeDislikeVO likeDislikeVO) {
		StringBuffer query = new StringBuffer();
		query.append(" INSERT INTO ARTICLE_LIKE_DISLIKE ");
		query.append("  (EMAIL                          ");
		query.append(" , ARTICLE_NO                     ");
		query.append(" , TYPE)                          ");
		query.append(" VALUES                           ");
		query.append("  (?               ");
		query.append(" , ?            ");
		query.append(" , ?)                           ");
		
		return insert(query.toString(), (pm)->{
			pm.setString(1, likeDislikeVO.getEmail());
			pm.setString(2, likeDislikeVO.getArticleNo());
			pm.setString(3, likeDislikeVO.getType());
		});
	}

}
