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

#Understanding Dependency Flow
DI is a design pattern you can use to implement IoC. It lets you create dependent objects outside of the class that depends on them.

**Your goal with DI is to resolve this chain of dependencies**
<kbd>
<img width="421" alt="DependencyFlow" src="https://user-images.githubusercontent.com/4839453/209520315-8328a1ae-9216-401d-b336-6711529f16a7.png">
</kbd>

#Dependency Injection Using Resolver
Resolver is a Dependency Injection framework for Swift that supports IoC.

Resolver also introduced a new type named **Annotation.**
Resolver uses **@Injected** as a property wrapper to inject dependencies.

#Service Locator
Service Locator is another design pattern you can use to implement IoC. Fortunately, Resolver supports Service Locator well.

If a property wrapper is already being used for a property, then we can't use Annotation and add @Injected.
   
   Instead, we either have to use Service Locator or other types of DI, such as Constructor Injection.
