import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var authViewModel = AuthViewModel.create()
    
    var body: some View {
        VStack{
            if !authViewModel.isAuthenticated {
                AuthScreen(authViewModel: authViewModel)
            } else {
                MainScreen(authViewModel: authViewModel)
            }
        }.onAppear{
            authViewModel.authenticate()
            if (!authViewModel.isAuthenticated){
                authViewModel.refresh()
            }
            
        }
    }
}
