//
//  DropView.swift
//  Pixiv
//
//  Created by fuwaika on 2021/2/8.
//

import SwiftUI

struct DropView: View {
    @State private var dragOver = false
    @EnvironmentObject private var appService: AppService

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .strokeBorder(
                        style: StrokeStyle(lineWidth: 1, dash: [5])
                    )
                    .foregroundColor(dragOver ? .red : .purple)
                    .frame(width: 600, height: 400)

                Text("拖入以搜寻")
                    .foregroundColor(.gray)
                    .font(.system(size: 30))
            }
            .padding(.horizontal, 10)
            .onDrop(of: ["public.file-url"], isTargeted: $dragOver) { providers in
                appService.search(for: providers)
                return true
            }
        }
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
}

struct DropView_Previews: PreviewProvider {
    static var previews: some View {
        DropView()
    }
}
