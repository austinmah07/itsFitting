import Foundation

class QuoteService {

    func fetchQuote(completion: @escaping (Quote?) -> Void) {

        guard let url = URL(string: "https://zenquotes.io/api/random") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                print("Error:", error)
                completion(nil)
                return
            }

            guard let data = data else {
                completion(nil)
                return
            }

            let decoded = try? JSONDecoder().decode([Quote].self, from: data)

            completion(decoded?.first)

        }.resume()
    }
}

//
//  QuoteService.swift
//  itsFitting
//
//  Created by Austin Mah on 2026-03-07.
//

