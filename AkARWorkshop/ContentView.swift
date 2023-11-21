//
//  ContentView.swift
//  ARKitSampleTest
//
//  Created by 鵜沼慶伍 on 2023/11/12.
//

import SwiftUI

struct ContentView : View {
    @StateObject var viewModel = FamousQuoteViewModel(fqModel: FamousQuoteModel())
    
    var body: some View {
        ARViewContainer(viewModel: viewModel).edgesIgnoringSafeArea(.all)
    }
}
