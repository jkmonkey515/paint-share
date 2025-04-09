//
//  ModalView.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/28/21.
//

import SwiftUI

struct ModalView<Parent: View, Content: View>: View {
    @Environment(\.modalStyle) var style: AnyModalStyle
    
    @Binding var isPresented: Bool
    
    var isLoading: Bool
    
    var disableDismiss: Bool
    
    var parent: Parent
    var content: Content
    
    let backgroundRectangle = Rectangle()
    
    var body: some View {
        ZStack {
            parent
            
            if isPresented {
                style.makeBackground(
                    configuration: ModalStyleBackgroundConfiguration(
                        background: backgroundRectangle
                    ),
                    isPresented: $isPresented, isLoading: isLoading, disableDismiss: disableDismiss
                )
                style.makeModal(
                    configuration: ModalStyleModalContentConfiguration(
                        content: AnyView(content)
                    ),
                    isPresented: $isPresented, isLoading: isLoading
                )
            }
        }
        .animation(style.animation)
    }
    
    init(isPresented: Binding<Bool>, isLoading: Bool, disableDismiss: Bool, parent: Parent, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.parent = parent
        self.content = content()
        self.isLoading = isLoading
        self.disableDismiss = disableDismiss
    }
}

extension View {
    func modal<ModalBody: View>(
        isPresented: Binding<Bool>,
        isLoading: Bool = false,
        disableDismiss: Bool = false,
        @ViewBuilder modalBody: () -> ModalBody
    ) -> some View {
        ModalView(
            isPresented: isPresented,
            isLoading: isLoading,
            disableDismiss: disableDismiss,
            parent: self,
            content: modalBody
        )
    }
}

/// Modal Style

protocol ModalStyle {
    associatedtype Background: View
    associatedtype Modal: View
    
    var animation: Animation? { get }
    
    func makeBackground(configuration: BackgroundConfiguration, isPresented: Binding<Bool>, isLoading: Bool, disableDismiss: Bool) -> Background
    func makeModal(configuration: ModalContentConfiguration, isPresented: Binding<Bool>, isLoading: Bool) -> Modal
    
    typealias BackgroundConfiguration = ModalStyleBackgroundConfiguration
    typealias ModalContentConfiguration = ModalStyleModalContentConfiguration
}

extension ModalStyle {
    func anyMakeBackground(configuration: BackgroundConfiguration, isPresented: Binding<Bool>, isLoading: Bool, disableDismiss: Bool) -> AnyView {
        AnyView(
            makeBackground(configuration: configuration, isPresented: isPresented, isLoading: isLoading, disableDismiss: disableDismiss)
        )
    }
    
    func anyMakeModal(configuration: ModalContentConfiguration, isPresented: Binding<Bool>, isLoading: Bool) -> AnyView {
        AnyView(
            makeModal(configuration: configuration, isPresented: isPresented, isLoading: isLoading)
        )
    }
}

public struct AnyModalStyle: ModalStyle {
    let animation: Animation?
    
    private let _makeBackground: (ModalStyle.BackgroundConfiguration, Binding<Bool>, Bool, Bool) -> AnyView
    private let _makeModal: (ModalStyle.ModalContentConfiguration, Binding<Bool>, Bool) -> AnyView
    
    init<Style: ModalStyle>(_ style: Style) {
        self.animation = style.animation
        self._makeBackground = style.anyMakeBackground
        self._makeModal = style.anyMakeModal
    }
    
    func makeBackground(configuration: ModalStyle.BackgroundConfiguration, isPresented: Binding<Bool>, isLoading: Bool, disableDismiss: Bool) -> AnyView {
        return self._makeBackground(configuration, isPresented, isLoading, disableDismiss)
    }
    
    func makeModal(configuration: ModalStyle.ModalContentConfiguration, isPresented: Binding<Bool>, isLoading: Bool) -> AnyView {
        return self._makeModal(configuration, isPresented, isLoading)
    }
}

struct ModalStyleKey: EnvironmentKey {
    public static let defaultValue: AnyModalStyle = AnyModalStyle(DefaultModalStyle())
}

extension EnvironmentValues {
    var modalStyle: AnyModalStyle {
        get {
            return self[ModalStyleKey.self]
        }
        set {
            self[ModalStyleKey.self] = newValue
        }
    }
}

extension View {
    func modalStyle<Style: ModalStyle>(_ style: Style) -> some View {
        self
            .environment(\.modalStyle, AnyModalStyle(style))
    }
}

/// Modal Style Configuration

struct ModalStyleBackgroundConfiguration {
    let background: Rectangle
}

struct ModalStyleModalContentConfiguration {
    let content: AnyView
}

/// Default Modal Style

struct DefaultModalStyle: ModalStyle {
    let animation: Animation? = .easeInOut(duration: 0.2)
    
    func makeBackground(configuration: ModalStyle.BackgroundConfiguration, isPresented: Binding<Bool>, isLoading: Bool, disableDismiss: Bool) -> some View {
        configuration.background
            .edgesIgnoringSafeArea(.all)
            .foregroundColor(.black)
            .opacity(isLoading ? 0.01 : 0.3)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .zIndex(1000)
            .onTapGesture {
                if !disableDismiss {
                    isPresented.wrappedValue = false
                }
            }
    }
    
    func makeModal(configuration: ModalStyle.ModalContentConfiguration, isPresented: Binding<Bool>, isLoading: Bool) -> some View {
        configuration.content
            .background(isLoading ? Color.clear : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: CGFloat(20).pixelsToPoints()))
            .zIndex(1001)
    }
}
