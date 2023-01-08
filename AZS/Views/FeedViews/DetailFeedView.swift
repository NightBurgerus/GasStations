//
//  DetailFeedView.swift
//  AZS
//
//  Created by Паша Терехов on 08.01.2023.
//

import SwiftUI

struct DetailNewsView: View {
    var id: Int
    @EnvironmentObject private var controllers: Controllers
    @State private var feedVM = FeedViewModel()
    @State private var showsToast = false
    @State private var toastMessage = ""
    @State private var data: DetailInfoData? = nil
    
    var body: some View {
        ZStack {
            if let info = data {
                VStack {
                    Label().padding(20)
                    Divider()
                    MainText().padding(20)
                    Spacer()
                }
            }
            
            if showsToast {
                VStack {
                    Spacer()
                    Toast(isShowing: $showsToast, text: toastMessage)
                }
            }
            
            if feedVM.dataIsLoading {
                LoadingScreen()
            }
        }
        .onAppear {
            configureView()
        }
        .onDisappear {
            controllers.setTabBar()
        }
    }
    
    private func configureView() {
        controllers.hideTabBar()
        if data == nil {
            feedVM.getDetailInfo(byId: id) { response in
                switch response {
                case .success(let data):
                    guard let info = (data as? DetailInfoResposne)?.data, data!.response else {
                        toastMessage = Res.strings.feed.loadingError
                        withAnimation {
                            showsToast = true
                        }
                        return
                    }
                    self.data = info
                case .failture(_):
                    toastMessage = Res.strings.feed.loadingError
                    withAnimation {
                        showsToast = true
                    }
                }
            }
        }
    }
    
    private func Label() -> some View {
        BoldText(data!.label, fontSize: .s24)
    }
    
    private func MainText() -> some View {
        HStack {
            RegularText(data!.text, fontSize: .s16)
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
}
