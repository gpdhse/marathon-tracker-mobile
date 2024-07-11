import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var authViewModel = AuthViewModel.create()
    
    var body: some View {
        VStack{
            if !authViewModel.isAuthenticated {
                AuthScreen(authViewModel: authViewModel)
            } else {
                EmptyView()
            }
        }.onAppear{
            Task {
                await authViewModel.authenticate()
                if (!authViewModel.isAuthenticated){
                    await authViewModel.refresh()
                }
            }
        }
    }
}
