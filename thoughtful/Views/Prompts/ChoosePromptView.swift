//
//  ChoosePromptView.swift
//  Thoughtful
//
//  Created by Nabil Ridhwan on 15/6/24.
//

import SwiftUI
import TipKit

struct ChoosePromptView: View {
    @State var date: Date = .now
    @State var currentTab: String = "choose_prompt"
    @State var showCustomPrompt: Bool = false
    @Environment(\.dismiss) var dismiss;

    @State var newThought: Thought = .init(thought_prompt: "", thought_response: "", date_created: Date.now)

    var addCustomPromptTip = AddCustomPromptTip()

    func handlePressPrompt(_ p: String) {
        withAnimation {
            newThought.thought_prompt = p
            currentTab = "add_thought"
        }
    }

    var body: some View {
        TabView(selection: $currentTab) {
            VStack(alignment: .leading) {
                Text("Choose a prompt")
                    .font(.title)
                    .bold()

                ScrollView {
                    Button {
                        showCustomPrompt = true
                        addCustomPromptTip.invalidate(reason: .actionPerformed)
                        newThought.thought_prompt = ""
                    } label: {
                        Text("Custom Prompt")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.cardAttribute, in: RoundedRectangle(cornerRadius: 24))
                    .popoverTip(addCustomPromptTip)

                    ForEach(gratitudeQuestions, id: \.self) { p in
                        Button {
                            handlePressPrompt(p)
                        } label: {
                            Text(p)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.card, in: RoundedRectangle(cornerRadius: 24))
                    }
                }
            }
            .tag("choose_prompt")

            AddNewThoughtView(
                thought: $newThought,
                date: $date
            )
            .tag("add_thought")
        }
        .alert("Add Custom Prompt", isPresented: $showCustomPrompt) {
            Button("Cancel", role: .cancel) {
                newThought.thought_prompt = ""
            }
            Button("OK") {}

            TextField("Type your custom prompt", text: $newThought.thought_prompt)
                .lineLimit(3, reservesSpace: true)
        }
        .ignoresSafeArea(edges: .bottom)
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundStyle(.primary)
        .background(Color.background)
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

// #Preview {
//    ChoosePromptView()
// }
