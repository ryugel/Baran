//
//  LoginView.swift
//  Baran
//
//  Created by ryugel on 03/05/2024.
//  Copyright © 2024 DeRosa. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Text("Baran")
                    .font(.largeTitle).bold()
                    .foregroundColor(Color.red)
                Divider()
                ZStack {
                    if let profilePic = viewModel.profilePic, let image = UIImage(data: profilePic) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        Image(.netflixUser)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .frame(width: 85, height: 85)
                .clipShape(Rectangle())
                .onTapGesture {
                    viewModel.showImagePicker.toggle()
                }
                .contentShape(Circle())

                TextField("Username", text: $viewModel.userName)
                    .padding()
                    .background(.ultraThickMaterial)

                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(.ultraThickMaterial)

                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(.ultraThickMaterial)

                SecureField("Password", text: $viewModel.password2)
                    .padding()
                    .background(.ultraThickMaterial)

                signButton()

                Button(action: {
                    dismiss()
                }) {
                    Text("Already have an account ?\nClick to sign in.\n")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                }
            }
        }
        .overlay {
            LoadingView(showing: $viewModel.isLoading)
        }
        .photosPicker(isPresented: $viewModel.showImagePicker, selection: $viewModel.photoItem)
        .onChange(of: viewModel.photoItem, { _, newValue in
            if let newValue = newValue {
                Task {
                    do {
                        guard let imageData = try await newValue.loadTransferable(type: Data.self) else { return }
                        viewModel.profilePic = imageData
                    } catch {

                    }
                }
            }
        })
        .alert(viewModel.errorMsg, isPresented: $viewModel.showError) {}
    }

    func signButton() -> some View {
        Button(action: {
            viewModel.registerAccount()
        }, label: {
            Text("Sign In")
                .padding()
                .foregroundStyle(.white)
                .font(.callout)
                .background(
                    RoundedRectangle(cornerSize: CGSize(width: 0, height: 0), style: .continuous)
                        .foregroundStyle(.red)
                        .frame(width: 330)
                )
                .padding()
        }).isAllowed(viewModel.condition())
    }
}

extension View {
    func isAllowed(_ condition: Bool) -> some View {
        self.disabled(condition).opacity(condition ? 0.6:1)
    }
}
