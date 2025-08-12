//
//  WeatherView.swift
//  SwiftyWeather
//
//  Created by Don Ferruggia on 8/11/25.
//

import SwiftUI

struct WeatherView: View {
    @State private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.cyan.opacity(0.75)
                    .ignoresSafeArea()
                VStack {
                    Image(systemName: "cloud.sun.rain.fill")
                        .symbolRenderingMode(.multicolor)
                         .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                    
                    VStack {
                        Text("Wild Weather")
                            .font(.largeTitle)

                        Text("\(viewModel.temperature)°F")
                            .font(.system(size: 150, weight: .thin))
                        
                        Text("Wind 10mph, feels like 36°F")
                            .padding(.bottom)
                    }
                    .foregroundStyle(.white)
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Image(systemName: "gear")
                            .foregroundStyle(.white)
                    }
                }
                .task {
                    await viewModel.getData()
                    
                }
            }
        }
    }
}

#Preview {
    WeatherView()
}
