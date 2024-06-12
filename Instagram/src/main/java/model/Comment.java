package model;

public class Comment {

	private int commentid;
	private int postid;
	private int userid;
	private String comment;
	private String createdat;
	
	
	public Comment() {
		super();
	}


	public Comment(int commentid, int postid, int userid, String comment, String createdat) {
		super();
		this.commentid = commentid;
		this.postid = postid;
		this.userid = userid;
		this.comment = comment;
		this.createdat = createdat;
	}


	public int getCommentid() {
		return commentid;
	}


	public void setCommentid(int commentid) {
		this.commentid = commentid;
	}


	public int getPostid() {
		return postid;
	}


	public void setPostid(int postid) {
		this.postid = postid;
	}


	public int getUserid() {
		return userid;
	}


	public void setUserid(int userid) {
		this.userid = userid;
	}


	public String getComment() {
		return comment;
	}


	public void setComment(String comment) {
		this.comment = comment;
	}


	public String getCreatedat() {
		return createdat;
	}


	public void setCreatedat(String createdat) {
		this.createdat = createdat;
	}
	
	
	
}
