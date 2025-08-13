//
//  Weather.swift
//  SwiftyWeather
//
//  Created by Don Ferruggia on 8/12/25.
//

import Foundation

struct Weather: Codable {
    var current: Current
    var daily: Daily
}

struct Current: Codable {
    var temperature_2m: Double
    var apparent_temperature: Double
    var weather_code: Int
    var wind_speed_10m: Double
}

struct Daily: Codable {
    var time: [String]
    var weather_code: [Int]
    var temperature_2m_max: [Double]
    var temperature_2m_min: [Double]
}
