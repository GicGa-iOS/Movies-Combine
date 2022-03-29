import SwiftUI

struct TabViewScreen: View {

    @State var selectedTab = 1

    var body: some View {

        NavigationView {
            TabView(selection: $selectedTab) {

                GenresView(useSpecificGenres: nil, enableGenreTapGesture: true, alignment: .center)
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

                SearcherScreen()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .tag(2)
                    .statusBarStyle(.lightContent)
                    .navigationBarHidden(true)
                    .navigationBarTitle("")

                Text("Top Rated")
                    .tabItem {
                        Image(systemName: "flame")
                        Text("Top Rated")
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
