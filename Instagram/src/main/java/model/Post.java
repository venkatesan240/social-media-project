package model;

import java.util.Arrays;

public class Post {
	
	private int id;
    private String username;
    private String description;
    private byte[] image;
    private String timestamp;
    
	public Post() {
		super();
	}
	public Post(int id, String username, String description, byte[] image, String timestamp) {
		super();
		this.id = id;
		this.username = username;
		this.description = description;
		this.image = image;
		this.timestamp = timestamp;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public byte[] getImage() {
		return image;
	}
	public void setImage(byte[] image) {
		this.image = image;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	@Override
	public String toString() {
		return "Post [id=" + id + ", username=" + username + ", description=" + description + ", image="
				+ Arrays.toString(image) + ", timestamp=" + timestamp + "]";
	}
    

}
