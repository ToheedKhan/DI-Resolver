# DI-Resolver

Dependency Injection frameworks support the Inversion of Control design pattern.

**Giving an object the things it needs to do its job.**

Dependency injection allows us to write code that's loosely coupled, and as such, easier to reuse, to mock, and to test.

**An ultralight Dependency Injection / Service Locator framework for Swift 5.x on iOS.**

**Note: Later in 2022 Resolver will be deprecated and replaced by my new dependency injection system, Factory. Factory is compile-time safe and is smaller, lighter, and faster than Resolver. As good as Resolver is, Factory is better. **

In object-oriented programming, there are several basic techniques to implement inversion of control. These are:

Using a service locator pattern
Using dependency injection; for example,
Constructor injection
Parameter injection
Setter injection
Interface injection
Method Injection
Using a contextualized lookup
Using the template method design pattern
Using the strategy design pattern



[Dependency Injection Strategies](https://github.com/hmlongco/Resolver/blob/master/Documentation/Injection.md#interface)
There are six classic dependency injection strategies:

### 1. Interface Injection
**Pros**
Lightweight.
Hides dependency injection system from class.
Useful for classes like UIViewController where you don't have access during the initialization process.
**Cons**
Writing an accessor function for every service that needs to be injected.

### 2. Property Injection
Property Injection exposes its dependencies as properties, and it's up to the Dependency Injection system to make sure everything is setup prior to any methods being called.
**Pros**
Clean.
Also fairly lightweight.
**Cons**
Exposes internals as public variables.
Harder to ensure that an object has been given everything it needs to do its job.
More work on the registration side of the fence.

### 3. Constructor Injection
Pass all of the dependencies an object needs through its initialization function.
**Pros**
Ensures that the object has everything it needs to do its job, as the object can't be constructed otherwise.
Hides dependencies as private or internal.
Less code needed for the registration factory.
**Cons**
Requires object to have initializer with all parameters needed.
More boilerplace code needed in the object initializer to transfer parameters to object properties.

### 4. Method Injection
**Pros**
Allows callers to configure the behavior of a method on the fly.
Allows callers to construct their own behaviors and pass them into the method.
**Cons**
Exposes those behaviors to all of the classes that use it.
Note
In Swift, passing a closure into a method could also be considered a form of Method Injection.

### 5. Service Locator
A Service Locator is basically a service that locates the resources and dependencies an object needs.

Technically, Service Locator is its own Design Pattern, distinct from Dependency Injection, but Resolver supports both and the Service Locator pattern is particularly useful when supporting view controllers and other classes where the initialization process is outside of your control.
**Pros**
Less code.
Useful for classes like UIViewController where you don't have access during the initialization process.
**Cons**
Exposes the dependency injection system to all of the classes that use it.

### 6. Annotation (NEW)
Annotation uses comments or other metadata to indication that dependency injection is required.
**Pros**
Less code.
Hides the specifics of the injection system. One could easily make an Injected property wrapper to support any DI system.
Useful for classes like UIViewController where you don't have access during the initialization process.
**Cons**
Exposes the fact that a dependency injection system is used.
Resolver supports them all

##Property Wrappers
@Injected 
@LazyInjected 
@WeakLazyInjected 
    
There's also an **@InjectedObject** wrapper that can inject Observable Objects in **SwiftUI** views.

#Features
Resolver is implemented in just over 700 lines of actual code in a single file, but it packs a ton of features into those 700 lines.

* [Automatic Type Inference](https://github.com/hmlongco/Resolver/blob/master/Documentation/Types.md)
* [Scopes](https://github.com/hmlongco/Resolver/blob/master/Documentation/Scopes.md): Application, Cached, Graph(default), Shared, and Unique
Scopes are used to control the lifecycle of a given object instance once it's been resolved. That means that scopes are basically caches, and those caches are used to keep track of the objects they create.
In DI speak, graph will reuse any object instances resolved during a given resolution cycle.

Translating again, let’s say that a depends on b and c and that b and c both depend on d. We then do the following:

@Injected private var a: A
Resolver will attempt to resolve a, and in the process, it finds out that a needs a b and that b needs a d. It makes one of each and wires them together.

Resolver then finds a also needs a c and that c also needs a d. Well, Resolver knows it’s already made a d, so it gives a copy of the existing reference to c. Now a has its b and c, and both of those refer to the same instance of d. Finally, we return our a, ready to use.

In this case, graph depends on the idea that you probably want b and c to share d since they were all made during the same resolution cycle and, as such, would seem to be associated with one another.

If you don’t want this behavior, you can just mark d’s dependency as unique. And if you never want this behavior, you can simply change Resolver’s default scope to unique.

Application - Singleton
Cached - a session-level scope that caches specific information until a user logs out.
Can be resetas needed.
```
ResolverScope.cached.reset()
```
This is useful in cases like Master/Detail view controllers, where it's possible that both the MasterViewController and the DetailViewController would like to "share" the same instance of a specific view model.

Note that value types, including structs, are never shared since the concept of a weak reference to them doesn't apply.

Only class types can have weak references, and as such only class types can be shared.


* Protocols
* Optionals
* Named Instances (Resolver 1.3 now supports safe name spaces!)
* Argument Passing (Resolver 1.2 now has built in support for multiple arguments!)
* Custom Containers & Nested Containers
This scope is commonly used in situations where service instances need the same lifecycle as the container. It's especially handy for mocking and testing where containers may be created on the fly and then disposed.
* Cyclic Dependency Support
* Storyboard Support
