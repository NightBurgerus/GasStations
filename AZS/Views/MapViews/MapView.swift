//
//  MapView.swift
//  AZS
//
//  Created by Паша Терехов on 01.01.2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject private var controllers: Controllers
    @Environment(\.colorScheme) private var colorScheme
    @State private var region = MKCoordinateRegion()
    @State private var gasStations = [GasStation]()
    @State private var showsUserLocationWarning = false
    @State private var showsMap = false
    @State private var showDetails = false
    
    var body: some View {
        ZStack {
            if showsMap {
                Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: gasStations) { gasStation in
                    MapAnnotation(coordinate: gasStation.coordinate) {
                        GasStationView()
                            .onTapGesture {
                                if controllers.tabBarController?.tabBar.isHidden ?? false {
                                    controllers.setTabBar()
                                } else {
                                    controllers.hideTabBar()
                                }
                                DispatchQueue.global().asyncAfter(deadline: .now() + controllers.animationDuration) {
                                    withAnimation(.easeInOut(duration: controllers.animationDuration)) {
                                        showDetails = true
                                    }
                                }
                            }
                    }
                }.ignoresSafeArea()
            }
            
            if showsUserLocationWarning {
                VStack {
                    MapLocationRequest().padding(.top, 10)
                    Spacer()
                }
            }
            
            if showDetails {
                GasStationDetails(isShowing: $showDetails, gasStation: gasStations.first!)
            }
        }
        .onAppear {
            configureView()
        }
        .onChange(of: colorScheme) { _ in
            if showDetails {
                withAnimation(.easeInOut(duration: controllers.animationDuration)){
                    showDetails = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + controllers.animationDuration) {
                    withAnimation(.easeInOut(duration: controllers.animationDuration)) {
                        showDetails = true
                    }
                }
            }
        }
    }
    
    private func configureView() {
        configureLocation()
        showsMap = true
        
        // 56.119708, 40.364791
        // 56.119736, 40.364773
        if !gasStations.isEmpty {
            return
        }
        let price = ["АИ-92": 45.0, "АИ-95": 50.0, "АИ-95 евро": 51.0, "Дизель": 55.0, "Дизель евро": 60.5]
        var point = GasStation(id: 1, address: "Улица Пушкина, дом Колотушкина", latitude: 56.119736, longitude: 40.364773, phone: "+7 (905) 616-3669", gasoline: Gasoline(price: price))
        gasStations.append(point)
    }
    
    private func configureLocation() {
        
        let defaultRegionCenter = CLLocationCoordinate2D(latitude: 56.127459, longitude: 40.397060)
        let defaultRegionSpan   = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let defaultRegion = MKCoordinateRegion(center: defaultRegionCenter, span: defaultRegionSpan)
        region = defaultRegion
    }
}

struct GasStationDetails: View {
    @Binding var isShowing: Bool
    var gasStation: GasStation
    
    @EnvironmentObject private var controllers: Controllers
    @State private var showing: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(showing ? 0.5 : 0).contentShape(Rectangle()).onTapGesture {
                withAnimation(.easeInOut(duration: controllers.animationDuration)) {
                    showing = false
                }
            }
            VStack {
                Spacer()
                GasStationInfo(isShowing: $showing, gasStation: gasStation)
            }
        }
        .onChange(of: showing) { value in
            if !value {
                DispatchQueue.main.asyncAfter(deadline: .now() + controllers.animationDuration) {
                    isShowing = false
                    controllers.setTabBar()
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            showing = isShowing
        }
    }
}

struct GasStationInfo: View {
    @Binding var isShowing: Bool
    var gasStation: GasStation
    
    @State private var showing = false
    @State private var contentHeight: CGFloat = 50
    @State private var contentOffset: CGFloat = 0
    @State private var backgroundColor = Res.colors.white
    @State private var foregroundColor = Res.colors.black
    @EnvironmentObject private var controllers: Controllers
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing: 0) {
            DraggingLine()
            VStack {
                // КОНТЕНТ
                Info()
            }
            .background(backgroundColor)
            
        }
        .background(GeometryReader { geo in
            Color.clear.onAppear {
                self.contentHeight = geo.size.height
            }
        })
        .onAppear {
            configureView()
        }
        .onChange(of: isShowing) { value in
            withAnimation(.easeInOut(duration: controllers.animationDuration)) {
                showing = value
            }
        }
        .background(backgroundColor.frame(height: contentOffset != 0.0 ? contentHeight + (-contentOffset) : contentHeight).offset(y: 20 - contentOffset))
        .offset(y: showing ? contentOffset : contentHeight)
        .contentShape(Rectangle())
        .gesture(
            DragGesture()
                .onChanged({ value in
                    withAnimation {
                        if abs(value.location.y - 10) < 40 {
                            self.contentOffset = value.location.y - 10
                        }
                    }
                })
                .onEnded({ value in
                    let offset = value.location.y - 10
                    if offset < 20 {
                        withAnimation {
                            self.contentOffset = 0
                        }
                    } else {
                        withAnimation(.easeInOut(duration: controllers.animationDuration)) {
                            showing = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + controllers.animationDuration) {
                            controllers.setTabBar()
                            isShowing = false
                        }
                    }
                })
        )
    }
    
    private func DraggingLine() -> some View {
        ZStack {
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 10).fill(backgroundColor).frame(height: 15).offset(y: 5)
                Rectangle().fill(backgroundColor).frame(height: 15)
            }
            RoundedRectangle(cornerRadius: 50).fill(foregroundColor).frame(width: 50, height: 5)
        }
        
    }
    
    private func configureView() {
        showing = isShowing
        if colorScheme == .dark {
            foregroundColor = Res.colors.lightGray
            backgroundColor = Res.colors.black
        } else {
            foregroundColor = Res.colors.black
            backgroundColor = Res.colors.white
        }
    }
    
    private func Info() -> some View {
        VStack {
            HStack {
                InfoBoldText16(Res.strings.map.gasStation.label + "\(gasStation.id)")
                Spacer()
            }.padding(.vertical, 10)
            
            // Адрес станции
            HStack {
                    InfoBoldText14(Res.strings.map.gasStation.address)
                InfoRegularText14(gasStation.address)
                Spacer()
            }
            
            // Контактный телефон
            HStack {
                    InfoBoldText14(Res.strings.map.gasStation.phone)
                InfoRegularText14(gasStation.phone)
                Spacer()
            }
            
            HStack {
                    InfoBoldText14(Res.strings.map.gasStation.gasolinePrice)
                Spacer()
            }.padding(.top, 10)
            // Стоимость бензина
            GasolinePrice(price: gasStation.gasoline.price, foregroundColor: foregroundColor, backgournColor: backgroundColor)
            
            Spacer().frame(height: 50)
        }.padding(.horizontal, 20)
    }
    
    private func InfoBoldText14(_ text: String) -> some View {
        Text(text).font(Res.fonts.bold14).foregroundColor(foregroundColor)
    }
    
    private func InfoBoldText16(_ text: String) -> some View {
        Text(text).font(Res.fonts.bold16).foregroundColor(foregroundColor)
    }
    
    private func InfoRegularText14(_ text: String) -> some View {
        Text(text).font(Res.fonts.regular14).foregroundColor(foregroundColor)
    }
    
    private func InfoRegularText16(_ text: String) -> some View {
        Text(text).font(Res.fonts.regular16).foregroundColor(foregroundColor)
    }
    
}

fileprivate struct GasolinePrice: View {
    let price: Dictionary<String, Double>
    let foregroundColor: Color
    let backgournColor:  Color
    
    @State private var maxWordLength = 0
    
    var body: some View {
        VStack {
            ForEach(Array(price.keys).sorted(), id: \.self) { key in
                GasolinePriceRow(mark: String(key), price: price[key]!)
            }
        }
        .onAppear {
            for (key, _) in price {
                if key.count > maxWordLength {
                    maxWordLength = key.count
                }
            }
        }
    }
    
    private func GasolinePriceRow(mark: String, price: Double) -> some View {
        ZStack {
            HStack {
                InfoBoldText14(mark)
                Spacer()
            }
            InfoRegularText14(String(price))
        }
    }
    private func InfoBoldText14(_ text: String) -> some View {
        Text(text).font(Res.fonts.bold14).foregroundColor(foregroundColor)
    }
    
    private func InfoBoldText16(_ text: String) -> some View {
        Text(text).font(Res.fonts.bold16).foregroundColor(foregroundColor)
    }
    
    private func InfoRegularText14(_ text: String) -> some View {
        Text(text).font(Res.fonts.regular14).foregroundColor(foregroundColor)
    }
    
    private func InfoRegularText16(_ text: String) -> some View {
        Text(text).font(Res.fonts.regular16).foregroundColor(foregroundColor)
    }
}
