//
//  FamousQuoteViewModel.swift
//  ARKitSampleTest
//
//  Created by 鵜沼慶伍 on 2023/11/13.
//

import Foundation

final class FamousQuoteViewModel: ObservableObject {
    @Published var famousQuotes: [FamousQuote] = []
    
    var fqModel: FamousQuoteModel
    
    init(fqModel: FamousQuoteModel) {
        self.fqModel = fqModel
    }
    
    @MainActor
    func fetch() async {
        self.famousQuotes = await fqModel.fetchFamousQuotes()
    }
}
