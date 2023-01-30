# ExchangeApp

## Introduction
The goal is to develop a small exchange app which make simple currency conversion.
The user submits the image using his camera or a photo from his library, the app will submit the image to plant.net API and display a list containing the results to the user.

 It has three screens:
 - Screen#1
    User selects the source and the target currency for the conversion and enters the source amount to be converted. ‘Calculate’ button makes api call to receive the target amount as well as conversion rate.
    
- Screen#2
    The calculated amount is shown to the user and a timer starts which starts counting from 30.
    Scenario 1: User continues with the task by tapping ‘Convert’ button which leads to screen#3.
    Scenario 2: User waits 30 seconds user until she/he is asked to start from the beginning. 
    
- Screen#3
    Mission accomplished! ‘Done’ button should take user to Screen#1
    
    
## Technical Details
This project is build using the VIPER design pattern.

## VIPER Component
    - View
    Class that has all the code to show the app interface to the user and get their responses. Upon receiving a response View alerts the Presenter.
    - Interactor
    Has the business logic of an app. e.g if business logic depends on making network calls then it is Interactor’s responsibility to do so.
    - Presenter
     It gets user response from the View and works accordingly. The only class to communicate with all the other components. Calls the router for wire-  framing, Interactor to fetch data (network calls or local data calls), view to update the UI.
    - Entity
    Contains plain model classes used by the Interactor.
    - Router
    Does the wire-framing. Listens from the presenter about which screen to present and executes that.
