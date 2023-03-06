package com.ktdsuniversity.edu.goodgag.reply.dao;

import com.ktdsuniversity.edu.goodgag.reply.vo.ReplyVO;
import com.ktdsuniversity.edu.goodgag.utils.db.AbstractDaoPoolSupport;

public class ReplyDAOImpl extends AbstractDaoPoolSupport<ReplyVO> implements ReplyDAO{

	@Override
	public String createNewReplyNo() {
		StringBuffer query = new StringBuffer();
		query.append(" SELECT 'RP-' ");
	    query.append("        || TO_CHAR(SYSDATE, 'YYYYMMDD') "); 
	    query.append("        || '-'  ");
	    query.append("        || LPAD(SEQ_REPLIES_PK.NEXTVAL, 5, '0') NEW_SEQ ");
	    query.append("   FROM DUAL ");

		return selectOneString(query.toString(), null, (rm) -> {
			return rm.getString("NEW_SEQ");
		});
	}

	@Override
	public int createReply(ReplyVO replyVO) {
		StringBuffer query = new StringBuffer();
		query.append(" INSERT INTO REPLIES                            ");
		query.append("  (REPLY_NO                                     ");
		query.append(" , ARTICLE_NO                                   ");
		query.append(" , EMAIL                                        ");
		query.append(" , REPLY                                        ");
		query.append(" , REGIST_DATE                                  ");
		query.append(" , MODIFY_DATE                                  ");
		query.append(" , PARENT_REPLY_NO)                             ");
		query.append(" VALUES                                         ");
		query.append("  ('RP-' || TO_CHAR(SYSDATE, 'YYYYMMDD') || '-' ");
		query.append("      || LPAD(SEQ_REPLIES_PK.NEXTVAL, 5, '0')   ");
		query.append(" , 'AR-20230303-00029'                          ");
		query.append(" , ?                                ");
		query.append(" , ?                                 ");
		query.append(" , SYSDATE                                      ");
		query.append(" , SYSDATE                                      ");
		query.append(" , 'RP-20230303-00052')                         ");
		
		return insert(query.toString(), (pm) -> {
			pm.setString(1, replyVO.getEmail());
			pm.setString(2, replyVO.getReply());
		});
	}


}
