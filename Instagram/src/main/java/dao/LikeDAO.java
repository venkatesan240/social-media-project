package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DbConnection;

public class LikeDAO {
	static DbConnection db=new DbConnection();
	public void addLike(int userId, int postId) throws ClassNotFoundException {
        try {
            String sql = "INSERT INTO likes (user_id, post_id) VALUES (?, ?)";
            try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
                statement.setInt(1, userId);
                statement.setInt(2, postId);
                statement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removeLike(int userId, int postId) throws ClassNotFoundException {
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
}
