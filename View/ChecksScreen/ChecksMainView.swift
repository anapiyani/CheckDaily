//
//  ChecksMainView.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 09.10.2025.
//

import SwiftUI
struct ChecksMainView: View {
    @EnvironmentObject var vm: checksViewModel
    @EnvironmentObject var auth: AuthStorage
    @State private var selectedItem: durations?

    var body: some View {
        NavigationStack {
            Group {
                if vm.isEmpty {
                    EmptyView()
                } else {
                    ScrollView {
                        ForEach(vm.checks, id: \.id) { check in
                            ChecksContainerView(id: check.id)
                                .padding()
                                .onTapGesture {
                                    selectedItem = check
                                }
                        }
                    }
                }
            }
            .onAppear {
                if let token = auth.token {
                    vm.fetchAll(token: token)
                }
            }
            .sheet(item: $selectedItem) { item in
                ChecksPopoverView(checkID: item.apiID) { 
                    selectedItem = nil
                }
            }
        }
    }
}
