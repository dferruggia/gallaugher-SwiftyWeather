//
//  PreferenceView.swift
//  SwiftyWeather
//
//  Created by Don Ferruggia on 8/15/25.
//

import SwiftUI

struct PreferenceView: View {
    
    @State var locationName = ""
    @State var latString = ""
    @State var longString = ""
    @State var selectedUnit: UnitSystem = .imperial
    @State var degreeSymbolShowing = true
    
    private var degreeUnit: String {
        if degreeSymbolShowing {
            selectedUnit == .imperial ? "F" : "C"
        } else {
            ""
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                TextField("location", text: $locationName)
                    .textFieldStyle(.roundedBorder)
                    .font(.title)
                    .padding()
                    .padding(.bottom)
                
                Group {
                    Text("Latitude:")
                        .fontWeight(.bold)
                    TextField("latitude", text: $latString)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    Text("Longitude:")
                        .fontWeight(.bold)
                    TextField("longitude", text: $longString)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .padding(.bottom)
                }
                .font(.title2)
                
                HStack {
                    Text("Units:")
                        .fontWeight(.bold)
                    Spacer()
                    Picker("", selection: $selectedUnit) {
                        ForEach(UnitSystem.allCases, id: \.self) { unit in
                            Text(unit.rawValue.capitalized)
                        }
                    }
                    .padding(.bottom)
                }
                .font(.title2)
                
                Toggle(isOn: $degreeSymbolShowing) {
                    Text("Show F/C after temp value:")
                }
                .font(.title2)
                .bold()
                
                HStack {
                    Spacer()
                    Text("42°\(degreeUnit)")
                    Spacer()
                }
                .font(.system(size: 150))
                .fontWeight(.thin)

                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        //TODO:
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        //TODO:
                    } label: {
                        Text("Save")
                    }
                    
                }
            }

        }
    }
    
    
}

#Preview {
    PreferenceView()
}
