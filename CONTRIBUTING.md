## Contributing
Not only developers but also those from medical field, those who are interested in health, and artists can contribute Save Lives.

The following are the features that even non-developers can contribute.

### Adding more contents
This app contains first aids that people should know, and survival tips in cases of disasters. Users learn those first aids and survival tips and use those valuable knowledge to save lives.

This app now have a reasonable amount of contents of first aids and survival tips, however, adding more knowledge that can save lives, make this app more helpful to people.

Not only developers but also those from medical fields and those who are interested in health can contribute to add new contents.

How to add a new content?

Add the contents in dataContent.txt in the dataContent folder. Optionally, you can provide a description of the First aids or survival tip.

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

You can see example content data in dataContent.txt file for reference purpose. Thanks for your interest in contributing.

### Improving illustrations

Artists can contribute by drawing Illustrations, too. You can see this app use many Illustrations for more expressive UI. You can improve existing Illustrations to be more expressive, attractive and clear. In drawing illustrations, please make sure the image's dimension is square. The maintainer of this repo will provide proper credit to the artists.

## Setting up development environment
After setting up the development environment, you can start contributing. (only for developers)
### 1. YouTube
If you plan to contribute the YouTube video feature, you need a YouTube API just for contributing purpose. However if your contribution is not about that Youtube feature, you don't need the API key. You can skip the following steps.
1. Register at their website to get a free API key.
2. Create /lib/common/sensitiveDatas.dart. Add the following codes to the file.
```
String ytApiKey = "[YOUR API KEY HERE]";
```
sensitiveDatas.dart is git-ignored. So it is not checked into public.

### 2. Testing in release build
If you plan to build and test the release apk, you need to sign the app with your own signature. You can use the keystore and key.properties files from your previous Android project. But if you don't have those, you can create ones as described [here.](
https://flutter.dev/docs/deployment/android#signing-the-app)
1. Rename your keystore file to key.jks and place it at /android/app/ directory.
2. Place key.properties file at /android/ directory. It should look like this
```
storePassword= [STORE PASSWORD HERE]
keyPassword= [KEY PASSWORD HERE]
keyAlias=key
storeFile=key.jks
```
key.jks and key.properties are git-ignored. So they are not checked into public.

### Code refactoring
You can refactor the codes. Improving to a better coding style that mostly follow possible best practices, and removing unnecessary and unused codes, really improve the codes' quality and maintainability.