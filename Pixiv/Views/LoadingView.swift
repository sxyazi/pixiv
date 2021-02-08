//
//  LoadingView.swift
//  Pixiv
//
//  Created by fuwaika on 2021/2/8.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.yellow)
                .frame(width: 80, height: 20)
                .offset(y: -20)

            Rectangle()
                .fill(Color.yellow)
                .frame(width: 40, height: 40)
                .offset(y: 10)

            RoundedRectangle(cornerRadius: 100)
                .fill(Color.yellow)
                .frame(width: 50, height: 50)
                .offset(y: 10)

            HeartView()
        }
    }
}

struct HeartView: View {
    @State private var heart: CGFloat = 1
    @State private var shadow: CGFloat = 1
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Image(systemName: "bolt.heart.fill")
                .font(.system(size: 100))
                .foregroundColor(.red)
                .scaleEffect(shadow)
                .opacity(Double(2 - shadow))
                .animation(self.shadow == 1 ? nil : Animation.linear(duration: 0.5).delay(0.1))

            Image(systemName: "bolt.heart.fill")
                .font(.system(size: 100))
                .foregroundColor(.red)
                .scaleEffect(heart)
                .animation(Animation.default)
        }
        .onReceive(timer) { _ in
            self.heart = self.heart == 1 ? 1.2 : 1
            self.shadow = self.shadow == 1 ? 2 : 1
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
