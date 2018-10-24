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

###### GamePlay
_______________________________________

Initial flow of game is you have the start screen which will show the previous score once you have died or restart the game.
In the game the goal is to "STAY ALIVE". Zombies will fall from the top attempting to attack you. You can tap on the zombies to kill/dismiss them but if you hit a zombie you will lose points based on their size. Larger zombies less points than smaller ones. The bar on the bottom is moved with the tilting of the device. The bar also adds the capability to regain 10points to your health as the game gets harder you will need all you can get. If the user decides the game is to hard upfront they can adjust the game speed by themselves but once done this takes the user out of the level aspect of the game and provides more of a free game play. If user plays in levels each level consists of getting past 20 zombies. After 20 zombies have fallen the game speeds up but so does how fast the zombies attack. Game allows the user to pause the game to restart or resume from where they left off.

![image](https://user-images.githubusercontent.com/25307091/47433083-4723d700-d765-11e8-8dda-fce7c5d9c802.png)

If the user dies you'll get a lovely parting gift.

![image](https://user-images.githubusercontent.com/25307091/47433141-66baff80-d765-11e8-843f-711933cbac02.png)

###### My Feedback from the challenge

I really enjoyed this challenge. I for one have never used SpriteKit but decided to give it a shot. I think overall it turned out pretty good.

###### Things I'd add if I were building this out more:

- [ ] Adding in another level of animations on the zombie when they are tapped
- [ ] Sound to the game
- [ ] More aspects to how the levels work and maybe adding in different characters so that if a user taps on say a human      that comes through vs a zombie they can gain another life or maybe removing the health bar and adding in immunity shots or health icons that give the user health vs the bar at the bottom.

*This list could literally go on forever but these are just some highlights* 
