//
//  PickView.swift
//  Pixiv
//
//  Created by fuwaika on 2021/2/8.
//

import SwiftUI
import SDWebImageSwiftUI

struct PickView: View {
    @State var selected = 0
    @EnvironmentObject var appService: AppService
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            PickLeftView(selected: $selected)
            
            Divider().background(Color("Border"))
            
            PickRightView(selected: $selected)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .foregroundColor(.white)
        .background(Color("Background1"))
    }
}

struct PickLineView: View {
    let info: SauceResult
    let selected: Bool
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: info.preview))
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipped()
                .cornerRadius(20)
            
            VStack(alignment: .leading) {
                Text(info.title)
                    .lineLimit(2)
                Text(info.author_name)
                    .lineLimit(1)
                    .foregroundColor(selected ? .white : .gray)
            }
            
            Spacer()
            
            ZStack {
                if info.source == "Pixiv" {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 15, height: 15)
                    
                    Text("P")
                        .foregroundColor(.blue)
                        .font(Font.system(size: 13))
                }
            }
        }
    }
}

struct PickLeftView: View {
    @Binding var selected: Int
    @EnvironmentObject var appService: AppService
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if let illusts = appService.illusts {
                    ForEach(0 ..< illusts.count) { index in
                        VStack(alignment: .leading, spacing: 0) {
                            PickLineView(info: illusts[index], selected: index == selected)
                                .padding(12)

                            Divider()
                                .background(index == selected ? Color("Highlight") : Color("Border"))
                                .padding(.leading, index == selected ? 0 : 55)
                        }
                        .frame(width: 220)
                        .background(index == selected ? Color("Highlight") : nil)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selected = index
                        }
                    }
                }
            }
        }
        .background(Color("Background2"))
    }
}

struct PickRightView: View {
    @Binding var selected: Int
    @Environment(\.openURL) var openURL
    @EnvironmentObject var appService: AppService
    
    var info: SauceResult? {
        appService.illusts?[selected]
    }
    
    var body: some View {
        VStack {
            if let info = info {
                VStack {
                    Text(info.title).font(.largeTitle)
                    Text(info.author_name)
                }
                .padding(.bottom, 30)
                
                WebImage(url: URL(string: info.preview))
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 30)
                    .shadow(color: .black, radius: 20, x: 20, y: 20)
                
                HStack(spacing: 20) {
                    Button("插画") {
                        openURL(URL(string: info.illust_link)!)
                    }
                    
                    Button("作者") {
                        openURL(URL(string: info.author_link)!)
                    }
                    
                    Button("下载") {
                        appService.alert("开发中……")
                    }
                }
            }
        }
    }
}

struct PickView_Previews: PreviewProvider {
    static var previews: some View {
        PickView().environmentObject(Mock.appService)
    }
}
