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
                VStack(spacing: 0) {
                    Image(systemName: viewModel.getWeatherIcon(for: viewModel.weatherCode))
                        .symbolRenderingMode(.multicolor)
                         .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .foregroundStyle(.white)
                    
                    VStack {
                        Text(viewModel.getWeatherDescription(for: viewModel.weatherCode))
                            .font(.largeTitle)
                            .foregroundStyle(.white)

                        Text("\(Int(round(viewModel.temperature)))°F")
                            .font(.system(size: 150, weight: .thin))
                            .foregroundStyle(.white)
                        
                        Text("Wind \(Int(round(viewModel.windspeed)))mph, feels like \(Int(round(viewModel.feelsLike)))°F")
                            .padding(.bottom)
                            .foregroundStyle(.white)
                        
                        List {
                            ForEach(0..<viewModel.dailyWeatherCode.count, id: \.self) { index in
                                HStack(alignment: .top) {
                                    Image(systemName: viewModel.getWeatherIcon(for: viewModel.dailyWeatherCode[index]))
                                    Text("\(viewModel.getWeekDay(for: index))")
                                        .font(.title2)
                                    Spacer()
                                    Text("\(Int(viewModel.dailyLowTemp[index]))°F")
                                        .font(.title2)
                                    Text("/")
                                        .font(.title2)
                                    Text("\(Int(viewModel.dailyHighTemp[index]))°F").bold()
                                        .font(.title)
                                }
                                
                            }
                            .listRowBackground(Color.clear)
                            .foregroundStyle(.white)

                        }
                        .listStyle(.plain)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            //TODO:
                        } label: {
                            Image(systemName: "gear")
                                .foregroundStyle(.white)
                        }
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
