//
//  SpendingDiagramView.swift
//  Wallet
//
//  Created by Yevhen Mokeiev on 16.03.2023.
//

import SwiftUI
import Charts

struct SpendingDiagramView: View {

    @ObservedObject var user: User

    init(user: User) {
        self.user = user
    }

    var body: some View {
        chart
    }

    private var chart: some View {
        Chart(user.topCategoryGroups, id: \.destination) { element in
            Plot {
                BarMark(
                    x: .value("Data Size", element.totalAmount)
                )
                .foregroundStyle(by: .value("Data Category", element.destination))
            }
        }
        .chartPlotStyle { plotArea in
            plotArea
                .background(Color(.systemFill))
                .cornerRadius(8)
        }
        .chartForegroundStyleScale(range: gradients)
        .chartXAxis(.hidden)
        .chartLegend(position: .bottom, spacing: 8)
        .chartLegend(.visible)
        .frame(height: 60)
    }

    private var gradients: [LinearGradient] {
        return [
            LinearGradient(colors: [.green, .orange], startPoint: .leading, endPoint: .trailing),
            LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing),
            LinearGradient(colors: [.red, .purple], startPoint: .leading, endPoint: .trailing),
            LinearGradient(colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing),
            LinearGradient(colors: [.blue, .cyan], startPoint: .leading, endPoint: .trailing),
        ]
    }
}
