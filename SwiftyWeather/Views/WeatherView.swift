//
//  WeatherView.swift
//  SwiftyWeather
//
//  Created by Don Ferruggia on 8/11/25.
//

import SwiftUI
import SwiftData

struct WeatherView: View {
    @State private var viewModel = WeatherViewModel()
    @State private var showPreferenceView = false
    @State private var degreeSymbol = "°F"
    @State private var windSpeedUnit: String = "mph"
    @Environment(\.modelContext) private var modelContext
    @Query var preferences: [Preference] = []
    
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

                        Text("\(Int(round(viewModel.temperature)))\(degreeSymbol)")
                            .font(.system(size: 150, weight: .thin))
                            .foregroundStyle(.white)
                        
                        Text("Wind \(Int(round(viewModel.windspeed)))\(windSpeedUnit), feels like \(Int(round(viewModel.feelsLike)))\(degreeSymbol)")
                            .padding(.bottom)
                            .foregroundStyle(.white)
                        
                        List {
                            ForEach(0..<viewModel.dailyWeatherCode.count, id: \.self) { index in
                                HStack(alignment: .top) {
                                    Image(systemName: viewModel.getWeatherIcon(for: viewModel.dailyWeatherCode[index]))
                                    Text("\(viewModel.getWeekDay(for: index))")
                                        .font(.title2)
                                    Spacer()
                                    Text("\(Int(viewModel.dailyLowTemp[index]))\(degreeSymbol)")
                                        .font(.title2)
                                    Text("/")
                                        .font(.title2)
                                    Text("\(Int(viewModel.dailyHighTemp[index]))\(degreeSymbol)").bold()
                                        .font(.title)
                                }
                                
                            }
                            .listRowBackground(Color.clear)
                            .foregroundStyle(.white)

                        }
                        .listStyle(.plain)
                    }
                }
                .sheet(isPresented: $showPreferenceView, content: {
                    PreferenceView()
                }) // end .sheet
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showPreferenceView.toggle()
                        } label: {
                            Image(systemName: "gear")
                                .foregroundStyle(.white)
                        }
                    }
                }
                .onChange(of: preferences) {
                    Task {
                        await callWeatherAPI()
                    }
                }
                .task {
                    await callWeatherAPI()
                }
            }
        }
    }
    
    private func callWeatherAPI() async {
        if preferences.isEmpty {
            await viewModel.getData()
        } else {
            if preferences[0].degreeUnitShowing {
                degreeSymbol = preferences[0].selectedUnit == .imperial ? "°F" : "°C"
            } else {
                degreeSymbol = "°"
            }
            windSpeedUnit = preferences[0].selectedUnit == .imperial ? "mph" : "kmh"
            await viewModel.getData(latitude: preferences[0].latString, longitude: preferences[0].longString, temperatureUnit: preferences[0].selectedUnit == .imperial ? "fahrenheit" : "celsius", windSpeedUnit: windSpeedUnit)
        }
    }
}

#Preview {
    WeatherView()
        .modelContainer(Preference.preview)
}
