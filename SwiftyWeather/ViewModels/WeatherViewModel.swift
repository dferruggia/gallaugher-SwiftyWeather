//
//  WeatherViewModel.swift
//  SwiftyWeather
//
//  Created by Don Ferruggia on 8/12/25.
//

import Foundation

@Observable
final class WeatherViewModel {
    var urlString: String = "https://api.open-meteo.com/v1/forecast?latitude=42.33467401570891&longitude=-71.17007347605109&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m&hourly=uv_index&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum&temperature_unit=fahrenheit&wind_speed_unit=mph&precipitation_unit=inch&timezone=auto"
    
    var temperature = 0.0
    var feelsLike = 0.0
    var windspeed = 0.0
    var weatherCode = 0
    
    func getData() async {
        guard let url = URL(string: urlString) else {
            print("😡 Could not create a URL from urlString '\(urlString)'")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let returned = try? JSONDecoder().decode(Weather.self, from: data) else {
                print("😡 Could not decode JSON data fromc URL '\(urlString)'")
                return
            }

            Task { @MainActor in
                temperature = returned.current.temperature_2m
                feelsLike = returned.current.apparent_temperature
                windspeed = returned.current.wind_speed_10m
                weatherCode = returned.current.weather_code
            }
        } catch {
            print("😡 Could not retrieve data fromc URL '\(urlString)'")
            return
        }
    }
}
