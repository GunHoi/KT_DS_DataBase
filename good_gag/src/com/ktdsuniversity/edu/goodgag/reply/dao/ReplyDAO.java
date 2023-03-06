package com.ktdsuniversity.edu.goodgag.reply.dao;

import com.ktdsuniversity.edu.goodgag.reply.vo.ReplyVO;

public interface ReplyDAO {
	
	public String createNewReplyNo();
	
	public int createReply(ReplyVO replyVO);
}
