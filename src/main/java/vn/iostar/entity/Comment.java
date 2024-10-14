package vn.iostar.entity;

import java.io.Serializable;
import java.util.Date;

import jakarta.persistence.*;

@Entity
@Table(name = "comments")
@NamedQuery(name = "Comment.findAll", query = "SELECT c FROM Comment c")
public class Comment implements Serializable {
    
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CommentId")
    private int id;  // ID của bình luận

    @Column(name = "Content", columnDefinition = "nvarchar(500) NOT NULL")
    private String content;  // Nội dung bình luận

    @Column(name = "VideoId")
    private String videoId;  // ID của video mà bình luận thuộc về

    @Column(name = "Username", columnDefinition = "nvarchar(50) NOT NULL")
    private String username;  // Tên người dùng đã viết bình luận

    @Column(name = "CreatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;  // Thời gian tạo bình luận

    @ManyToOne
    @JoinColumn(name = "VideoId", insertable = false, updatable = false) // Liên kết đến Video
    private Video video;  // Video mà bình luận thuộc về

    // Constructor
    public Comment() {
        this.createdAt = new Date(); // Thời gian mặc định là thời gian hiện tại
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int commentId) {
        this.id = commentId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Video getVideo() {
        return video;
    }

    public void setVideo(Video video) {
        this.video = video;
    }



}
