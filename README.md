# StayAlive


## Indeed Coding Challenge
____________________________________

*Summary*

Create a bubble pop game with a twist: StayAlive implements the tap to pop/dismiss a zombie which falls down screen during game play.
Main bits that were needed for specs.

1. Dots fall at a constant rate and are tappable to dismiss
2. Dots range in a size of 10-100 pixels
3. Dots should not hang off side of screen and fall randomly
4. Dismissing a dot should give the user an inverse pt scale based on the size of the dot

All of these were addressed but modified slightly due to the size of the screen and it not being a desktop app.

Two major pieces were added to aid in providing a bit more complexity to the game.
Another object was added in to the view to act as a way to lose points during game play and a moving health bar was added
in at bottom of screen that utilizes the accelerometer to move it from left to right on the screen. 

![slidermovement](https://user-images.githubusercontent.com/25307091/47432535-fa8bcc00-d763-11e8-997b-c8a2241a2980.gif)

There are levels built into the the stock game play. You'll notice a zombie counter of the top left of the view. Once that goes down to 0 the game speeds up and zombies now fall at a faster rate. 

![image](https://user-images.githubusercontent.com/25307091/47431910-8f8dc580-d762-11e8-9d22-656c7537d773.png)

## Screenshots


###### My Feedback from the challenge

I really enjoyed this challenge. It did take me a little longer than I'd hope due to work loads and losing internet but overall satisfied with the outcome. 

###### Things I'd add if I were building this out more:

- [ ] A way to purchase tickets based on events
- [ ] A way to go deeper into the ticker/event to see what other users at the particular venue had to say
- [ ] A chat functionality to talk to other users/friends prior to events
- [ ] A way to call the venue if needed. Think about page for the venue.

*This list could literally go on forever but these are just some highlights* 

*Note: The app icons in the app are NOT mine and should not be distributed. They are just to be used for demo purposes and not to be used for sale*e
