import 'package:go_router/go_router.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import '../../domain/domain.dart';
import '../../presentation/story/ui/screens/story_list_all.dart';
import '../core.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorSettingKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellSetting');
final _shellNavigatorDictionaryKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellDictionary');
final _shellNavigatorLibraryKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellLibrary');
final _shellNavigatorConversationKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellConversation');
final _shellNavigatorEssentialKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellEssential');
final _shellNavigatorAboutKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellAbout');



GoRouter routerConfigDesktop = GoRouter(
  initialLocation: Properties.instance.settings.selectedTab,
  navigatorKey: _rootNavigatorKey,
  routes: [
    /// Login
    GoRoute(
        name: "login",
        path: '/',
        pageBuilder: (context, state) {
          return NoTransitionPage(
              child: I18n(
            child: const LoginView(),
          ));
        }),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // the UI shell
        return NavigationSwitchView(navigationShell: navigationShell);
      },
      branches: [
        // dictionary branch
        StatefulShellBranch(
          navigatorKey: _shellNavigatorDictionaryKey,
          routes: [
            // top route inside branch
            GoRoute(
              name: RouterConstants.dictionary,
              path: RoutePath.dictionary,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: I18n(child: const DictionaryView()));
              },
              routes: [
                GoRoute(
                  name: RouterConstants.wordHistory,
                  path: 'history',
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                        child: I18n(child: const WordHistoryView()));
                  },
                ),
              ],
            ),
          ],
        ),
        // library branch
        StatefulShellBranch(
          navigatorKey: _shellNavigatorLibraryKey,
          routes: [
            // top route inside branch
            GoRoute(
              name: RouterConstants.readingChamber,
              path: RoutePath.readingChamber,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: I18n(child: const StoryListView()));
              },
              routes: [
                // Reading chamber's reading space
                GoRoute(
                    name: RouterConstants.readingSpace,
                    path: 'reading-space',
                    pageBuilder: (context, state) {
                      return NoTransitionPage(
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
                    return NoTransitionPage(
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
                    return NoTransitionPage(
                      child: I18n(
                        child: const StoryListBookmarkView(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        // conversation branch
        StatefulShellBranch(
          navigatorKey: _shellNavigatorConversationKey,
          routes: [
            // top route inside branch
            GoRoute(
              name: RouterConstants.conversation,
              path: RoutePath.conversation,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: I18n(child: const ConversationView()));
              },
              routes: const [],
            ),
          ],
        ),
        // essential branch
        StatefulShellBranch(
          navigatorKey: _shellNavigatorEssentialKey,
          routes: [
            // top route inside branch
            GoRoute(
              name: RouterConstants.essential1848,
              path: RoutePath.essential,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: I18n(child: const EssentialView()));
              },
              routes: [
                GoRoute(
                  name: RouterConstants.learningFlashCard,
                  path: 'flash-card',
                  pageBuilder: (context, state) {
                    if (state.extra == null) return NoTransitionPage(child: I18n(child: const PageErrorView()));
                    var params = state.extra as LearningView;
                    return NoTransitionPage(
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
                    return NoTransitionPage(
                        child: I18n(
                            child: FavouriteReviewView(
                      listEssentialWord: params.listEssentialWord,
                    )));
                  },
                ),
              ],
            ),
          ],
        ),
        // setting branch
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSettingKey,
          routes: [
            // top route inside branch
            GoRoute(
              name: RouterConstants.commonSettings,
              path: '/settings',
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: I18n(child: const SettingsView()));
              },
              routes: [
                GoRoute(
                  name: RouterConstants.dictionaryPreferences,
                  path: 'dictionary-preferences',
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                        child: I18n(child: const DictionaryPreferences()));
                  },
                ),
              ],
            ),
          ],
        ),
        // about branch
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAboutKey,
          routes: [
            // top route inside branch
            GoRoute(
              name: RouterConstants.infos,
              path: '/infos',
              pageBuilder: (context, state) {
                return NoTransitionPage(child: I18n(child: const InfoView()));
              },
              routes: [
                GoRoute(
                  name: RouterConstants.releaseNotes,
                  path: 'release-notes',
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                        child: I18n(child: const ReleaseNotes()));
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    //   /// Home
    //   GoRoute(
    //       name: RouterConstants.home,
    //       path: '/home',
    //       pageBuilder: (context, state) {
    //         return NoTransitionPage(child: I18n(child: const HomeView()));
    //       },
    //       routes: [
    //         // Settings
    //         GoRoute(
    //           name: RouterConstants.userSettings,
    //           path: 'user-settings',
    //           pageBuilder: (context, state) {
    //             return NoTransitionPage(child: I18n(child: const UserSettingsView()));
    //           },
    //         ),
    //       ]),
    //
  ],
  errorBuilder: (context, state){
    return
         I18n(child: const PageErrorView());
  }
);
