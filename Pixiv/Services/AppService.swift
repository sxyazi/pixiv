//
//  AppService.swift
//  Pixiv
//
//  Created by fuwaika on 2021/2/8.
//

import SwiftUI

class AppService: ObservableObject {
    @Published var alert: Alert?
    @Published var isAlert = false

    @Published var illusts: [SauceResult]?
    @Published var isIllusts = false

    @Published var isLoading = false
    
    func alert(_ message: String) {
        alert = Alert(title: Text("提示"),
                      message: Text(message),
                      dismissButton: .default(Text("OK")))
        isAlert = true
    }

    func search(for providers: [NSItemProvider]) {
        hideIllusts()

        providers.first?.loadDataRepresentation(forTypeIdentifier: "public.file-url", completionHandler: { (data, error) in
            if let error = error {
                self.alert("文件路径获取失败：" + error.localizedDescription)
                return
            }

            self.isLoading = true

            let url = URL(string: NSString(data: data!, encoding: 4)! as String)!
            SearchService.saucenao(of: url) { result in
                self.isLoading = false

                switch result {
                case let .success(data):
                    self.showIllusts(from: data)
                    break

                case let .failure(error):
                    self.alert("搜寻失败：" + error.localizedDescription)
                    break
                }
            }
        })
    }

    func showIllusts(from data: [SauceResult]) {
        illusts = data
        isIllusts = true
    }

    func hideIllusts() {
        isIllusts = false
        illusts = nil
    }

    func toggleIllusts(from data: [SauceResult]?) {
        if isIllusts {
            hideIllusts()
        } else {
            showIllusts(from: data!)
        }
    }
}
