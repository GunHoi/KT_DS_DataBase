package com.ktdsuniversity.edu.goodgag.reply.service;

import com.ktdsuniversity.edu.goodgag.reply.dao.ReplyDAO;
import com.ktdsuniversity.edu.goodgag.reply.dao.ReplyDAOImpl;
import com.ktdsuniversity.edu.goodgag.reply.vo.ReplyVO;

public class ReplyServiceImpl implements ReplyService{

	private ReplyDAO replyDAO;
	
	public ReplyServiceImpl() {
		replyDAO = new ReplyDAOImpl();
	}
	
	@Override
	public boolean createReply(ReplyVO replyVO) {
		
		String newReplyNo = replyDAO.createNewReplyNo();
		
		replyVO.setReplyNo(newReplyNo);
		
		int insertCount = replyDAO.createReply(replyVO);
		
		return insertCount > 0;
	}

}
