## Contributing
Not only developers but also those from medical field, those who are interested in health, and artists can contribute Save Lives.

The following are the features that even non-developers can contribute.

### Adding more contents
This app contains first aids that people should know, and survival tips in cases of disasters. Users learn those first aids and survival tips and use those valuable knowledge to save lives.

This app now have a reasonable amount of contents of first aids and survival tips, however, adding more knowledge that can save lives, make this app more helpful to people.

Not only developers but also those from medical fields and those who are interested in health can contribute to add new contents.

How to add a new content?

Add the contents in `dataContent.txt` in the `dataContent` folder. Optionally, you can provide a description of the First aids or survival tip.

As contents,
- the title of the first aid,
- at least one YouTube video and one webpage where procedures to perform a first aid are presented and
- a brief summary of the first aid, need to be provided.

You can provide more than one YouTube videos and webpages.

For a YouTube video, provide:
- URL of the video,
- Title of the video and
- Youtube channel name of the video

Similarly, for a webpage, provide:
- URL of the webpage and
- title of the page

Lastly, provide a brief summary that you wrote yourself or got from the internet. This summary help users to memorize the first aids or survival tips in brief words.

You can see example content data in `dataContent.txt` file for reference purpose. Thanks for your interest in contributing.

### Improving illustrations

Artists can contribute by drawing Illustrations, too. You can see this app use many Illustrations for more expressive UI. You can improve existing Illustrations to be more expressive, attractive and clear. In drawing illustrations, please make sure the image's dimension is square. You can send the illustrations to `heinsek@pm.me`. The maintainer of this repo will provide proper credit to the artists. In sending email, please provide some informations like your socials or your website so that my app can share credits to you.

## Setting up development environment (only for developers)
After setting up the development environment, you can start contributing.

### 1. Firebase
I use Cloud Firestore for app update mechanism without the use of Google Play, and Firebase Analytics for analytics purpose, in this project. In order to be able to run this project, you need to follow these 3 steps below.

1. Go to Firebase console and create a new Firebase project. You can name it as you like.
2. Add the Android app to the projecct by entering the package name `com.heinsek.save_lives`. Download the `google-services.json` file it shows and place it at `/android/app/` directory.
3. Go back to the console and click Cloud Firestore tab. And create a new Firestore database. Choose `test mode` when asked and leave other inputs like database location as its default values. After having done creating the database, you will be able to run the app.

It is okay to delete the Firebase project you just created when you have done contributing Save Lives. You can create another new Firebase project when you are about to contribute it again. 

### 2. YouTube

1. Create `/lib/common/sensitiveDatas.dart`. Add the following codes to the file.
```
final String ytApiKey = "[YOUR API KEY HERE]";
```
2. If you plan to contribute the YouTube video feature, you need a YouTube API just for contributing purpose. However if your contribution is not about that Youtube feature, you don't need an API key. You can leave the value of API key as it is. By the way, you can get a free Youtube API as described [here.](https://developers.google.com/youtube/v3/getting-started)

Notice that `google-services.json` and `sensitiveDatas.dart` are git-ignored because they contain sensitive data like your API key. So they are not checked into public.

If there is anything inconvenient in contributing, you can contact heinsek@pm.me or [my Facebook](https://www.facebook.com/HeynSekk).

**Thanks for your interest in contribution. Wish you have a nice day.**