# Initial commit
Look at the code, and you’ll see tightly coupled classes. Even though you can run the app, this code is neither maintainable nor testable. Your goal is to refactor the code, so the classes become loosely coupled. 

# Refactoring Tightly Coupled Classes
In tightly coupled classes, changes in one class result in unanticipated changes in the other. Thus, tightly coupled classes are less flexible and harder to extend. Initially, this might not be a problem, but as your project grows in size and complexity it becomes harder and harder to maintain.

Few techniques to create loosely coupled classes. 

<kbd>
<img width="672" alt="Techniques to create loosley coupled code" src="https://user-images.githubusercontent.com/4839453/209520342-2d0f6a76-9d40-4e4d-9e24-4f379ee3a90e.png">
</kbd>

**Roadmap to move from Tightly Coupled to Loosely Coupled classes.**


<kbd>
<img width="683" alt="Principle Pattern" src="https://user-images.githubusercontent.com/4839453/209520330-fdbd7049-7e25-436f-aa54-011c5af5f33d.png">
</kbd>

# Inversion of Control (IOC)
IoC recommends moving all of a class’s responsibilities, other than its main one, to another class.

For a better understanding, imagine yourself as a startup founder. In the beginning, you deal with development, taxes, recruitment, salaries and many other things yourself. As your business grows, you need to start delegating tasks and introduce dependencies.

You do that by adding different departments like legal and HR. As a result, you aren’t involved in the complexity of their work. Instead, you can focus on your main job, which is running the startup.

It’s the same in an app life cycle. When the app is small, it’s easy to handle the dependencies. But, as it grows, managing dependencies becomes more and more complicated.


In this tutorial, we’ll use DI to implement IoC.

# Understanding Dependency Flow
DI is a design pattern you can use to implement IoC. It lets you create dependent objects outside of the class that depends on them.

**Your goal with DI is to resolve this chain of dependencies**
<kbd>
<img width="421" alt="DependencyFlow" src="https://user-images.githubusercontent.com/4839453/209520315-8328a1ae-9216-401d-b336-6711529f16a7.png">
</kbd>

# Dependency Injection Using Resolver
Resolver is a Dependency Injection framework for Swift that supports IoC.

Resolver also introduced a new type named **Annotation.**
Resolver uses **@Injected** as a property wrapper to inject dependencies.

Now, you’ll register AssetViewModel with an argument. Go to App+Injection.swift. In registerAllServices(), add:
Registering Arguments
```
register { _, args in
  AssetViewModel(asset: args())
}
```


Resolver uses the new callAsFunction feature from Swift 5.2 to immediately get the single passed argument from args.
```
AssetView(assetViewModel: Resolver.resolve(args: asset))
```

# Service Locator
Service Locator is another design pattern you can use to implement IoC. Fortunately, Resolver supports Service Locator well. You may ask yourself, why am I using Service Locator when Annotation is so convenient?


Find AssetListView.swift and check assetListViewModel. As you can see, it already has **@ObservedObject** as property wrapper. So, you can’t use Annotation and add **@Injected** here.

Instead, you either have to use Service Locator or other types of DI, such as Constructor Injection.

Next, still in AssetListView.swift, resolve AssetListViewModel using Service Locator.
Replace:
```
@ObservedObject var assetListViewModel: AssetListViewModel
```
With:

```
@ObservedObject var assetListViewModel: AssetListViewModel = Resolver.resolve()
```

Resolver.resolve() reaches out to registerAllServices(), where all services are registered. Then, it looks for AssetListViewModel. As soon as it finds the instance, it resolves it.


# Using Scopes
Resolver uses Scopes to control the lifecycles of instances. There are five different scopes in Resolver: **Graph, Application, Cached, Shared and Unique.**
<img width="587" alt="resolver" src="https://github.com/ToheedKhan/DI-Resolver/assets/4839453/286c3990-58be-4fe5-ac0f-89161671cbbe">

**Graph:** Graph is Resolver’s default scope. Once Resolver resolves the requested object, it discards all objects created in that flow. Consequently, the next call to Resolver creates new instances.
**Application:** Application scope is the same as a singleton. The first time Resolver resolves an object, it retains the instance and uses it for all subsequent resolutions as long as the app is alive. You can define that by adding .scope(.application) to your registrations.


You can define scopes in two ways. First, you could add scope to each registration separately like this:

```
register { NetworkService() }.scope(.graph)
```

Add the following as the first line in registerAllServices():

```
defaultScope = .graph
```

# Unit Testing and the Dependency Inversion Principle

Unit testing is an important step in building a clean and maintainable codebase. To ease the process of unit testing, we follow the **Dependency Inversion Principle, or DIP.**

DIP is one of the SOLID principles. It declares that high-level modules shouldn’t depend on low-level modules. Instead, both should depend on abstractions.

For example, **AssetService**, a **high-level** module*, should be dependent on an abstraction of **NetworkService**, a **low-level module**. You implement **abstractions** in Swift with **Protocols**.

The following steps show how to implement DIP:

* First, create a protocol for the low-level module.
* Second, update the low-level module to conform to the protocol.
* Third, update the high-level module to be dependent on the low-level module protocol.

To apply DIP to your project, you need to go through the steps one by one.

First, create a protocol for the low-level module. In this case, NetworkService is the low-level module. So, open NetworkService.swift and add NetworkServiceProtocol right below // MARK: - NetworkServiceProtocol:
```
protocol NetworkServiceProtocol {
  func fetch(
    with urlRequest: URLRequest,
    completion: @escaping (Result<Data, AppError>) -> Void
  )
}
```
Second, update the low-level module to conform to the protocol. Since NetworkService is the low-level module, it has to conform to the protocol. Find the line of code that reads:
```
extension NetworkService {
```
And replace it with:
```
extension NetworkService: NetworkServiceProtocol {
```
Third, update the high-level module dependency to the protocol. AssetService is the high-level module. So, in AssetService.swift, change networkService to be of type NetworkServiceProtocol. Replace:
```
@Injected private var networkService: NetworkService
```
with:
```
@Injected private var networkService: NetworkServiceProtocol
```

# Registering Protocols

When resolving instances, Resolver infers the registration type based on the type of object the factory returns. Thus, if your instances are of type protocol like this:
```
@Injected private var networkService: NetworkServiceProtocol
```

You need to make sure your registration in the factory returns the protocol type as well.

Open App+Injection.swift. Then, update register { NetworkService() } to address the protocol:

```
register { NetworkService() }.implements(NetworkServiceProtocol.self)
```

Here you create an object of type NetworkService. But, it’s returned as a type of **NetworkServiceProtocol**, thus confirming to the requirement of **NetworkService**.



# Generating Mock Data
Mocking is an essential technique when writing unit tests. By mocking dependencies, you create fake versions of them, so your tests can focus solely on the class at hand rather than its collaborators.

or a better understanding, open AssetServiceTests.swift. Here, you test if AssetService handles the success and failure responses of NetworkService as expected.

In cases like this, mocking is an excellent approach because you’re in control of how you challenge your Subject Under Test, or SUT, based on different response types.

Now go to **MockNetworkService.swift** and add:

```
// 1
class MockNetworkService: NetworkServiceProtocol {
  // 2
  var result: Result<Data, AppError>?

  // 3
  func fetch(
    with urlRequest: URLRequest,
    completion: @escaping (Result<Data, AppError>) -> Void
  ) {
    guard let result = result else {
      fatalError("Result is nil")
    }
    return completion(result)
  }
}
```

Here you:

Create a mock class that conforms to NetworkServiceProtocol. You’ll use this class in your Test target instead of NetworkService. That’s the beauty of abstractions.
Then create the result property. The default value is nil. You’ll assign success and failure to it based on your test case.
As a result of conforming to NetworkServiceProtocol, you need to implement fetch(with:completion:). You can modify the result as you want because it’s a mock class.
Next, you’ll register these mock classes in Resolver, so you can resolve them when testing.

# Using Resolver’s Containers
In a DI system, a **container** contains all the service registrations. By using Resolver, you can create different containers based on what your project needs. In this tutorial, you’ll create a Mock container for your Test target.
By default, Resolver creates a main container for all static registrations. It also defines a root container. If you inspected Resolver’s code you’d see:

```
public final class Resolver {
  public static let main: Resolver = Resolver()
  public static var root: Resolver = main
}
```

In this project, you use the default **main container** in the **App target** and a **mock container** in the **Test target.**
App Target ->
Root -> Main Container
Test Target ->
Root -> Mock Container


# Registering Services in a Mock Container
Now, you’ll register your **MockNetworkService** in a mock container. Go to Resolver+XCTest.swift. Right below // MARK: - Mock Container create a mock container by adding:
```
static var mock = Resolver(parent: .main)
```

Now, still in Resolver+XCTest.swift, change the default root value in registerMockServices(). It must point to your new mock container:

```
root = Resolver.mock
```

You’ll use the Application scope instead of Graph in your test target. In registerMockServices(), add:
```
defaultScope = .application
```

Then, register your mock service in the mock container. In registerMockServices(), right after defaultscope, add:
```
Resolver.mock.register { MockNetworkService() }
  .implements(NetworkServiceProtocol.self)
```

Now that your registration is complete, it’s time to use it.

# Dependency Injection in Unit Tests
Open AssetServiceTests.swift. Then, call registerMockServices at the bottom of setUp():

```
Resolver.registerMockServices()
```
This call ensures all dependencies are registered before use.

Finally, add NetworkService to AssetServiceTests. Right below // MARK: - Properties, add:

```
@LazyInjected var networkService: MockNetworkService
```
You might be thinking, “What the heck is **@LazyInjected?**” Calm down! It’s not a big deal.

Well, actually, it is. :]

By using **Lazy Injection **you ask Resolver to **lazy load dependencies**. Thus, Resolver won’t resolve this dependency before the first time it’s used.

You need to use **@LazyInjected** here because the dependencies aren’t available when the class is initiated as you registered them in setup().
