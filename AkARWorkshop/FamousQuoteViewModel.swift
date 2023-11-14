//
//  FamousQuoteViewModel.swift
//  ARKitSampleTest
//
//  Created by 鵜沼慶伍 on 2023/11/13.
//

import Foundation

final class FamousQuoteViewModel: ObservableObject {
    @Published var famousQuotes: [FamousQuote] = []
    
    var apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    @MainActor
    func fetch() async {
        self.famousQuotes = await apiClient.fetchFamousQuotes()
    }
}
