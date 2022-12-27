# Inversion of Control:
The Inversion of Control (IoC) and Dependency Injection (DI) patterns are all about removing dependencies from your code. This Principle helps in designing loosely coupled classes that make them testable, maintainable, and extensible.

If you follow these simple two steps, you have done the inversion of control:

1. Separate the what-to-do part from the when-to-do part.
2. Ensure that when part knows as little as possible about what part; and vice versa.

** *"Inversion of Control as the name suggests is to invert control for loose coupling between components making them smaller, testable, and reusable.""* **

Have you encountered the following in your code:

Your components are not that small and cute as they used to be while starting your development.
Components in your code produce undesired side effects that are hard to debug.
The components you write keep on becoming bulkier if multiple use cases and logic are encountered.
Classes are becoming difficult to test might be due to their size or lack of separation of concerns.

##What do you mean by inverting the control?
Let us take an example where you are Batman who gets his morning newspaper from Mr. Alfred, the news agent. Even though you are Batman, you don’t get your morning news whenever Mr. Alfred goes on vacation. You are very dependent on Mr. Alfred for getting your newspaper. For a solution, you directly now reach out to the agency of Mr. Alfred, i.e Gotham Publications to supply your newspapers. In this case, you will either get your newspaper by Mr. Alfred or by any other agents as the agency deems to make sure you have an uninterrupted supply.

You gave the control of delivering your newspaper to the agency which has a number of agents to get the job done. You inverted the control or inverted the control of newspaper delivery from Mr. Alfred to the news agency.

**Before you appointed news agency**

*"You hired Alfred to deliver newspaper agent Alfred for delivering newspaper creating a dependency on Alfred."*

**After you appointed a news agency**

Now you have modified the structure of your house accepting a newspaper agency, here Gotham Publications. The newspaper agency has many agents, Alfred can be one of them. So you now ask the agency to get a newspaper agent who in turn delivers the newspaper when you start your morning activities. Thus you removed the tight coupling or dependency that you had with your agent directly.

#How to achieve IOC?
IOC can be achieved in many ways. I would say if by any means you can segregate your code avoiding **tight coupling** and with a defined set of functionality just as in the case of a black-box framework, you have achieved IOC. A few of the approaches that we can follow to achieve IOC:

1. Dependency Injection
2. Factory, etc

The overall takeaway of the blog would be to keep your code segregated and maintain a clear separation of concerns. A segregated code should be reusable and behave as a plugin and plug out component inside your code providing it with input and configurations and letting it perform its actions and give back you the output.

#Inversion of Control while designing Frameworks
Inversion of control could come quite handy while you are designing frameworks. Let us say you are building a mobile app. You are designing a framework that makes certain web service calls and on success provides you back with the Data Model or if encountered with any error handles that by notifying the user.

There are two ways in which you can design the flow of the above functionality:

##Approach 1: Framework consumer takes control of the program flow
##Approach 2: Framework controls the program flow

#Conclusion
Some of the examples help to elevate the dependency injection to that make code testable, maintainable, and extensible.

Dependency Injection. Code that constructs a dependency (what-to-do part) — instantiating and injecting that dependency for the clients when needed, which is usually taken care of by the DI tools such as Swinject (when-to-do-part).
Interfaces. Component client (when-to-do part) — Component Interface implementation (what-to-do part)
Template Design Pattern. Template method when-to-do part — primitive subclass implementation what-to-do part

