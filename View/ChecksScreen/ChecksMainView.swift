//
//  ChecksMainView.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 09.10.2025.
//

import SwiftUI

struct ChecksMainView: View {
    @EnvironmentObject var vm: checksViewModel
    
    var body: some View {
        NavigationStack {
            if vm.isEmpty {
                EmptyView()
                Spacer()
            } else {
                ForEach(vm.checks, id: \.id) {
                    check in Text(check.name)
                }
            }
        }
    }
}

