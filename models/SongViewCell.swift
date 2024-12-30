import UIKit

class SongViewCell: UITableViewCell {
    @IBOutlet weak var numberInList: UILabel!
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var songArtist: UILabel!
    @IBOutlet weak var likedButton: UIButton!
    
    var song: SongsTest?  // To store the current song
    var songIndex: Int?   // To store the index of the song
    
    // A weak reference to the TabBarController to access liked songs
    weak var tabBarController: TabBarController?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set the background color of the cell and content view to clear
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        // Optional: You can also remove the cell's selection style for a cleaner look
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func pressedLike(_ sender: UIButton) {
        guard let song = song else { return }
        
        // Toggle the like status by calling TabBarController's toggle function
        tabBarController?.toggleLikedStatus(for: song)
        
        // Update the like button appearance based on the song's like status
        updateLikeButton()
    }
    
    func configure(with song: SongsTest, number: Int) {
        self.song = song
        self.songIndex = number
        numberInList.text = "\(number + 1)"  // Display number starting from 1
        songImage.image = song.image
        songName.text = song.name
        songArtist.text = song.artist
        
        // Update the like button based on the song's liked status
        updateLikeButton()
    }
    
    func updateLikeButton() {
        guard let song = song else { return }
        
        // Check if the song is in the liked songs list of the TabBarController
        if let tabBarController = tabBarController, tabBarController.likedSongs.contains(where: { $0.name == song.name }) {
            likedButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)  // Liked
        } else {
            likedButton.setImage(UIImage(systemName: "heart"), for: .normal)  // Not liked
        }
    }
}
