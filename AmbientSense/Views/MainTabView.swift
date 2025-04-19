//
//  MainTabView.swift
//  AmbientSense
//
//  Created by Muntahaa Khan on 19/4/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            AmbientMonitorView()
                .tabItem {
                    Label("Home", systemImage: "waveform")
                }

            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }

            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                }
        }
    }
}
