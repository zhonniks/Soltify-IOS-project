//
//  HomeViewController.swift
//  Soltify
//
//  Created by Альтаир Кабдрахманов on 27.12.2024.
//

import UIKit

class HomeViewController: UIViewController {
    // Local test with music
    var songsTest: [SongsTest] = [
        SongsTest(resourceName: "104-truwer-safari", withExtension: "mp3", image: UIImage(#imageLiteral(resourceName: "104-truwer-safari.jpg")), name: "Сафари", artist: "104 & Truwer"),
        SongsTest(resourceName: "coldplay-hymn", withExtension: "mp3", image: UIImage(#imageLiteral(resourceName: "coldplay-hymn.jpg")), name: "Hymn For The Weekend", artist: "Coldplay"),
        SongsTest(resourceName: "daft-punk-get-lucky", withExtension: "mp3", image: UIImage(#imageLiteral(resourceName: "daft-punk-get-lucky.jpg")), name: "Get Lucky", artist: "Daft Punk"),
        SongsTest(resourceName: "prince-delacure-big-city-life", withExtension: "mp3", image: UIImage(#imageLiteral(resourceName: "prince-delacure-big-city-life.jpeg")), name: "Big City Life", artist: "V $ X V PRiNCE x De Lacure"),
        SongsTest(resourceName: "skrip-718", withExtension: "mp3", image: UIImage(#imageLiteral(resourceName: "skrip-718.png")), name: "Мистер 718", artist: "Скриптонит"),
        SongsTest(resourceName: "skrip-privichka", withExtension: "mp3", image: UIImage(#imageLiteral(resourceName: "skrip-privichka.png")), name: "Привычка (feat. Andy Panda, 104)", artist: "Скриптонит")
    ]
    @IBOutlet weak var songTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songTable.dataSource = self
        songTable.delegate = self
        
        // Make the table view background transparent
        songTable.backgroundColor = .clear
        songTable.backgroundView = nil
        
        // Set background image
        let backgroundImage = UIImage(named: "home") // Replace with your image name
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .topLeft
        imageView.frame = view.bounds
        
        // Add the image view to the view hierarchy
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView) // Send to back so other content appears on top
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songsTest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongViewCell
        
        // Pass the tabBarController reference to the cell
        if let tabBarController = self.tabBarController as? TabBarController {
            cell.tabBarController = tabBarController
        }
        
        cell.configure(with: songsTest[indexPath.row], number: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tabBarController = tabBarController as? TabBarController else { return }
        
        // Pass selected song data to TabBarController
        tabBarController.setSongs(songs: songsTest, startIndex: indexPath.row)
    }
}
