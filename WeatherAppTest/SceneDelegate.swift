import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = setupRootViewController()
        window?.makeKeyAndVisible()
    }
    
    private func setupRootViewController() -> TabBarController {
        let controller = TabBarController()
        
        controller.viewControllers = [
            createNavController(
                for: MainViewController(),
                image: UIImage(named: "mainTabBarIcon") ?? UIImage(),
                title: "Main",
                tag: 0),
            addNewController(),
            createNavController(
                for: ForecastViewController(),
                image: UIImage(named: "forecastTabBarIcon") ?? UIImage(),
                title: "Forecast",
                tag: 2),
        ]
        return controller
    }
    
    private func createNavController(
        for rootViewController: UIViewController,
        image: UIImage,
        title: String,
        tag: Int) -> UIViewController {
            let navController = UINavigationController(rootViewController: rootViewController)
            navController.tabBarItem.tag = tag
            navController.tabBarItem.image = image
            navController.title = title
            return navController
        }
    
    private func addNewController() -> UIViewController {
        let controller = UIViewController()
        
        controller.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "plusImage")?.imageWith(newSize: CGSize(width: 64, height: 64)),
            tag: 1
        )
        return controller
    }
}
