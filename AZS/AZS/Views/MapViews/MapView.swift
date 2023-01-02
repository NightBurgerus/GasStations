//
//  MapView.swift
//  AZS
//
//  Created by Паша Терехов on 01.01.2023.
//

import SwiftUI
import MapKit

struct MapView: View {
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
                            .contentShape(Rectangle())
                            .onTapGesture {
                                
                                    showDetails = true
                            }
                    }
                }.edgesIgnoringSafeArea(.top)
            }
            
            if showsUserLocationWarning {
                VStack {
                    MapLocationRequest().padding(.top, 10)
                    Spacer()
                }
            }
        }
        .onAppear {
            configureView()
        }
    }
    
    private func configureView() {
        configureLocation()
        showsMap = true
        
        // 56.119708, 40.364791
        // 56.119736, 40.364773
        var point = GasStation(id: UUID(), address: "", latitude: 56.119736, longitude: 40.364773, phone: "+7 (905) 616-3669", gasoline: Gasoline(price: [:]), images: [])
        gasStations.append(point)
    }
    
    private func configureLocation() {
        
        let defaultRegionCenter = CLLocationCoordinate2D(latitude: 56.127459, longitude: 40.397060)
        let defaultRegionSpan   = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let defaultRegion = MKCoordinateRegion(center: defaultRegionCenter, span: defaultRegionSpan)
        region = defaultRegion
    }
}
