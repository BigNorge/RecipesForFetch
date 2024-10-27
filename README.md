# RecipesForFetch

### Steps to Run the App

Clone the repository. Open Recipes.xcodeproj in Xcode. Select either a device or simulator. Select Product -> Run to run the app. The minimum deployment tareger is iOS 16.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I focussed on the user experience. Of course there were other considerations. I tried to make the code readable for future developers. Code is read far more often than it is written. I tried to make it performant. This also benefits the user. There is no reason the code should do anything more than the user requires. 

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent about five or six hours on the project requirements. I spent a little more time adding the info button, YouTube button and sorting feature. 

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I initially thought a Picker would be the better option for sorting. After some trial and error I decided I didn't understand pickers as well as I would like and decided not to invest the time to understand them for this project. I decided it was simpler to use a boolean as there are just two obvious sorting options. If additional sorting options were added, it would be time to implement a Picker.

### Weakest Part of the Project: What do you think is the weakest part of your project?

I could have spent more time trying to make the view model more testable. It might have made the function more complicated to do so. I have unit tests but I could have investigated further.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?

I relied on Apple's libraries, specifically SwiftUI

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

There is no visual indication for refetching the recipes. Pull to refresh will fetch all recipes. I decided that was an industry standard mechanism so there are no extra indicators to clutter the UI.
