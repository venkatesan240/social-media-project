package dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import util.DbConnection;

public class PostADAO {
	
	static DbConnection db=new DbConnection();
	private void savePostToDatabase(String postContent, InputStream inputStream) throws SQLException, IOException, ClassNotFoundException {
            String sql = "INSERT INTO posts (user_id,description, image) values (?,?,?)";
            PreparedStatement stmt= db.getConnection().prepareStatement(sql);
            stmt.setString(1, postContent);

            if (inputStream != null) {
                stmt.setBlob(2, inputStream);
            }
            stmt.executeUpdate(); 
    }
}
