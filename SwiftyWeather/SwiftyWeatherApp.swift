//
//  SwiftyWeatherApp.swift
//  SwiftyWeather
//
//  Created by Don Ferruggia on 8/11/25.
//

import SwiftUI

@main
struct SwiftyWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView()
                .modelContainer(for: Preference.self)
        }
    }
}
