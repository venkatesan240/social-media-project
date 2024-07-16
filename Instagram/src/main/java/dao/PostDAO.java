package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Post;
import util.DbConnection;

public class PostDAO {
	
	static DbConnection db=new DbConnection();
	public void savePost(Post post) throws SQLException, ClassNotFoundException {
            String sql = "INSERT INTO posts (user_id,description, image,user_name) values (?,?,?,?)";
            PreparedStatement stmt= db.getConnection().prepareStatement(sql);
            stmt.setInt(1,post.getUserid());
            stmt.setString(2,post.getDescription());
            stmt.setBytes(3,post.getImage());
            stmt.setString(4,post.getUsername());
            stmt.executeUpdate(); 
    }
	
	public List<Post> getAllPosts() throws SQLException, ClassNotFoundException {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT id,user_id,user_name,description,image,timestamp FROM posts";
             PreparedStatement stmt = db.getConnection().prepareStatement(sql);
             ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Post post = new Post();
                post.setDescription(rs.getString("description"));
                post.setImage(rs.getBytes("image"));
                post.setUsername(rs.getString("user_name"));
                post.setTimestamp(rs.getString("timestamp"));
                post.setId(rs.getInt("id"));
                post.setUserid(rs.getInt("user_id"));
                posts.add(post);
            }
        return posts;
    }

	public boolean deletePost(int postId) throws ClassNotFoundException {
        String sql = "DELETE FROM posts WHERE id = ?";
        try {
        	PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setInt(1, postId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
