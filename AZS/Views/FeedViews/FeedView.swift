//
//  FeedView.swift
//  AZS
//
//  Created by Паша Терехов on 01.01.2023.
//

import SwiftUI

struct FeedView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var controllers: Controllers
    @State private var news: [FeedData] = []
    @State private var selectedNewsId = -1
    @State private var action: Int? = nil
    @StateObject private var feedVM = FeedViewModel()
    @State private var showsToast = false
    @State private var toastMessage = ""
    
    var body: some View {
        CustomNavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    HStack {
                        BoldText(Res.strings.feed.title, fontSize: .s24).padding(10)
                        Spacer()
                    }
                    Shadow()
                    
                    ScrollView(showsIndicators: false) {
                        VStack (spacing: 0) {
                            ForEach(news, id: \.self) { new in
                                Divider()
                                NewsRow(news: new).padding(.horizontal, 10)
                                Divider()
                            }
                        }
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
                
                NavigationLink(destination: DetailNewsView(id: selectedNewsId), tag: 1, selection: $action) {}
                
            }
            .introspectNavigationController({ navigationController in
                guard let nc = navigationController else {
                    return
                }
                nc.navigationBar.isHidden = true
            })
            .onAppear {
                configureView()
            }
        }
    }
    
    private func configureView() {
        action = nil
        if news.isEmpty {
            feedVM.getInfo { response in
                switch response {
                case .success(let data):
                    guard let info = (data as? FeedResponse)?.data, data!.response else {
                        toastMessage = Res.strings.feed.loadingError
                        withAnimation {
                            showsToast = true
                        }
                        return
                    }
                    self.news = info
                case .failture(_):
                    toastMessage = Res.strings.feed.loadingError
                    withAnimation {
                        showsToast = true
                    }
                }
            }
        }
    }
    
    private func NewsRow(news: FeedData) -> some View {
        HStack {
            if colorScheme == .dark {
                Res.images.gasPistolWhite.frame(width: 30, height: 30)
            } else {
                Res.images.gasPistolBlack.frame(width: 30, height: 30)
            }
            Text(news.text)
            Spacer()
        }
        .frame(height: 50)
        .contentShape(Rectangle())
        .onTapGesture {
            self.selectedNewsId = news.id
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                action = 1
            }
        }
    }
    
    private func Shadow() -> some View {
        Rectangle()
            .fill(Res.colors.white)
            .frame(height: 1)
            .shadow(color: colorScheme == .light ? Res.colors.black : Res.colors.white, radius: 5, x: 0, y: 0)
            .overlay(Rectangle().fill(colorScheme == .light ? Res.colors.white : Color.black).frame(height: 10).offset(y: -5))
    }
}
