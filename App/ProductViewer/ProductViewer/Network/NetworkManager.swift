import Foundation

class NetworkManager: NSObject {
    
    typealias CompletionHandler = ((Result<Data, NetworkError>) -> Void)
    
    private let session: URLSessionProtocol
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    override init() {
        self.session = URLSession.shared
    }
    
    func fetchData(request: URLRequest, completionHandler: @escaping CompletionHandler) {
        
        //check network reachablity, if network not available, call completionHandler with proper error & return
        //if device is not connected with network.
        if !ReachabilityManager.sharedInstance.isNetworkWorking {
            completionHandler(.failure(.noNetwork))
            return
        }
        let task = self.session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
                else {
                    completionHandler(.failure(.noData))
                    return
            }
            if error == nil && self.isSuccessCode(httpResponse) {
                completionHandler(.success(receivedData))
            }
            else {
                completionHandler(.failure(.unknown))
            }
        }
        task.resume()
    }
    
    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode == NetworkConstant.ErrorCode.httpOk
    }
    
    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }
}
