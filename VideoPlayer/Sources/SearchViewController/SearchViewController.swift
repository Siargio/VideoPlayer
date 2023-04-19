//
//  SearchViewController.swift
//  VideoPlayer
//
//  Created by Sergio on 18.04.23.
//

import UIKit
import ProgressHUD

class SearchViewController: UIViewController {

    //MARK: - Propetes

    private let customView = BottomView()
    var manager = VideoManager()
    var categoryToSearch: String = ""

    //MARK: - LifeCycle

    override func loadView() {
        super.loadView()
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegateCollectionView()
        addAction()
    }

    //MARK: - Setups

    func addAction() {
        customView.searchButton.addTarget(self, action: #selector(tapButtonSearch), for: .touchUpInside)
    }

    @objc func tapButtonSearch() {
        search()
    }

    private func search() {

        if customView.searchTextField.text == "" {
            showAlert(title: "Введите данные", message: "")
        } else {
            ProgressHUD.show("Search...", icon: .privacy)
            guard let category = customView.searchTextField.text?.replacingOccurrences(of: " ", with: "") else { return }

            Task {
                await manager.findVideos(topic: category)
            }
        }
    }

    func delegateCollectionView() {
        manager.delegate = self
        customView.searchTextField.delegate = self
    }
}

//MARK: - VideoManagerDelegate

extension SearchViewController: VideoManagerDelegate {
    func showError(error: String) {
        DispatchQueue.main.async {
            self.showAlert(title: "Error", message: error)
        }
    }

    func showVideos(listOfVideos: [Video]) {
        DispatchQueue.main.async {
            ProgressHUD.remove()

            if let vc = self.presentingViewController as? VideoViewController {
                self.dismiss(animated: true) {
                    vc.videos = listOfVideos
                    vc.customView.videoPlayerLabel.text = "Video \(self.categoryToSearch)"
                    DispatchQueue.main.async {
                        vc.customView.collectionView.reloadData()
                    }
                }
            }
        }
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

//MARK: UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Hacer algo ")
        textField.endEditing(true)
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        search()
        textField.text = ""
        textField.endEditing(true)
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            categoryToSearch = textField.text!
            return true
        } else {
            textField.placeholder = "Escribe una categoria..."
            categoryToSearch = ""
            return false
        }
    }
}
