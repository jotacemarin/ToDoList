//
//  ContentView.swift
//  ToDoList
//
//  Created by Julio Marin on 25/06/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var taskStore = TaskStore()
    @State var newTask: String = ""

    var searchBar: some View {
        HStack {
            TextField("Insert new task", text: self.$newTask)
            Button(action: self.addNewTask, label: { Text("Add new") })
        }
    }
    
    func addNewTask () {
        if newTask.isEmpty {
            return
        }

        taskStore.tasks.append(Task(id: String(taskStore.tasks.count + 1), description: self.newTask))
        
        self.newTask = ""
    }
    
    func deleteTask (id: String) {
        if self.taskStore.tasks.isEmpty {
            return
        }
        
        if let task = self.taskStore.tasks.enumerated().first(where: { $0.element.id == id }) {
            self.taskStore.tasks.remove(at: task.offset)
        }
    }

    var body: some View {
        NavigationView{
            VStack{
                searchBar.padding()
                List(self.taskStore.tasks) {
                    task in HStack {
                        Text(task.description)
                        Spacer()
                        Button(role: .destructive, action: { self.deleteTask(id: task.id) }) {
                            Label("", systemImage: "trash")
                        }
                    }
                }.navigationTitle("To Do List")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
