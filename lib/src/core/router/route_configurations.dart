import 'package:diccon_evo/src/presentation/story/ui/screens/story_list_all.dart';
import 'package:go_router/go_router.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import '../../domain/domain.dart';
import '../../presentation/settings/settings.dart';
import '../core.dart';

GoRouter routerConfig = GoRouter(
  routes: [
    /// Login
    GoRoute(name: "login",path: '/',pageBuilder: (context, state){
      return MaterialPage(child: I18n(child: const SignInView(),));
    }),
    /// Home
    GoRoute(
        name: RouterConstants.home,
        path: '/home',
        //path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(child: I18n(child: const MobileHomeView()));
        },
        routes: [
          // Settings
          GoRoute(
            name: RouterConstants.commonSettings,
            path: 'settings',
            pageBuilder: (context, state) {
              return MaterialPage(child: I18n(child: const SettingsView()));
            },
            routes: [
              GoRoute(
                name: RouterConstants.dictionaryPreferences,
                path: 'dictionary-preferences',
                pageBuilder: (context, state) {
                  return MaterialPage(child: I18n(child: const DictionaryPreferences()));
                },
              ),
              GoRoute(
                name: RouterConstants.releaseNotes,
                path: 'release-notes',
                pageBuilder: (context, state) {
                  return MaterialPage(child: I18n(child: const ReleaseNotes()));
                },
              ),
            ]
          ),
          // Settings
          GoRoute(
            name: RouterConstants.mobileUserSettings,
            path: 'user-settings',
            pageBuilder: (context, state) {
              return MaterialPage(child: I18n(child: const MobileUserSettingsView()));
            },
          ),
          // Settings
          GoRoute(
            name: RouterConstants.infos,
            path: 'infos',
            pageBuilder: (context, state) {
              return MaterialPage(child: I18n(child: const InfoView()));
            },
          ),
        ]),

    /// Dictionary
    GoRoute(
        name: RouterConstants.dictionary,
        path: '/dictionary',
        pageBuilder: (context, state) {
          return MaterialPage(child: I18n(child: const DictionaryView()));
        },
        routes: [
          GoRoute(
            name: RouterConstants.wordHistory,
            path: 'history',
            pageBuilder: (context, state) {
              return MaterialPage(child: I18n(child:  const WordHistoryView()));
            },
          ),

        ]),

    /// Conversation
    GoRoute(
      name: RouterConstants.conversation,
      path: '/conversation',
      pageBuilder: (context, state) {
        return MaterialPage(child: I18n(child: const ConversationView()));
      },
    ),

    /// Reading-chamber
    GoRoute(
      name: RouterConstants.readingChamber,
      path: '/reading-chamber',
      pageBuilder: (context, state) {
        return MaterialPage(child: I18n(child: const StoryListView()));
      },
      routes: [
        // Reading chamber's reading space
        GoRoute(
            name: RouterConstants.readingSpace,
            path: 'reading-space',
            pageBuilder: (context, state) {
              return MaterialPage(
                  child: I18n(
                    child: StoryReadingView(
                      story: state.extra as Story,
                    ),
                  ));
            }),
        // All stories
        GoRoute(
            name: RouterConstants.readingChamberAllList,
            path: 'reading-space-all-list',
            pageBuilder: (context, state) {
              return MaterialPage(
                  child: I18n(
                    child: const StoryListAllView(),
                  ));
            }),
        // Reading history
        GoRoute(
          name: RouterConstants.readingChamberHistory,
          path: 'history',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: I18n(
                  child: const StoryListHistoryView(),
                ));
          },
        ),
        // Reading bookmarks
        GoRoute(
          name: RouterConstants.readingChamberBookmark,
          path: 'bookmarks',
          pageBuilder: (context, state) {
            return MaterialPage(
              child: I18n(
                child: const StoryListBookmarkView(),
              ),
            );
          },
        ),
      ],
    ),


    /// Essential 1848
    GoRoute(
        name: RouterConstants.essential1848,
        path: '/essential-1848',
        pageBuilder: (context, state) {
          return MaterialPage(child: I18n(child: const EssentialView()));
        },
        routes: [
          GoRoute(
            name: RouterConstants.learningFlashCard,
            path: 'flash-card',
            pageBuilder: (context, state) {
              var params = state.extra as LearningView;
              return MaterialPage(
                  child: I18n(
                      child: LearningView(
                        topic: params.topic,
                        listEssentialWord: params.listEssentialWord,
                      )));
            },
          ),
          GoRoute(
            name: RouterConstants.learningFavourite,
            path: 'favourite',
            pageBuilder: (context, state) {
              var params = state.extra as FavouriteReviewView;
              return MaterialPage(
                  child: I18n(
                      child: FavouriteReviewView(
                        listEssentialWord: params.listEssentialWord,
                      )));
            },
          ),
        ]),
  ],
);
