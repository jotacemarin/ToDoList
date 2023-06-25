//
//  Datastore.swift
//  ToDoList
//
//  Created by Julio Marin on 25/06/23.
//

import Foundation
import SwiftUI
import Combine

struct Task: Identifiable {
    var id = String()
    var description = String()
}

class TaskStore: ObservableObject {
    @Published var tasks = [Task]()
}
