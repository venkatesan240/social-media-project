package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import model.User;
import util.DbConnection;

public class UserDAO {
	
	static DbConnection db=new DbConnection();
	public static String register(User user) throws ClassNotFoundException {
	    try {
	        Connection conn = db.getConnection();
	        PreparedStatement st = conn.prepareStatement("INSERT INTO user(first_name, last_name, email, password) VALUES (?, ?, ?, ?);");
	        st.setString(1, user.getFirst_name());
	        st.setString(2, user.getLast_name());
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
//		ps.setString(1,user.getEmail());
//		ps.setString(2,user.getPassword());
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

	public void updateUser(User user,String email1) throws SQLException, ClassNotFoundException {
		String updateQuery="update user set first_name=?,last_name=?,email=?,password=? where email=?";
		PreparedStatement ps=db.getConnection().prepareStatement(updateQuery);
		ps.setString(1,user.getFirst_name());
		ps.setString(2,user.getLast_name());
		ps.setString(3,user.getEmail());
		ps.setString(4,user.getPassword());
		ps.setString(5,email1);
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
        try (Connection connection = db.getConnection()) {
            String sql = "SELECT first_name, last_name, email FROM users WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                user = new User();
                user.setUser_id(userId);
                user.setFirst_name(resultSet.getString("first_name"));
                user.setLast_name(resultSet.getString("last_name"));
                user.setEmail(resultSet.getString("email"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}
