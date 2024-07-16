package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.Message;
import util.DbConnection;

public class MessageDAO {
	
	static DbConnection db=new DbConnection();
	public void insertMessage(Message msg) throws ClassNotFoundException {
		 try (Connection connection = db.getConnection()) {
	            String sql = "INSERT INTO messages (sender_id, receiver_id, message) VALUES (?, ?, ?)";
	            PreparedStatement statement = connection.prepareStatement(sql);
	            statement.setInt(1,msg.getSenderId());
	            statement.setInt(2,msg.getReceiverId());
	            statement.setString(3,msg.getMessage());
	            statement.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	}

	public ArrayList<Message> getMessage(Message msg) throws ClassNotFoundException {
	    ArrayList<Message> messages = new ArrayList<>();
	    try (Connection connection = db.getConnection()) {
	        String sql = "SELECT * FROM messages WHERE (sender_id = ? AND receiver_id = ?) OR (receiver_id = ? AND sender_id = ?) ORDER BY timestamp";
	        PreparedStatement statement = connection.prepareStatement(sql);
	        statement.setInt(1, msg.getSenderId());
	        statement.setInt(2, msg.getReceiverId());
	        statement.setInt(3, msg.getSenderId());
	        statement.setInt(4, msg.getReceiverId());     
	        ResultSet rs = statement.executeQuery();
	        while (rs.next()) {
	        	Message msg1=new Message();
	        	msg1.setId(rs.getInt("id"));
	        	msg1.setMessage(rs.getString("message"));
	        	msg1.setSenderId(rs.getInt("sender_id"));
	            msg1.setReceiverId(rs.getInt("receiver_id"));
	            msg1.setTimestamp(rs.getString("timestamp"));
	            messages.add(msg1);
	        }	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return messages;
	}
	
	public void deleteMessage(int chatID) throws SQLException, ClassNotFoundException{
		try {
			PreparedStatement st = db.getConnection().prepareStatement("DELETE FROM message WHERE id = ?");
			st.setInt(1, chatID);
			st.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public List<Map<String, String>> selectUsers() throws ClassNotFoundException {
	    List<Map<String, String>> users = new ArrayList<>();
	    try (Connection connection = db.getConnection()) {
	        String sql = "SELECT user_id, first_name,profile FROM user";
	        Statement statement = connection.createStatement();
	        ResultSet resultSet = statement.executeQuery(sql);
	        while (resultSet.next()) {
	            Map<String, String> user = new HashMap<>();
	            user.put("id", String.valueOf(resultSet.getInt("user_id")));
	            user.put("username", resultSet.getString("first_name"));
	            users.add(user);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return users; 
	}

}
