import Foundation
import Models
import SwiftUI
import Env

@MainActor
class PendingStatusesObserver: ObservableObject {
  @Published var pendingStatusesCount: Int = 0

  var disableUpdate: Bool = false

  var pendingStatuses: [String] = [] {
    didSet {
      pendingStatusesCount = pendingStatuses.count
    }
  }

  func removeStatus(status: Status) {
    if !disableUpdate, let index = pendingStatuses.firstIndex(of: status.id) {
      pendingStatuses.removeSubrange(index ... (pendingStatuses.count - 1))
      HapticManager.shared.selectionChanged()
    }
  }

  init() {}
}

struct PendingStatusesObserverView: View {
  @ObservedObject var observer: PendingStatusesObserver
  var body: some View {
    if observer.pendingStatusesCount > 0 {
      HStack(spacing: 6) {
        Spacer()
        Button {} label: {
          Text("\(observer.pendingStatusesCount)")
        }
        .buttonStyle(.bordered)
        .background(.thinMaterial)
        .cornerRadius(8)
      }
      .padding(12)
    }
  }
}
