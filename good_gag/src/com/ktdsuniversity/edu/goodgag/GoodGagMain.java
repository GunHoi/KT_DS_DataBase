package com.ktdsuniversity.edu.goodgag;

import java.util.List;

import com.ktdsuniversity.edu.goodgag.article.dao.ArticleDAO;
import com.ktdsuniversity.edu.goodgag.article.dao.ArticleDAOImpl;
import com.ktdsuniversity.edu.goodgag.article.service.ArticleService;
import com.ktdsuniversity.edu.goodgag.article.service.ArticleServiceImpl;
import com.ktdsuniversity.edu.goodgag.article.vo.ArticleVO;
import com.ktdsuniversity.edu.goodgag.articlelikedislike.dao.ArticleLikeDislikeDAO;
import com.ktdsuniversity.edu.goodgag.articlelikedislike.dao.ArticleLikeDislikeDAOImpl;
import com.ktdsuniversity.edu.goodgag.articlelikedislike.vo.ArticleLikeDislikeVO;
import com.ktdsuniversity.edu.goodgag.member.dao.MemberDAO;
import com.ktdsuniversity.edu.goodgag.member.dao.MemberDAOImpl;
import com.ktdsuniversity.edu.goodgag.member.vo.MemberVO;
import com.ktdsuniversity.edu.goodgag.reply.dao.ReplyDAO;
import com.ktdsuniversity.edu.goodgag.reply.dao.ReplyDAOImpl;
import com.ktdsuniversity.edu.goodgag.reply.vo.ReplyVO;

public class GoodGagMain {

	public static void main(String[] args) {
		
		// 회원 가입
		MemberDAO memberDAO = new MemberDAOImpl();
		MemberVO memberVO = new MemberVO();
		memberVO.setEmail("test@gmail.com");
		memberVO.setNickname("홍길동");
		memberVO.setPassword("abcd1234");
//		memberDAO.createMember(memberVO);
		
		// 게시글 작성
//		ArticleDAO articleDAO = new ArticleDAOImpl();
		ArticleService articleService = new ArticleServiceImpl();
		ArticleVO articleVO = new ArticleVO();
		articleVO.setEmail(memberVO.getEmail());
		articleVO.setTitle("testTitle2");
		articleVO.setDescript("testDescripts2");
		articleVO.setSource("testSource2");	
		articleVO.setNotiYn("N");
//		articleDAO.createArticle(articleVO);
		boolean isSuccess = articleService.createArticle(articleVO);
//		System.out.println(isSuccess);
//		System.out.println(articleVO.getArticleNo());
		
		// 게시글 목록 조회 (댓글 개수 포함)
		List<ArticleVO> articleList = articleService.getAllArticles();
		for(ArticleVO av : articleList) {
			System.out.println(av.getTitle() + "\t" + av.getArticleNo() + "\t" 
		                     + av.getMemberVO().getNickname() + "\t" 
					         + av.getReplyList().size());
		}
		// 게시글 상세 조회 (댓글 포함)
		
		// 게시글 수정
		
		// 댓글 작성
		ReplyDAO replyDAO = new ReplyDAOImpl();
		ReplyVO replyVO = new ReplyVO();
		replyVO.setEmail(memberVO.getEmail());
		replyVO.setReply("testReply's Reply");
//		replyDAO.createReply(replyVO);
		// 댓글 수정
		
		// 게시글 삭제
		ArticleDAO articleDAO = new ArticleDAOImpl();
		ArticleVO deleteArticleVO = new ArticleVO();
		deleteArticleVO.setTitle("testTitle2");
//		articleDAO.deleteArticle(deleteArticleVO);
		// 댓글 삭제
		
		// 게시글 좋아요
		ArticleLikeDislikeDAO likeDAO = new ArticleLikeDislikeDAOImpl();
		ArticleLikeDislikeVO likeVO = new ArticleLikeDislikeVO();
		likeVO.setEmail(memberVO.getEmail());
		likeVO.setArticleNo("AR-20230303-00031");
		likeVO.setType("L");
		likeDAO.createArticleLikeDislike(likeVO);
		
		// 게시글 싫어요
		ArticleLikeDislikeDAO disLikeDAO = new ArticleLikeDislikeDAOImpl();
		ArticleLikeDislikeVO disLikeVO = new ArticleLikeDislikeVO();
		disLikeVO.setEmail(memberVO.getEmail());
		disLikeVO.setArticleNo("AR-20230303-00033");
		disLikeVO.setType("D");
		disLikeDAO.createArticleLikeDislike(disLikeVO);
		// 게시글 신고
		
		// 댓글 좋아요
		
		// 댓글 싫어요
		
	}
}
