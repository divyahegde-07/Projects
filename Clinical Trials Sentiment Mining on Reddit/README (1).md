
# Clinical Trials Sentiment Mining on Reddit - Divya Hegde

## Setup 

You can execute the .ipynb file on the repository by opening and executing the file on Jupyter, or VSCode, or Google Colab.
Please take the values of clientId, client secret, and OpenAI API key etc., from the shared Google Doc link. Doing so to keep my credentials safe.

Libraries like PRAW, emoji, and textblob, and wordcloud are pip installed in the notebook.

## Methodolgy and Challenges

### Web Scraping 
An app was created on Reddit whose generated client Id and client secret is used to create an instance of Reddit to fetch the posts and comments of a particular subreddit. This is done using the PRAW library which is Python Reddit API Wrapper - a Python package that allows easy access to Reddit's API.

The result of this scraping are two dataframes - 
- one with title of the post, description of the post, and number of upvotes
- other one with mapped title number, usernames, comments on each of these users on all the posts.

### Performing Sentiment Analysis on comments
Only the comments dataframe was used to perform sentiment analysis on. Per the usual process of performing sentiment analysis, the comments were cleaned to make all the words lowercase, numbers, emojis, characters, URLs were removed before lemmatizing.
The only difference with this project and any other sentiment analysis task is that we are trying to predict the sentiment of users towards clinical trials. So it is important to make sure that negating words like - not, no, never etc., needs to be removed from the stopwords library before lemmatizing. 

After cleaning the comments and lemmatizing, I took the approach of using TextBlob and VADER libraries.

I stuck to using VADER because it does a good job on social media texts. More so, from the perspective of building a generic tool that analyses sentiments based on defined topic.

A function is written to calculate the weighted score of the sentiment using the overall sentiment provided by VADER and counting the occurences of keywords defined for clinical trials.
The weighted sum is the total count of keyword appearnces multiplied by the overall sentiment score. This score is normalized to prevent bias towards longer texts.

Using this weighted score, positive sentiment towards is considered as anything > 0, negative is when the score is < 0 and neutral is 0.
We take the positively and negatively scored comments (raw, uncleaned comment) and feed that to OpenAI chat.completions.create API to generate the custom response for us. I'm using *gpt-3.5-turbo* model with roles of user and system, where user is the text comment and system role is defined using content value - *You will be given a comment from a user, after understanding the content of the text, generate custom message for participation in clinical trial. Keep it less than 75 words*


## Obstacles and future work

- Since we are scraping Reddit posts and comments, there is a lot of noise in data. 
- I did try the approach of syntesizing comments that were directly and indirectly in relation to clinical trials to train a model. But since the synthesized data was too clean and positive, most of the predictions of sentiments were positive. 
- If we can get a clean labelled set of data, then i'm quite confident that this generic approach would perform much better. 
- Maybe another approach could be to have analysed the main dataframe with titles and description? Again, this is all experimental but I wanted to keep it generic.
- Some of ethical considerations are making sure the Reddit's API policies are respected.
- Also, since we are dealing with personal and medical information, we adhere to data privacy laws.



## Results

### Positive sentiment results

![Screenshot 1](https://raw.githubusercontent.com/divyahegde-07/Projects/main/Clinical%20Trials%20Sentiment%20Mining%20on%20Reddit/Screenshots/Screenshot%202024-05-14%20at%2023.52.25.png)

![Screenshot 2](https://raw.githubusercontent.com/divyahegde-07/Projects/main/Clinical%20Trials%20Sentiment%20Mining%20on%20Reddit/Screenshots/Screenshot%202024-05-14%20at%2023.53.57.png)

![Screenshot 3](https://raw.githubusercontent.com/divyahegde-07/Projects/main/Clinical%20Trials%20Sentiment%20Mining%20on%20Reddit/Screenshots/Screenshot%202024-05-14%20at%2023.55.02.png)

### Negative sentiment results


![Screenshot 3](https://raw.githubusercontent.com/divyahegde-07/Projects/main/Clinical%20Trials%20Sentiment%20Mining%20on%20Reddit/Screenshots/Screenshot%202024-05-14%20at%2023.57.59.png)

![Screenshot 3](https://raw.githubusercontent.com/divyahegde-07/Projects/main/Clinical%20Trials%20Sentiment%20Mining%20on%20Reddit/Screenshots/Screenshot%202024-05-14%20at%2023.58.46.png)

The first screenshot is predicted as negative although the overall tone is positive. Most likely its because of the cuss words.