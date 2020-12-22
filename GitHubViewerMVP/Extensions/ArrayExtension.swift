//
//  ArrayExtension.swift
//  GitHubViewerMVP
//
//  Created by Andrei Dobysh on 18.12.20.
//

import Foundation

extension Array {
    public subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
}
