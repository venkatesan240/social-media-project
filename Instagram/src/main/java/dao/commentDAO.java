package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Comment;
import util.DbConnection;

public class commentDAO {
	 private static final String INSERT_COMMENT = "INSERT INTO comments (post_id,user_id, content,created_at ) VALUES (?, ?, ?, ?)";
	    private static final String SELECT_COMMENTS_BY_POST_ID = "SELECT * FROM comments WHERE post_id = ? ORDER BY created_at DESC";
	
	static DbConnection db=new DbConnection();
	public static void addComment(Comment comment) throws ClassNotFoundException {
        try {
             PreparedStatement stmt = db.getConnection().prepareStatement(INSERT_COMMENT);
            
            stmt.setInt(1, comment.getPostid());
            stmt.setInt(2, comment.getUserid());
            stmt.setString(3, comment.getComment());
            stmt.setString(4, comment.getComment());
            
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQLException
        }
    }
	
	public static List<Comment> getCommentsByPostId(int postId) throws ClassNotFoundException {
        List<Comment> comments = new ArrayList<>();

        try {
             PreparedStatement stmt = db.getConnection().prepareStatement(SELECT_COMMENTS_BY_POST_ID);

            stmt.setInt(1, postId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                int userid = rs.getInt("user_id");
                String commentText = rs.getString("content");
                String timestamp = rs.getString("created_at");

                Comment comment = new Comment();
                comment.setCommentid(id);
                comment.setUserid(userid);
                comment.setComment(commentText);
                comment.setCreatedat(timestamp);
                comments.add(comment);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQLException
        }

        return comments;
    }

}
