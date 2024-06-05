package model;

public class User {

	private int user_id;
	private String first_name;
	private String last_name;
	private String email;
	private String password;
	private String confirmpassword;
	
	public User() {
		super();
	}
	public User(int user_id, String first_name, String last_name, String email, String password,
			String confirmpassword) {
		super();
		this.user_id = user_id;
		this.first_name = first_name;
		this.last_name = last_name;
		this.email = email;
		this.password = password;
		this.confirmpassword = confirmpassword;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getFirst_name() {
		return first_name;
	}
	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}
	public String getLast_name() {
		return last_name;
	}
	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getConfirmpassword() {
		return confirmpassword;
	}
	public void setConfirmpassword(String confirmpassword) {
		this.confirmpassword = confirmpassword;
	}
	@Override
	public String toString() {
		return "user [user_id=" + user_id + ", first_name=" + first_name + ", last_name=" + last_name + ", email="
				+ email + ", password=" + password + ", confirmpassword=" + confirmpassword + "]";
	}
	
	
}
