//
//  NetworkService.swift
//  VideoPlayer
//
//  Created by Sergio on 18.04.23.
//

import Foundation

protocol VideoManagerDelegate{
    func showVideos(listOfVideos: [Video])
    func showError(error: String)
}

struct VideoManager {

    var delegate: VideoManagerDelegate?

    func findVideos(topic: String) async {
        do {
            guard let url = URL(
                string: "https://api.pexels.com/videos/search?query=\(topic)&locale=es-ES&per_page=80&orientation=portrait") else {
                print("Error al search videos")
                delegate?.showError(error: "Error")
                return
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("1tdfoPtrGNI02OzqgaxkGyibkJ1KAk9agmGU1rCqZAPjAEwFWH4RdECh", forHTTPHeaderField: "Authorization")
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                fatalError("Error fetching data")
            }

            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(ResponseBody.self, from: data)

            let listOfVideos = decodedData.videos
            delegate?.showVideos(listOfVideos: listOfVideos)

        } catch {
            print("Debug: error \(error.localizedDescription)")
        }
    }
}
