//
//  ChecksMainView.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 09.10.2025.
//

import SwiftUI

struct ChecksMainView: View {
    @EnvironmentObject var vm: checksViewModel
    @State private var selectedItem: durations?
    
    var body: some View {
        NavigationStack {
            if vm.isEmpty {
                EmptyView()
                Spacer()
            } else {
                ScrollView {
                    ForEach(vm.checks, id: \.id) {
                        check in
                            ChecksContainerView(id: check.id)
                                .padding()
                                .onTapGesture {
                                    selectedItem = check
                                }
                    }
                }
                .sheet(item: $selectedItem, content: { item in
                    ChecksPopoverView(checkID: item.id, onDismiss: {selectedItem = nil})
                })
            }
        }
    }
}
