//
//  GuidelineIntroView.swift
//  LiLo
//
//  Created by Benedick Wijayaputra on 03/04/24.
//

import SwiftUI

struct GuidelinesIntroView: View {
    @State var isButtonEnabled = false
    @State var countdown = 5
    @State var isLoading: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 0) {
                Text("Read our guidelines:")
                    .font(.Title2)
                    .bold()
                
                Spacer()
                    .frame(height: 32)
                
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("1. Lock in after storing your belongings")
                            .font(.Headline)
                            .foregroundStyle(Color(.darkTosca))
                        
                        Text("Make sure to place your belongings inside the locker before locking your selected locker in the app")
                            .font(.Body2)
                            .foregroundColor(.black2)
                            .padding(.leading, 16)
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("2. Lock out after taking your belongings")
                            .font(.Headline)
                            .foregroundStyle(Color(.darkTosca))
                        
                        Text("Remember to take your belongings out of your locker before locking out of the locker in the app")
                            .font(.Body2)
                            .foregroundColor(.black2)
                            .padding(.leading, 16)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("3. Be mindful of active sessions")
                            .font(.Headline)
                            .foregroundStyle(Color(.darkTosca))
                        
                        Text("Consider locking out of your locker after your session ended. This will allow others to use the empty locker")
                            .font(.Body2)
                            .foregroundColor(.black2)
                            .padding(.leading, 16)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("4. Report any false lockers")
                            .font(.Headline)
                            .foregroundStyle(Color(.darkTosca))
                        
                        Text("If you found any inaccuracies with the locker availability status, please report the issue using the designated button.")
                            .font(.Body2)
                            .foregroundColor(.black2)
                            .padding(.leading, 16)
                        
                    }
                }
                
                Spacer()
                    .frame(height: 32)

                VStack(spacing: 8){
                    Button {
                        done()
                    } label: {
                        HStack {
                            if isLoading {
                                ProgressView()
                            } else {
                                Text("I Understand")
                                    .font(.Headline)
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background((isButtonEnabled && !isLoading) ? .darkTosca : .grey)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .buttonStyle(.plain)
                        .buttonBorderShape(
                            .roundedRectangle(radius: 10)
                        )
                    }
                    .disabled(!isButtonEnabled || isLoading)
                    
                    if countdown != 0 {
                        Text("\(countdown)s")
                            .font(.Body2)
                            .foregroundColor(.darkTosca)
                    }
                    
                }
            }
            
            .onAppear {
                // Start a timer when the view appears
                //                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                //                            isButtonEnabled = true // Enable the button after 5 seconds
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    if countdown > 0 {
                        countdown -= 1
                    } else {
                        isButtonEnabled = true // Enable the button after countdown reaches 0
                        timer.invalidate() // Stop the timer
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
        }
    }
    
    private func done() {
        Task {
            isLoading = true
            let userDefaults = UserDefaults.standard
            userDefaults.set(false, forKey: "showGuidelines")
            isLoading = false
        }
    }
}

#Preview {
    NavigationStack {
        GuidelinesIntroView()
    }
}
