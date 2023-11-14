//
//  FamousQuoteModel.swift
//  ARKitSampleTest
//
//  Created by 鵜沼慶伍 on 2023/11/13.
//

import Foundation

struct FamousQuote: Decodable {
    var meigen: String
    var auther: String
}

final class APIClient {
    
    func fetchFamousQuotes() async -> [FamousQuote] {
        let url = URL(string: "https://meigen.doodlenote.net/api/json.php")!
        let decoder = JSONDecoder()
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let famousQuotes = try decoder.decode([FamousQuote].self, from: data)
            return famousQuotes
        } catch {
            print("Error: \(error)")
            return []
        }
    }
}
