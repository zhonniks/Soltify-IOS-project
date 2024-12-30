import UIKit
import AVFoundation

class TabBarController: UITabBarController {
    // Local test with music
    var songsTest: [SongsTest] = [
        SongsTest(resourceName: "104-truwer-safari", withExtension: "mp3", image: UIImage(#imageLiteral(resourceName: "104-truwer-safari.jpg")), name: "Сафари", artist: "104 & Truwer"),
        SongsTest(resourceName: "coldplay-hymn", withExtension: "mp3", image: UIImage(#imageLiteral(resourceName: "coldplay-hymn.jpg")), name: "Hymn For The Weekend", artist: "Coldplay"),
        SongsTest(resourceName: "daft-punk-get-lucky", withExtension: "mp3", image: UIImage(#imageLiteral(resourceName: "daft-punk-get-lucky.jpg")), name: "Get Lucky", artist: "Daft Punk"),
        SongsTest(resourceName: "prince-delacure-big-city-life", withExtension: "mp3", image: UIImage(#imageLiteral(resourceName: "prince-delacure-big-city-life.jpeg")), name: "Big City Life", artist: "V $ X V PRiNCE x De Lacure"),
        SongsTest(resourceName: "skrip-718", withExtension: "mp3", image: UIImage(#imageLiteral(resourceName: "skrip-718.png")), name: "Мистер 718", artist: "Скриптонит"),
        SongsTest(resourceName: "skrip-privichka", withExtension: "mp3", image: UIImage(#imageLiteral(resourceName: "skrip-privichka.png")), name: "Привычка (feat. Andy Panda, 104)", artist: "Скриптонит")
    ]
    var likedSongs: [SongsTest] = []
    
    // AVPlayer
    private var player: AVPlayer?
    
    // Current song index
    private var currentSongIndex = 0
    
    // UI Components
    private let customView = UIView()
    private let songImage = UIImageView()
    private let artistLabel = UILabel()
    private let nameLabel = UILabel()
    private let prevButton = UIButton()
    private let playPauseButton = UIButton()
    private let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomView()
        setupPlayerControls()
        setupInitialSong()
        
        // Add observer for song completion
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(songDidFinishPlaying),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: nil)
    }

    deinit {
        // Remove observers to prevent memory leaks
        NotificationCenter.default.removeObserver(self)
    }
    
    // Initialize the first song in the player
    private func setupInitialSong() {
        updateMiniPlayer(with: songsTest[currentSongIndex])
    }

    // Setup custom mini-player view
    private func setupCustomView() {
        customView.backgroundColor = .black
        customView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(customView, aboveSubview: tabBar)
        
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            customView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -100),
            customView.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -20)
        ])
    }

    // Setup player controls inside the customView
    private func setupPlayerControls() {
        // Configure and add components
        songImage.contentMode = .scaleAspectFill
        songImage.clipsToBounds = true
        songImage.translatesAutoresizingMaskIntoConstraints = false
        
        artistLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        artistLabel.textColor = .white
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        prevButton.setImage(UIImage(systemName: "backward.end", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30.0)), for: .normal)
        prevButton.tintColor = .white
        prevButton.addTarget(self, action: #selector(playPrev), for: .touchUpInside)
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        
        playPauseButton.setImage(UIImage(systemName: "play.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 45.0)), for: .normal)
        playPauseButton.setImage(UIImage(systemName: "pause.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 45.0)), for: .selected)
        playPauseButton.tintColor = .white
        playPauseButton.addTarget(self, action: #selector(togglePlayPause), for: .touchUpInside)
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton.setImage(UIImage(systemName: "forward.end", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30.0)), for: .normal)
        nextButton.tintColor = .white
        nextButton.addTarget(self, action: #selector(playNext), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(songImage)
        customView.addSubview(artistLabel)
        customView.addSubview(nameLabel)
        customView.addSubview(prevButton)
        customView.addSubview(playPauseButton)
        customView.addSubview(nextButton)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            songImage.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
            songImage.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 20),
            songImage.widthAnchor.constraint(equalToConstant: 60),
            songImage.heightAnchor.constraint(equalToConstant: 60),
            
            artistLabel.topAnchor.constraint(equalTo: songImage.topAnchor),
            artistLabel.leadingAnchor.constraint(equalTo: songImage.trailingAnchor, constant: 12),
            artistLabel.trailingAnchor.constraint(lessThanOrEqualTo: prevButton.leadingAnchor, constant: -12),
            
            nameLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: artistLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: artistLabel.trailingAnchor),
            
            prevButton.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
            prevButton.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -120),
            
            playPauseButton.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
            playPauseButton.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -58),
            
            nextButton.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
            nextButton.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -20)
        ])
    }
    
    // Set songs and play the selected one
    func setSongs(songs: [SongsTest], startIndex: Int) {
        self.songsTest = songs
        self.currentSongIndex = startIndex
        playSong(at: startIndex)
    }
    
    // Function to add or remove songs from the liked list
    func toggleLikedStatus(for song: SongsTest) {
        if likedSongs.contains(where: { $0.name == song.name }) {
            // Song is already liked, remove it
            likedSongs.removeAll { $0.name == song.name }
        } else {
            // Song is not liked, add it
            likedSongs.append(song)
        }
    }

    // Update the mini-player UI with the current song
    private func updateMiniPlayer(with song: SongsTest) {
        songImage.image = song.image ?? UIImage(named: "placeholder")
        artistLabel.text = song.artist
        nameLabel.text = song.name
    }

    // Toggle play/pause
    @objc private func togglePlayPause() {
        playPauseButton.isSelected.toggle()
        
        if playPauseButton.isSelected {
            if player == nil {
                playSong(at: currentSongIndex)
            } else {
                player?.play()
            }
        } else {
            player?.pause()
        }
    }

    // Play the previous track
    @objc private func playPrev() {
        currentSongIndex = (currentSongIndex == 0) ? songsTest.count - 1 : currentSongIndex - 1
        playSong(at: currentSongIndex)
    }

    // Play the next track
    @objc private func playNext() {
        currentSongIndex = (currentSongIndex == songsTest.count - 1) ? 0 : currentSongIndex + 1
        playSong(at: currentSongIndex)
    }

    // Play a song by index
    private func playSong(at index: Int) {
        guard index < songsTest.count, let songURL = songsTest[index].url else {
            print("Error: Invalid song index or URL")
            return
        }
        
        // Update player and mini-player UI
        player = AVPlayer(url: songURL)
        player?.play()
        playPauseButton.isSelected = true
        updateMiniPlayer(with: songsTest[index])
    }

    // Handle when a song finishes playing
    @objc private func songDidFinishPlaying(notification: Notification) {
        playNext()
    }
}
