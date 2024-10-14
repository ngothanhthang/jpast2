package vn.iostar.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import jakarta.persistence.*;


@Entity
@Table(name="videos")
@NamedQuery(name="Video.findAll", query="SELECT v FROM Video v")
public class Video implements Serializable{

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name="VideoId")
    private String videoId;

    @Column(name="Active")
    private int active;

    @Column(name="Description",columnDefinition = "NVARCHAR(MAX)")
    private String description;

    @Column(name="Poster") // Hình ảnh    
    private String poster;

    @Column(name="Title",columnDefinition = "NVARCHAR(MAX)")
    private String title;

    @Column(name="Views")
    private int views;

    @Column(name="VideoPath")
    private String videoPath;

    @ManyToOne
    @JoinColumn(name="CategoryId")
    private Category category;
    
    // Mối quan hệ với Comment
    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Comment> comments;
    
    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Rating> ratings;
    
    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Like> likes;

    
    
    public Video() {
        if (this.videoId == null || this.videoId.isEmpty()) {
            this.videoId = UUID.randomUUID().toString();
        }
        this.ratings = new ArrayList<>(); // Khởi tạo danh sách ratings
        this.likes = new ArrayList<>(); // Khởi tạo danh sách likes
    }

    // Các phương thức getter và setter

    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public String getVideoPath() {
        return videoPath;
    }

    public void setVideoPath(String videoPart) {
        this.videoPath = videoPart;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }
    
    public String getCategoryName() {    
        return category != null ? category.getCategoryname() : null;
    }

	public List<Rating> getRatings() {
		return ratings;
	}

	public void setRatings(List<Rating> ratings) {
		this.ratings = ratings;
	}
	
	public List<Like> getLikes() {
        return likes;
    }

    public void setLikes(List<Like> likes) {
        this.likes = likes;
    }

    // Phương thức đếm số lượng like
    public long getLikesCount() {
        return likes.stream().filter(like -> like.getStatus() == 1).count();
    }
    

    // Phương thức đếm số lượng dislike
    public long getDislikesCount() {
        return likes.stream().filter(like -> like.getStatus() == -1).count();
    }

}
