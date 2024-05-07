
# Closet Companion

Design and develop a clothing recommendation system that provides personalized clothing suggestions to users based on their preferences, style, and other relevant factors.​

The goal is to create a scalable system that enhances the shopping experience for users by offering tailored recommendations, ultimately increasing customer satisfaction, engagement and retention.​

9105 products, 102988 users, 249271 reviews​.
Product dataset: Details about data such as designer name, length, price, average rating, and several features detailing the product’s design​.

Review dataset: Utilized it to gather user information and user features such as body type, height, weight, size (US), bust size and the user's product rating and product fit.​


## Collaborative Filtering

Predict the ratings of unrated products based on how other users have rated similar products .
Construct a matrix with users as indices and products as columns with ratings of user-products filled in.​

Fill in unrated products as 0​.

Perform Singular Value Decomposition for the ratings matrix .

U represents the relationship between users and latent features (product ratings)​.

D is a diagonal matrix that represents the importance of the latent features​.

VT represents the relationship between products and latent features (user ratings)​.

R = U.D.VT results in a matrix of user x product with approximate ratings for each products​.

Recommendation is then given based on top-unrated products for the given user.

This can also be interpreted as "Products you may also like".

![Ratings Based Collaborative Filtering](https://raw.githubusercontent.com/divyahegde-07/Projects/main/Closet%20Companion/Ratings-based%20collab.png)

## Content based Filtering

Find similar products to those that user has purchased/rated before​.
For each product given on the website, identify the essential attributes associated.​

Each attribute except Product ID is standardized​.

Feature Compression techniques are utilized to reduce the dimensionality​.

Pairwise Product Cosine similarity is calculated on the compressed features to find the top similar products​.

Recommendation is then provided like so:

- Find the top-rated products from user's history​.

- Find and suggest most similar products.  ​

- In case the user is viewing a item, find products most similar to the current item.

- Utilize SVD ratings to sort the products and recommend in the order of maximum ratings​.

This can also be interpreted as "Based on your purchase history".

![Content Based Filtering](https://raw.githubusercontent.com/divyahegde-07/Projects/main/Closet%20Companion/Content%20based.png)

## User attribute based recommendation
Users with similar body attributes such as height, weight and other features may prefer similar fitting products​.

Utilize cosine similarity to find similar users and then find the top products based on their purchases.

Find all products from top similar users​.

Utilize SVD ratings from collaborative filtering to rank the products.

Recommend the top 'n' products based on maximum ratings.

Can be interpreted as "Similar users also liked"

![User Similarity Based Filtering](https://raw.githubusercontent.com/divyahegde-07/Projects/main/Closet%20Companion/User%20similarity%20based.png)
