import Foundation
import UIKit

struct SongsTest {
    var url: URL?
    var image: UIImage?
    var name: String
    var artist: String
    
    // Initializer to fetch resource URL
    init(resourceName: String, withExtension ext: String, image: UIImage?, name: String, artist: String) {
        if let resourceURL = Bundle.main.url(forResource: resourceName, withExtension: ext), let resourceImage = image {
            self.url = resourceURL
            self.image = resourceImage
            self.name = name
            self.artist = artist
        } else {
            self.url = nil
            self.image = nil
            self.name = ""
            self.artist = ""
        }
    }
}
