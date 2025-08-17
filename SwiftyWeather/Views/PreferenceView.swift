//
//  PreferenceView.swift
//  SwiftyWeather
//
//  Created by Don Ferruggia on 8/15/25.
//

import SwiftUI
import SwiftData

struct PreferenceView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query var preferences: [Preference] = []
    
    @State var locationName = ""
    @State var latString = ""
    @State var longString = ""
    @State var selectedUnit: UnitSystem = .imperial
    @State var degreeUnitShowing = true
    
    private var degreeUnit: String {
        if degreeUnitShowing {
            selectedUnit == .imperial ? "F" : "C"
        } else {
            ""
        } // end if
    } // end degreeUnit
    
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
                } // end Group
                .font(.title2)
                
                HStack {
                    Text("Units:")
                        .fontWeight(.bold)
                    Spacer()
                    Picker("", selection: $selectedUnit) {
                        ForEach(UnitSystem.allCases, id: \.self) { unit in
                            Text(unit.rawValue.capitalized)
                        } // end ForEach
                    } // end Picker
                    .padding(.bottom)
                } // end HStack
                .font(.title2)
                
                Toggle(isOn: $degreeUnitShowing) {
                    Text("Show F/C after temp value:")
                } // end Toggle
                .font(.title2)
                .bold()
                
                HStack {
                    Spacer()
                    Text("42°\(degreeUnit)")
                    Spacer()
                } // end HStack
                .font(.system(size: 150))
                .fontWeight(.thin)

                Spacer()
            }  // end VStack
            .padding()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    } // end Buttton
                }// end ToolbarItem
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        preferences.forEach { modelContext.delete($0) }
                        let preference = Preference(
                            locationName: locationName,
                            latString: latString,
                            longString: longString,
                            selectedUnit: selectedUnit,
                            degreeUnitShowing: degreeUnitShowing
                        )
                        modelContext.insert(preference)
                        do {
                            try modelContext.save()
                        } catch {
                            print("Error saving: \(error)")
                        } // end do
                        dismiss()
                    } label: {
                        Text("Save")
                    } // end Buttton
                } // end ToolbarItem
            } // end .toolbar
        } // end VStack
        .task {
            if preferences.count > 0 {
                locationName = preferences[0].locationName
                latString = preferences[0].latString
                longString = preferences[0].longString
                selectedUnit = preferences[0].selectedUnit
                degreeUnitShowing = preferences[0].degreeUnitShowing
            } // end if
        }
    }  // end body
} // end PreferenceView

#Preview {
    PreferenceView()
        .modelContainer(Preference.preview)
} // end #Preview
