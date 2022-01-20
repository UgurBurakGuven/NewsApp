//
//  WebService.swift
//  NewsApp
//
//  Created by MacBook Air on 17.01.2022.
//

import Foundation

class WebService {
    func downloadNews(path: String, completion: @escaping(News?) -> () ){
        guard let apiURL = URL(string: App.baseUrl+path) else { return }
        URLSession.shared.dataTask(with: apiURL) { data,response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                let News = try? JSONDecoder().decode(News.self, from: data)
                if let News = News {
                    completion(News)
                } else {
                    print("ErrorDownloadMovies")
                }
            }
        }.resume()
    }

}
