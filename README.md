# Pantry Party
At Cal Hacks 5.0, we developed Pantry Party, an iOS app that conveniently allows users to be automatically notified when their groceries are about to expire.

## What Our App Does
We wanted to create a convenient way for users to minimize their food waste, allowing them to save money while improving the sustainability of our environment. We decided that we needed to focus on making it as convenient as possible for users so that they would continue to use it.

With our app, users can simply take a picture of their grocery receipt after making their purchase, and Pantry Party will automatically take note of what was purchased, and set reminders for when a product is about to expire. Additionally, when products are about to expire, recipes utilizing those products will be recommended.

## What We Did
### Optical Character Recognition
To implement our receipt reader, we used Google's **Cloud Vision API** and **ML Kit** so we could use **Optical Character Recognition (OCR)** on our images. This converted the image into text, which we then compared to a database containing expiration data.

### Database
For our database, we used Google's **Cloud Firestore** database. In this database, we stored information about each product's *expiration length*, *expiration date*, and *purchase date* based on online research. We compared each text output from the OCR to our database, and if the word was a product that matched a product in the database, then the *expiration date* and *purchase date* for that product would be updated in realtime.
