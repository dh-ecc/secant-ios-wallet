//
//  PrimaryButton.swift
//  secant-testnet
//
//  Created by Adam Stener on 10/14/21.
//

import SwiftUI

extension Button {
    var primaryButtonStyle: some View {
        buttonStyle(
            StandardButtonStyle(
                foregroundColor: Asset.Colors.Text.button.color,
                background: Asset.Colors.Buttons.primaryButtonPressed.color,
                pressedBackgroundColor: Asset.Colors.Buttons.primaryButtonPressed.color
            )
        )
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Primary Button") { dump("Primary button") }
            .primaryButtonStyle
            .frame(width: 250, height: 50)
            .previewLayout(.fixed(width: 300, height: 100))
            .preferredColorScheme(.light)
        
        Button("Primary Button") { dump("Primary button") }
            .primaryButtonStyle
            .frame(width: 250, height: 50)
            .previewLayout(.fixed(width: 300, height: 100))
            .preferredColorScheme(.dark)
    }
}
