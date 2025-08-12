//
//  WeatherView.swift
//  SwiftyWeather
//
//  Created by Don Ferruggia on 8/11/25.
//

import SwiftUI

struct WeatherView: View {
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

                        Text("42°F")
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
            }
        }
    }
}

#Preview {
    WeatherView()
}
