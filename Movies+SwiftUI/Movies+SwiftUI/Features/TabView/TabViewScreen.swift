import SwiftUI

struct TabViewScreen: View {

    @State var selectedTab = 0

    var body: some View {

        NavigationView {
            TabView(selection: $selectedTab) {

                MultilistScreen()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
                    .statusBarStyle(.darkContent)
                    .navigationBarHidden(true)
                    .navigationBarTitle("")

                PopularMoviesScreen()
                    .tabItem {
                        Image(systemName: "play.rectangle.on.rectangle")
                        Text("Popular")
                    }
                    .tag(1)
                    .statusBarStyle(.lightContent)
                    .navigationBarHidden(true)
                    .navigationBarTitle("")

                SearcherScreen()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .tag(2)
                    .statusBarStyle(.lightContent)
                    .navigationBarHidden(true)
                    .navigationBarTitle("")

                Text("Downloads")
                    .tabItem {
                        Image(systemName: "arrow.down.circle")
                        Text("Downloads")
                    }
                    .tag(3)
                    .statusBarStyle(.darkContent)
                    .navigationBarHidden(true)
                    .navigationBarTitle("")
            }

            .onAppear {
                let blur = UIBlurEffect(style: .systemUltraThinMaterialDark)
                let color = UIColor(Color.orange.opacity(0.2))

                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.backgroundEffect = blur
                tabBarAppearance.backgroundColor = color

                let navAppearance = UINavigationBarAppearance()
                navAppearance.backgroundEffect = blur
                navAppearance.backgroundColor = color
                navAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]

                UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .lightGray

                // Use this appearance when scrolling behind the TabView:
                UITabBar.appearance().standardAppearance = tabBarAppearance
                UINavigationBar.appearance().standardAppearance = navAppearance

                // Use this appearance when scrolled all the way up:
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
            }

        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewScreen()
    }
}
