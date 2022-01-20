//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by MacBook Air on 17.01.2022.
//

import Foundation

struct NewsListViewModel {
    let newsList : News
    
    func numberOfRowsInSection() -> Int {
        return newsList.news.count
    }
}

struct NewsViewModel {
    
    let newsList : News
    
    var category : String?
    {
        return self.newsList.news[0].category
    }
    var title : String? {
        return self.newsList.news[0].title
    }
    var spot : String?  {
        return self.newsList.news[0].spot
    }
    var imageUrl : String? {
        return self.newsList.news[0].imageUrl
    }
    var videoUrl : String? {
        return self.newsList.news[0].videoUrl
    }
    var webUrl : String? {
        return self.newsList.news[0].webUrl
    }
}
