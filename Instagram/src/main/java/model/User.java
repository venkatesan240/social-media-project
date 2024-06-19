package model;

public class User {

	private int userId;
	private String firstName;
	private String lastName;
	private String email;
	private String password;
	private String confirmPassword;
	private byte[] profile;
	
	public User() {
		super();
	}
	public User(int userId, String firstName, String lastName, String email, String password,
			String confirmpassword) {
		super();
		this.userId = userId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.password = password;
		this.confirmPassword = confirmpassword;
	}
	
	public byte[] getProfile() {
		return profile;
	}
	public void setProfile(byte[] profile) {
		this.profile = profile;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
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
		return confirmPassword;
	}
	public void setConfirmpassword(String confirmpassword) {
		this.confirmPassword = confirmpassword;
	}
	@Override
	public String toString() {
		return "user [user_id=" + userId + ", first_name=" + firstName + ", last_name=" + lastName + ", email="
				+ email + ", password=" + password + ", confirmpassword=" + confirmPassword + "]";
	}
	
	
}
