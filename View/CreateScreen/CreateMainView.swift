//
//  CreateMainView.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 22.10.2025.
//
import SwiftUI

struct CreateMainView: View {
    @EnvironmentObject var vm: checksViewModel
    @State var name: String = ""
    @State var selectedId: UUID? = nil
    @State var customCount: String = "0"
    
    @State var created: Bool = false
    
    init() {
        _selectedId = State(initialValue: DurationOptions.first?.id)
    }
    
    private var selectedItem: durationOptions? {
        DurationOptions.first(where: {$0.id == selectedId})
    }
    
    private var customDays: Int? {
        let digitsOnly = customCount.filter(\.isNumber)
        guard
            !digitsOnly.isEmpty, let n = Int(digitsOnly), n > 0
        else
            { return nil }
        return n
    }

    private var effectiveDays: Int? {
        if let id = selectedId, let item = DurationOptions.first(where: { $0.id == id }) {
            return Int(item.count)
        } else {
            return customDays
        }
    }
    
    func save() {
        let item = durations(
            name: name,
            count: effectiveDays ?? 30,
            created_at: Date()
        )
        vm.add(item)
        created.toggle()
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("What's your goal?")
                .font(.title3)
                .fontWeight(.bold)
            InputField(
                placeholder: "Morning workout", textvalue: $name
            )
        }
        .padding()
        VStack (alignment: .leading, spacing: 14) {
            Text("Choose duration")
                .font(.title3)
                .fontWeight(.bold)
            ForEach(DurationOptions, id: \.id) {
                data in DurationCard(
                image_name: data.image_name,
                duration: data.duration,
                descr: data.descr,
                duration_days: data.duration_days,
                is_selected: selectedId == data.id,
                gradient_colors: data.gradient_colors
                )
                .onTapGesture {
                    selectedId = data.id
                }
            }
            DurationCard(
            image_name: "calendar",
            duration: "Custom",
            descr: "Choose your own",
            duration_days: "",
            is_selected: selectedId == nil,
            gradient_colors: [Color(.systemGray2), Color(.gray)]
            )
            .onTapGesture {
                selectedId = nil
            }
            if selectedId == nil {
                HStack {
                    InputField(
                        placeholder: "0",
                        textvalue: $customCount
                    )
                    .keyboardType(.decimalPad)
                    .frame(width: 80)
                    .onChange(of: customCount) {
                        new in
                            customCount = new.filter(\.isNumber)
                    }
                    Text("days")
                        .foregroundStyle(Color("secondary-text"))
                }
            }
        }
        .padding()
        let previewCount = selectedItem?.count ?? Int(customCount)
        if let days = effectiveDays, days > 0 {
            VStack (alignment: .leading, spacing: 14) {
                Text("Preview")
                    .font(.title3)
                    .fontWeight(.bold)
                PreviewChecksView(
                    name: $name,
                    count: previewCount!
                )
            }
            .padding()
        }
        created ? Text("Task Created!").font(.title3).foregroundColor(.green) : Text("")
        TButton(
            isFilled: true,
            image: "plus",
            shouldDisable: name.isEmpty && (selectedItem != nil || previewCount! > 0), text: "Create Task",
            action: {
                save()
            }, imagePlacement: "left"
        )
    }
}
