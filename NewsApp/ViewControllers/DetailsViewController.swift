//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by MacBook Air on 17.01.2022.
//

import UIKit
import AVFoundation
import AVKit

class DetailsViewController: UIViewController {

    var playerViewController = AVPlayerViewController()
    var playerView = AVPlayer()

    @IBOutlet weak var detailsTitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var loadingButton: UIButton!
    @IBOutlet weak var spot: UILabel!

    
    var selectedVideoUrl : String = ""
    var selectedTitle : String?
    var selectedSpot : String?
    var selectedLink : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData(){
        if let selectedSpot = selectedSpot {
            self.spot.text = selectedSpot
        }
        
        if let selectedTitle = selectedTitle {
            self.detailsTitleLabel.text = selectedTitle
        }
        self.playButton.isHidden = true
        self.imageView.backgroundColor = .gray
        self.loadingButton.isHidden = false
       
        if let url = URL(string: "\(selectedVideoUrl.dropLast(14))") {
            self.getthumbnailFromImage(url: url) { (thumbImage) in
                self.imageView.backgroundColor = nil
                self.imageView.image = thumbImage
                self.loadingButton.isHidden = true
                self.playButton.isHidden = false
            }
        } else {
            self.loadingButton.isHidden = true
            self.imageView.backgroundColor = .gray
            self.imageView.image = UIImage(named: "noVideo")
        }
    }
    
    @IBAction func videoPlayActionButton(_ sender: Any) {
        playVideo()
    }
    
    func playVideo(){
        
        let url : URL = URL(string: "\(selectedVideoUrl.dropLast(14))")!
        playerView = AVPlayer(url: url as URL)
        playerViewController.player = playerView
        
        self.present(playerViewController, animated: true) {
            self.playerViewController.player?.play()
        }
    }
    func getthumbnailFromImage(url: URL, completion: @escaping ((_ image: UIImage?)->Void)){
        DispatchQueue.global().async {
            let asset = AVAsset(url: url)
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            avAssetImageGenerator.appliesPreferredTrackTransform = true
            
            let thumbnailTime = CMTimeMake(value: 7, timescale: 1)
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumbnailTime, actualTime: nil)
                let thumbImage = UIImage(cgImage: cgThumbImage)
                
                DispatchQueue.main.async {
                    completion(thumbImage)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func linkButtonClicked(_ sender: Any) {
        if let selectedLink = selectedLink {
            UIApplication.shared.open(URL(string: "\(selectedLink)")!)
        }
      
    }
    
    
}

