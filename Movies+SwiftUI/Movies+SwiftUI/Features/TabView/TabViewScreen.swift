import SwiftUI

struct TabViewScreen: View {

    @State var selectedTab = 1

    var body: some View {

        NavigationView {
            TabView(selection: $selectedTab) {

                Text("Upcoming")
                    .tabItem {
                        Image(systemName: "star.bubble")
                        Text("Upcoming")
                    }
                    .tag(0)
                    .statusBarStyle(.darkContent)
                    .navigationBarHidden(true)
                    .navigationBarTitle("")

                PopularMoviesScreen()
                    .tabItem {
                        Image(systemName: "theatermasks")
                        Text("Popular")
                    }
                    .tag(1)
                    .statusBarStyle(.lightContent)
                    .navigationBarHidden(true)
                    .navigationBarTitle("")

                Text("Top Rated")
                    .tabItem {
                        Image(systemName: "flame")
                        Text("Top Rated")
                    }
                    .tag(2)
                    .statusBarStyle(.darkContent)
                    .navigationBarHidden(true)
                    .navigationBarTitle("")
            }

            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
                appearance.backgroundColor = UIColor(Color.orange.opacity(0.2))

                // Use this appearance when scrolling behind the TabView:
                UITabBar.appearance().standardAppearance = appearance
                // Use this appearance when scrolled all the way up:
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }

        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewScreen()
    }
}
