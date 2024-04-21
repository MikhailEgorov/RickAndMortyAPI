//
//  CharacterImageView.swift
//  RickAndMortyAPI
//
//  Created by Mikhail Egorov on 18.03.2023.
//


import UIKit

class CharacterImageView: UIImageView {
    
    func fetchImage(from url: String) {
        guard let url = URL(string: url) else {
            image = #imageLiteral(resourceName: "Picture.png")
            return
        }
        
        // select pic from cache, if it is there
        if let cachedImage = getCachedImage(from: url) {
            image = cachedImage
            return
        }
        
        // else, downolad pic from web
        ImageManager.shared.fetchImageCach(from: url) { data, response in
        // set data to image
            self.image = UIImage(data: data)
            //save data to cache
            self.saveDataToCache(with: data, and: response)
        }
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        //create ID cacheObject for find cacheObject
        let request = URLRequest(url: url)
        //create cacheObject that contains data and response from server
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    //get image from cache
    private func getCachedImage(from url: URL) -> UIImage? {
        // create request for find image in cache
        let request = URLRequest(url: url)
        // find cacheObject
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}
