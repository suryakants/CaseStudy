import Foundation
import CoreLocation

class RequestCreator {
    
    class func createRequest(with urlString: String) -> URLRequest? {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            return request
        }
        return nil
    }
}
