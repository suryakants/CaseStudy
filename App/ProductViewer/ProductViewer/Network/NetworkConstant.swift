import Foundation

struct NetworkConstant {
    public struct ErrorCode {
        static let httpOk = 200
    }
}

//MARK:- Enums

public enum NetworkError: Error {
    case noData
    case noNetwork
    case invalidSyntax
    case noError
    case invalidData
    case unknown
}

public struct URLConstants {
    static let baseUrl = "https://api.target.com/mobile_case_study_deals/v1"
    static let deals = "/deals"
    static let dealDeatils = "/deals/@"
}

public struct ReachabilityConstant {
    static let networkReachability = -100
    static let errorDomain = "com.target.ProductViewer"
    static let reachabilityChange = "ReachabilityChangedNotification"
}


