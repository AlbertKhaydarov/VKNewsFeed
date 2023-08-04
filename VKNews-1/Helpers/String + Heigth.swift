//
//  String + Heigth.swift
//  VKNews
//
//  Created by Альберт Хайдаров on 30.07.2023.
//

import Foundation
import UIKit

extension String {
    func heigth(width: CGFloat, font: UIFont) -> CGFloat{
        let texztSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let size = self.boundingRect(with: texztSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        return ceil(size.height)
    }
}
