//
//  VideoManager.swift
//  VideoPlayer
//
//  Created by Raman Tank on 03/10/24.
//

// Replace the API KEY from the Pexels

import Foundation

enum Query: String, CaseIterable {
    case nature, animals, people, food, travel
}

class VideoManager: ObservableObject{
    @Published private(set) var videos: [Video] = []
    @Published var selectedQuery: Query = Query.food {
        didSet {
            Task.init {
                await findVideos(topic: selectedQuery)
            }
        }
    }
    
    init() {
        Task.init {
            await findVideos(topic: selectedQuery)
        }
    }
    
    func findVideos(topic: Query) async {
        do {
            guard let url = URL(string: "https://api.pexels.com/videos/search?query=\(topic)&per_page=10&orientation=portrait") else {fatalError("Mission url")}
            
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("YOURAPIKEY", forHTTPHeaderField: "Authorization")
            
            let(data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard response.url! == url else {fatalError("Response url doesn't match the request url")}
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error while fetching data")}
            
            let decoder = JSONDecoder()
            
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedData = try decoder.decode(ResponseBody.self, from: data)
            
            DispatchQueue.main.async {
                
                self.videos = []
                self.videos = decodedData.videos
                
            }
            
        } catch {
            print("Error while fetching the videos : \(error)")
        }
        
    }
}

