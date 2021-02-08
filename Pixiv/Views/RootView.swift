//
//  Root.swift
//  Pixiv
//
//  Created by fuwaika on 2021/2/8.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appService: AppService

    var body: some View {
        ZStack {
            DropView()

            if appService.isIllusts {
                PickView()
            }

            if appService.isLoading {
                LoadingView()
            }
        }
        .alert(isPresented: $appService.isAlert) { appService.alert! }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environmentObject(Mock.appService)
    }
}
