//
//  JustifiedTextView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 7/8/24.
//

import SwiftUI
import UIKit

struct NaturalTextView: UIViewRepresentable {
    var text: String
    var customFontName: String
    var fontSize: CGFloat

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textContainer.lineFragmentPadding = 0
        textView.textAlignment = .natural
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = UIFont(name: customFontName, size: fontSize) ?? UIFont.preferredFont(forTextStyle: .body)
        uiView.textColor = UIColor.label
    }
}
