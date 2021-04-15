//
//  ContentView.swift
//  quotes
//
//  Created by Jason Zurita on 4/05/21.
//

import SwiftUI

struct ContentView: View {
    @State var quote: Quote?
    var body: some View {
        VStack {
            if let quote = quote {
                Spacer()
                Spacer()
                Text(quote.content)
                Text("— \(quote.author)")
                Spacer()
                Button("New") {
                    loadNewQuote()
                }
                Spacer()
                Spacer()

            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            loadNewQuote()
        }
    }

    private func loadNewQuote() {
        let url = URL(string: "https://api.quotable.io/random?tags=technology,famous-quotes")!

        let task = URLSession.shared.dataTask(with: url) {(data, _, _) in
            guard let data = data else { return }
            guard let quote = try? JSONDecoder().decode(Quote.self, from: data) else { return }
            self.quote = quote

        }

        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
