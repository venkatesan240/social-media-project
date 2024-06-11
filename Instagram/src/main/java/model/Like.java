package model;

public class Like {
	
	private int like_id;
	private int post_id;
	private int user_id;
	private String created_at;
	
	public Like() {
		super();
	}
	public Like(int like_id, int post_id, int user_id, String created_at) {
		super();
		this.like_id = like_id;
		this.post_id = post_id;
		this.user_id = user_id;
		this.created_at = created_at;
	}
	public int getLike_id() {
		return like_id;
	}
	public void setLike_id(int like_id) {
		this.like_id = like_id;
	}
	public int getPost_id() {
		return post_id;
	}
	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}

	
}
