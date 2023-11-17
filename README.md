# Diccon Dictionary (Vietnamese - English) ☃️
Welcome to our immersive chat-based vietnamese - english dictionary! Dive into a world of words where learning is engaging and interactive. 

Our chat bot is here to assist you in discovering new words, meanings, and contexts. 
Explore our reading room to expand your vocabulary and comprehension, then head over to our practice room to reinforce your learning through interactive exercises. 

Let's embark on a linguistic journey together!


[![Microsoft Store](https://img.shields.io/badge/Microsoft_Store-0078D4?style=for-the-badge&logo=microsoft&logoColor=white)](https://www.microsoft.com/store/apps/9NPF4HBMNG5D)
[![Play Store](https://img.shields.io/badge/Google_Play-414141?style=for-the-badge&logo=google-play&logoColor=white)](https://play.google.com/store/apps/details?id=com.zeroboy.diccon_evo)

## 2 steps before running the project
### Step 1:
Make sure to have a OpenAI API key to get chat-bot and AI dictionary working as expected.

You can have a free try API key by go to their website at: https://platform.openai.com/api-keys 

Once you have your key, create a ``.env`` file (with no name, just .env) in project and put the key in the file with format:
```bash
OPENAI_API_KEY = your-open-api-key-here
```
### Step 2:
Clean and get packages dependency:
```bash
flutter clean
```
```bash
flutter pub get
```
Run the following command to make sure models are generated:
```bash
dart run build_runner build --delete-conflicting-outputs
```
Now everything should work !
Run the following command to build project:
```bash
flutter run
```
## Support
You can support us by downloading the application & leave us feedback. Optionally, you can purchase add-ons in Spooky to try different features as well as support us.

## License
Spooky is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.