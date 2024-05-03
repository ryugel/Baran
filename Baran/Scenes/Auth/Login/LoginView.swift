//
//  LoginView.swift
//  Baran
//
//  Created by ryugel on 03/05/2024.
//  Copyright © 2024 DeRosa. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("Baran")
                    .font(.largeTitle).bold()
                    .foregroundColor(Color.red)
                Divider()
                Text("WATCH\nTV SHOWS &\nMOVIES\nANYWHERE.\nANYTIME.")
                    .bold()
                    .font(.largeTitle)
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(.ultraThickMaterial)

                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(.ultraThickMaterial)

                Button(action: {
                    viewModel.login()
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
                        .padding(.leading, 119)
                })
                Button(action: {
                    viewModel.createAccount.toggle()
                }) {
                    Text("Doesn't have an account yet ?\nNo worries you can just create your acoount here.\n")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                }

                Button(action: {
                    viewModel.resetPassword()
                }) {
                    Text("Forgot your password ?")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }.alert("Link sent", isPresented: $viewModel.alert) {}

                Spacer()
            }
            .overlay {
                LoadingView(showing: $viewModel.isLoading)
            }
            .fullScreenCover(isPresented: $viewModel.createAccount, content: {
                              RegisterView()
                          })
            .padding()
        }
        .alert(viewModel.errorMsg, isPresented: $viewModel.showError) {}
    }
}
