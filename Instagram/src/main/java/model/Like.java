package model;

public class Like {
	
	private int likeid;
	private int postid;
	private int userid;
	private String createdat;
	private int likecount;
	
	public Like() {
		super();
	}

	public Like(int likeid, int postid, int userid, String createdat) {
		super();
		this.likeid = likeid;
		this.postid = postid;
		this.userid = userid;
		this.createdat = createdat;
	}

	public int getLikecount() {
		return likecount;
	}

	public void setLikecount(int likecount) {
		this.likecount = likecount;
	}

	public int getLikeid() {
		return likeid;
	}

	public void setLikeid(int likeid) {
		this.likeid = likeid;
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

	public String getCreatedat() {
		return createdat;
	}

	public void setCreatedat(String createdat) {
		this.createdat = createdat;
	}
	
}
