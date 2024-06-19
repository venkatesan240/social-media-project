package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.User;
import util.DbConnection;

public class UserDAO {
	
	static DbConnection db=new DbConnection();
	public static String register(User user) throws ClassNotFoundException {
	    try {
	        Connection conn = db.getConnection();
	        PreparedStatement st = conn.prepareStatement("INSERT INTO user(first_name, last_name, email, password) VALUES (?, ?, ?, ?);");
	        st.setString(1, user.getFirstName());
	        st.setString(2, user.getLastName());
	        st.setString(3, user.getEmail());
	        st.setString(4, user.getPassword());
	        st.execute();
	        return "Registration Successful.";
	    } catch (SQLException e) {
	       return "Registration failed";
	    }
	}
	
	public boolean logincredencial(User user) throws ClassNotFoundException, SQLException {
		String selectQuery="select email,password from user where email='"+user.getEmail()+"' and password='"+user.getPassword()+"'";
		PreparedStatement ps=db.getConnection().prepareStatement(selectQuery);
		  ResultSet rows = ps.executeQuery();
	        ResultSetMetaData metaData = rows.getMetaData();
	        int columnCount = metaData.getColumnCount();

	        while(rows.next()) {

	            for (int i = 1; i <= columnCount; i += 1) {
	                
	                return true;
	            }
	        }
	        return false;
	}

	public void updateUser(User user,int userid) throws SQLException, ClassNotFoundException {
		String updateQuery="update user set first_name=?,last_name=?,email=?,profile=? where user_id=?";
		PreparedStatement ps=db.getConnection().prepareStatement(updateQuery);
		ps.setString(1,user.getFirstName());
		ps.setString(2,user.getLastName());
		ps.setString(3,user.getEmail());
		ps.setBytes(4,user.getProfile());
		ps.setInt(5,userid);
		ps.executeUpdate();
	}
	
	public String getName(String email) throws ClassNotFoundException, SQLException {
		String selectQuery="select first_name from user where email=?";
		PreparedStatement ps=db.getConnection().prepareStatement(selectQuery);
		ps.setString(1,email);
		ResultSet rs=ps.executeQuery();
		while(rs.next()) {
			return rs.getString(1);
		}
		return null;
		
	}

	public int getId(String email) throws ClassNotFoundException, SQLException {
		String selectQuery="select user_id from user where email=?";
		PreparedStatement ps=db.getConnection().prepareStatement(selectQuery);
		ps.setString(1,email);
		ResultSet rs=ps.executeQuery();
		while(rs.next()) {
			return rs.getInt("user_id");
		}
		return 0;
		
	}
	public User getUserById(int userId) throws ClassNotFoundException {
        User user = null;
        try {
            String sql = "SELECT first_name, last_name, email,profile FROM user WHERE user_id = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, userId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                user = new User();
                user.setUserId(userId);
                user.setFirstName(resultSet.getString("first_name"));
                user.setLastName(resultSet.getString("last_name"));
                user.setEmail(resultSet.getString("email"));
                user.setProfile(resultSet.getBytes("profile"));
                return user;
            }
        } catch (SQLException e) {
        	System.out.println("failed");
            e.printStackTrace();
        }
		return user;
       
    }
	
	public List<User> searchUsersByUsername(String query) throws SQLException, ClassNotFoundException {
		List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM user WHERE first_name LIKE ?";
        try (Connection connection = db.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, "%" + query + "%");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                User user = new User();
                user.setUserId(resultSet.getInt("user_id"));
                user.setFirstName(resultSet.getString("first_name"));
                users.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
	}

	public void updatePassword(String password,String email) throws ClassNotFoundException, SQLException {
		String updateQuery="update user set password=? where email=?";
		PreparedStatement ps=db.getConnection().prepareStatement(updateQuery);
		ps.setString(1,password);
		ps.setString(2,email);
		ps.executeUpdate();
	}
	 
}
