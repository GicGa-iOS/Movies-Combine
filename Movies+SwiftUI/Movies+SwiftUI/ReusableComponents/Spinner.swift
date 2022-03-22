//
//  Spinner.swift
//  Movies+SwiftUI
//
//  Created by Giancarlo Castañeda Garcia on 22/03/22.
//

import SwiftUI
import UIKit

struct Spinner: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: style)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
}

