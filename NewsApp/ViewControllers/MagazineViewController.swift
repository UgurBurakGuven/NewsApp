//
//  MagazineViewController.swift
//  NewsApp
//
//  Created by MacBook Air on 21.01.2022.
//

import UIKit

class MagazineViewController: UIViewController {

    private var newsListViewModel : NewsListViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    var newsArray : [NewsDetail]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "HeadlineTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        getData()
    }
    
    func getData() {
            WebService().downloadNews(path: App.magazinePath) { News in
                if let News = News {
                    self.newsListViewModel = NewsListViewModel(newsList: News)
                    DispatchQueue.main.async {
                        if let newsListViewModel = self.newsListViewModel {
                            for counter in 0..<newsListViewModel.numberOfRowsInSection(){
                                self.newsArray?.append(NewsDetail(category: newsListViewModel.newsList.news[counter].category, title: newsListViewModel.newsList.news[counter].title, spot: newsListViewModel.newsList.news[counter].spot, imageUrl: newsListViewModel.newsList.news[counter].imageUrl, videoUrl: newsListViewModel.newsList.news[counter].videoUrl, webUrl: newsListViewModel.newsList.news[counter].webUrl))
                            }
                        }
                        self.tableView.reloadData()
                    }
                   
                }
           
            }
       
    }

}

//MARK: UITableViewDelegate, UITableViewDataSource

extension MagazineViewController :  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsArray?.count ?? 0
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell {
       
            if let title = self.newsArray?[indexPath.row].title {
                cell.titleLabel.text = title
            }
            
            if let urlString = URL(string: String(self.newsArray?[indexPath.row].imageUrl ?? "")){
                DispatchQueue.global().async {
                    cell.headlineImageView.kf.setImage(with: urlString)
                }
            }
       
            return cell
        }
          
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "toDetailsVC") as! DetailsViewController
        detailVC.selectedTitle = self.newsArray?[indexPath.row].title ?? ""
        detailVC.selectedVideoUrl = self.newsArray?[indexPath.row].videoUrl ?? ""
        detailVC.selectedSpot = self.newsArray?[indexPath.row].spot ?? ""
        detailVC.selectedLink = self.newsArray?[indexPath.row].webUrl ?? ""
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.5
        
        UIView.animate(withDuration: 0.2){
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
}



