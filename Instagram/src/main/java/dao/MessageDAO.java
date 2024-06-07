package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

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

	public Map<String, String> getMessage(Message msg) throws ClassNotFoundException {
		 try (Connection connection = db.getConnection()) {
	            String sql = "SELECT sender_id, message, timestamp FROM messages WHERE (sender_id = ? AND receiver_id = ?) OR (receiver_id = ? AND sender_id = ?) ORDER BY timestamp";
	            PreparedStatement statement = connection.prepareStatement(sql);
	            statement.setInt(1, msg.getSenderId());
	            statement.setInt(2, msg.getReceiverId());
	            statement.setInt(3, msg.getReceiverId());
	            statement.setInt(4, msg.getSenderId());	
	            ResultSet resultSet = statement.executeQuery();

	            List<Map<String, String>> messages = new ArrayList<>();
	            while (resultSet.next()) {
	                Map<String, String> message = new HashMap<>();
	                message.put("senderId", String.valueOf(resultSet.getInt("sender_id")));
	                message.put("message", resultSet.getString("message"));
	                message.put("timestamp", resultSet.getString("timestamp"));
	                messages.add(message);
	                System.out.println(message);
	                return message;
	            }

	            
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
		return null;
	}
	
	public List<Map<String, String>> selectUsers() throws ClassNotFoundException {
	    List<Map<String, String>> users = new ArrayList<>();
	    try (Connection connection = db.getConnection()) {
	        String sql = "SELECT user_id, first_name FROM user";
	        Statement statement = connection.createStatement();
	        ResultSet resultSet = statement.executeQuery(sql);

	        while (resultSet.next()) {
	            Map<String, String> user = new HashMap<>();
	            user.put("id", String.valueOf(resultSet.getInt("user_id")));
	            user.put("username", resultSet.getString("first_name"));
	            users.add(user);
	            //System.out.println(users);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return users; 
	}

}
