# tiqets-assignment
This is my implementation of the assignment for the Sr. iOS Engineer position at Tiqets.

The app is built using `Swift`, `SwiftUI` & `Combine`.

## Architecture
The app is built using an MVVM architecture, where Models & other controllers (business logic) are nested in separate targets (Core & Networking).
This enforces separation of duties & helps mitigate code-spaghettification, but also allows for reuse in other projects.

### Core
Contains most `UseCases` and their implementations, as well as mocks for testing & debugging.
Conform to the assignment, I've included a use case for providing the current `Date`, which is hard-coded to the 1st of June 2021 in Mock implementations. 

### Networking
Contains the config files for API requests as well as mocks for testing & debugging.
I've used my own, open-source, networking package [Netswift](https://github.com/MrSkwiggs/Netswift). 
It's an opinionated framework I've built myself over the last couple of years and have used in my own apps as well as at [OneFit](https://one.fit), which allows me to be very structured but flexible when it comes to implemented an app's networking layer.

## UI

The app has a top-level Tab View for `Offerings` & `Favorites`. It also supports Light & Dark themes.

### Offerings
The app opens on the Offerings tab by default.
![Offerings](https://user-images.githubusercontent.com/6209874/187073507-53ab7ba3-6e6b-402a-8779-2dc0bb075b83.png)

### Favorites
At first, there are no favorites, but the user can easily add & remove them.
![Favorites](https://user-images.githubusercontent.com/6209874/187073571-f0d3d330-1c68-4010-b3cc-102b612e2d85.png)

### Details
Tapping an exhibition/venue navigates to a details page where more information can be seen at a glance.
![Details](https://user-images.githubusercontent.com/6209874/187073683-84a8e4e8-0a37-41bb-9ba5-4b20df500cdb.png)


### Adding / Removing Favorites
Can either be done directly from the listing by tapping the heart-icon or the dedicated button in the details page.
![Edit Favorites](https://user-images.githubusercontent.com/6209874/187073835-af6254f4-6da3-4620-88a1-c38f178b1ff6.png)

This will cause the Favorites tab to update accordingly.
![Favorites with items](https://user-images.githubusercontent.com/6209874/187073877-538dfc51-f471-4720-81f9-fc7a86e90187.png)

### Error Handling & Asynchronous updates
The app is built to handle errors & asynchronous data flows. 

You can try this for yourself by un-commenting the specific Composition roots I have left in the [SceneDelegate](Tiqets/Tiqets/SceneDelegate.swift).

![Delays   Errors](https://user-images.githubusercontent.com/6209874/187074074-1a959e65-f0fc-4dd2-9429-78a850f9ae59.png)

