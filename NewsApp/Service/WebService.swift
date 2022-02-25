//
//  WebService.swift
//  NewsApp
//
//  Created by MacBook Air on 17.01.2022.
//

import Foundation
import Moya

enum MyService {
    case getHeader
    case getSport
    case getMagazine
    case getEconomy
    case getPolicy

}

extension MyService: TargetType {
 
    var baseURL: URL {
        return URL(string: App.baseUrl)!
       }
    
    var path: String {
        switch self {
        case .getHeader:
            return App.baseTypeUrl + App.headlinesPath + App.userId
        case .getSport:
            return App.baseTypeUrl + App.sporPath + App.userId
        case .getMagazine:
            return App.baseTypeUrl + App.magazinePath + App.userId
        case .getEconomy:
            return App.baseTypeUrl + App.economyPath + App.userId
        case .getPolicy:
            return App.baseTypeUrl + App.policyPath + App.userId
        }
        
    }
    var method: Moya.Method {
        return .get
    }
    var parameters : [String: Any]? {
        return nil
    }
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        return .requestPlain
    }
    var headers: [String : String]? { nil }
   
}



