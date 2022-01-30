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
        return self.newsList.news.first?.category
    }
    var title : String? {
        return self.newsList.news.first?.title
    }
    var spot : String?  {
        return self.newsList.news.first?.spot
    }
    var imageUrl : String? {
        return self.newsList.news.first?.imageUrl
    }
    var videoUrl : String? {
        return self.newsList.news.first?.videoUrl
    }
    var webUrl : String? {
        return self.newsList.news.first?.webUrl
    }
}
