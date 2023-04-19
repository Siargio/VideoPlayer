//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Sergio on 17.04.23.
//

import UIKit
import Kingfisher
import ProgressHUD
import AVKit

class VideoViewController: UIViewController {

    //MARK: - Propetes

    let customView = MainView()
    var videos: [Video] = []
    var manager = VideoManager()

    //MARK: - LifeCycle

    override func loadView() {
        super.loadView()
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        delegateCollectionView()
        addAction()
        getVideos(category: "\( customView.segmentControl.titleForSegment(at: 0)!)")
    }

    override func viewDidAppear(_ animated: Bool) {
        customView.collectionView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        // Enable scrolling based on content height
        customView.collectionView.isScrollEnabled = customView.collectionView.contentSize.height > customView.collectionView.frame.size.height
     }

    //MARK: - Setups

    func addAction() {
        customView.searchButton.addTarget(self, action: #selector(tapButtonSearch), for: .touchUpInside)
        customView.segmentControl.addTarget(self, action: #selector(segmentDidChange(_:)), for: .valueChanged)
    }
    
    @objc func tapButtonSearch() {
        let controller = SearchViewController()
        controller.modalPresentationStyle = .automatic
        if let sheet = controller.presentationController as? UISheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        present(controller, animated: true)
    }

    @objc func segmentDidChange(_ sender: UISegmentedControl) {
        ProgressHUD.show("Search...", icon: .privacy)

        var category = "nature"

        switch sender.selectedSegmentIndex {
        case 0:
            category = "\(sender.titleForSegment(at: 0)!)"
            customView.videoPlayerLabel.text = "Video \(category)"
        case 1:
            category = "\(sender.titleForSegment(at: 1)!)"
            customView.videoPlayerLabel.text = "Video \(category)"
        case 2:
            category = "\(sender.titleForSegment(at: 2)!)"
            customView.videoPlayerLabel.text = "Video \(category)"
        case 3:
            category = "\(sender.titleForSegment(at: 3)!)"
            customView.videoPlayerLabel.text = "Video \(category)"
        case 4:
            category = "\(sender.titleForSegment(at: 4)!)"
            customView.videoPlayerLabel.text = "Video \(category)"
        default:
            category = "nature"
        }

        Task {
            await manager.findVideos(topic:category)
        }
    }

    func delegateCollectionView() {
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
        manager.delegate = self
    }

    func getVideos(category: String) {
        Task {
            await manager.findVideos(topic: category)
        }
    }
}

//MARK: - VideoManagerDelegate

extension VideoViewController: VideoManagerDelegate {
    func showVideos(listOfVideos: [Video]) {
        videos = listOfVideos

        DispatchQueue.main.async {
            self.customView.collectionView.reloadData()
            ProgressHUD.remove()
        }
    }

    func showError(error: String) {
        showAlert(title: "Error", message: error)
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            //Do something
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}

//MARK: - UICollectionViewDelegate

extension VideoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompositionalCell.identifier, for: indexPath) as? CompositionalCell else {
            return UICollectionViewCell()
        }
        if let urlImage = URL(string: videos[indexPath.row].image) {
            cell.imageViewBackground.kf.setImage(with: urlImage)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let defaultVideo = "https://player.vimeo.com/external/342571552.hd.mp4?s=6aa6f164de3812abadff3dde86d19f7a074a8a66&profile_id=175&oauth2_token_id=57447761"

        guard let url = URL(string: "\(videos[indexPath.row].videoFiles.first?.link ?? defaultVideo)") else { return }

        let avPlayer = AVPlayer(url: url)
        let avController = AVPlayerViewController()
        avController.player = avPlayer
        present(avController, animated: true) {
            avPlayer.play()
        }
    }
}
