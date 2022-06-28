import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) -> UIImage {
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                return image
            }
        }
        return UIImage()
    }
}
