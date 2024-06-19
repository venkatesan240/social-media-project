package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;

import model.User;
import util.DbConnection;

public class LikeDAO {
	static DbConnection db=new DbConnection();
	public void addLike(int userId, int postId) throws ClassNotFoundException, SQLException {
        try {
            String sql = "INSERT INTO likes (user_id, post_id) VALUES (?, ?)";
            try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
                statement.setInt(1, userId);
                statement.setInt(2, postId);
                statement.executeUpdate();
            }
        } catch (SQLIntegrityConstraintViolationException e) {
            e.printStackTrace();
        }
    }

    public void removeLike(int postId,int userId) throws ClassNotFoundException {
        try {
            String sql = "DELETE FROM likes WHERE user_id = ? AND post_id = ?";
            try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
                statement.setInt(1, userId);
                statement.setInt(2, postId);
                statement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public int getLikeCount(int postId) throws ClassNotFoundException {
        try  {
            String sql = "SELECT COUNT(*) AS like_count FROM likes WHERE post_id = ?";
            try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
                statement.setInt(1, postId);
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        return resultSet.getInt("like_count");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    public boolean isLikedByUser(int postId,int userId) throws SQLException, ClassNotFoundException {
        String query = "SELECT COUNT(*) FROM likes WHERE user_id = ? AND post_id = ?";
        try (PreparedStatement stmt = db.getConnection().prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, postId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
    public List<User> getUsersWhoLiked(int postId) throws ClassNotFoundException {
    	 final String SELECT_USERS_WHO_LIKED = "SELECT u.user_id, u.first_name, u.last_name, u.profile FROM likes l INNER JOIN user u ON l.user_id = u.user_id WHERE l.post_id = ?";
        List<User> users = new ArrayList<>();
        try (Connection connection = db.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USERS_WHO_LIKED)) {
            preparedStatement.setInt(1, postId);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setProfile(rs.getBytes("profile"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
}
