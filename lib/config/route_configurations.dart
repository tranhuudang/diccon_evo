import 'package:diccon_evo/screens/conversation/ui/conversation.dart';
import 'package:diccon_evo/screens/dictionary/ui/custom_dictionary.dart';
import 'package:diccon_evo/screens/dictionary/ui/dictionary.dart';
import 'package:diccon_evo/screens/dictionary/ui/word_history.dart';
import 'package:diccon_evo/screens/essential/ui/essential_3000.dart';
import 'package:diccon_evo/screens/essential/ui/favourite_review.dart';
import 'package:diccon_evo/screens/essential/ui/learning.dart';
import 'package:diccon_evo/screens/home/ui/home.dart';
import 'package:diccon_evo/screens/settings/ui/infos.dart';
import 'package:diccon_evo/screens/settings/ui/settings.dart';
import 'package:diccon_evo/screens/settings/ui/user_settings.dart';
import 'package:diccon_evo/screens/story/ui/story_bookmark.dart';
import 'package:diccon_evo/screens/story/ui/story_history.dart';
import 'package:diccon_evo/screens/story/ui/story_list.dart';
import 'package:diccon_evo/screens/story/ui/story_reading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i18n_extension/i18n_widget.dart';

import '../data/models/story.dart';

GoRouter router = GoRouter(
  routes: [
    /// Home
    GoRoute(
        name: 'home',
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(child: I18n(child: const HomeView()));
        },
        routes: [
          // Settings
          GoRoute(
            name: 'common-settings',
            path: 'settings',
            pageBuilder: (context, state) {
              return MaterialPage(child: I18n(child: const SettingsView()));
            },
          ),
          // Settings
          GoRoute(
            name: 'user-settings',
            path: 'user-settings',
            pageBuilder: (context, state) {
              return MaterialPage(child: I18n(child: const UserSettingsView()));
            },
          ),
          // Settings
          GoRoute(
            name: 'infos',
            path: 'infos',
            pageBuilder: (context, state) {
              return MaterialPage(child: I18n(child: const InfosView()));
            },
          ),
        ]),

    /// Dictionary
    GoRoute(
        name: 'dictionary',
        path: '/dictionary',
        pageBuilder: (context, state) {
          return MaterialPage(child: I18n(child: const DictionaryView()));
        },
        routes: [
          GoRoute(
            name: 'word-history',
            path: 'history',
            pageBuilder: (context, state) {
              return MaterialPage(child: I18n(child: const WordHistoryView()));
            },
          ),
          GoRoute(
            name: 'custom-dictionary',
            path: 'custom',
            pageBuilder: (context, state) {
              return MaterialPage(child: I18n(child: const CustomDictionary()));
            },
          ),
        ]),

    /// Conversation
    GoRoute(
      name: 'conversation',
      path: '/conversation',
      pageBuilder: (context, state) {
        return MaterialPage(child: I18n(child: const ConversationView()));
      },
    ),

    /// Reading-chamber
    GoRoute(
      name: 'reading-chamber',
      path: '/reading-chamber',
      pageBuilder: (context, state) {
        return MaterialPage(child: I18n(child: const StoryListView()));
      },
      routes: [
        // Reading chamber's reading space
        GoRoute(
            name: 'reading-chamber-to-reading-space',
            path: 'reading-space',
            pageBuilder: (context, state) {
              return MaterialPage(
                  child: I18n(
                child: StoryReadingView(
                  story: state.extra as Story,
                ),
              ));
            }),
        // Reading history
        GoRoute(
          name: 'reading-chamber-history',
          path: 'history',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: I18n(
              child: const StoryListHistoryView(),
            ));
          },
          routes: [
            GoRoute(
              name: 'history-to-reading-space',
              path: 'reading-space',
              pageBuilder: (context, state) {
                return MaterialPage(
                  child: I18n(
                    child: StoryReadingView(
                      story: state.extra as Story,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        // Reading bookmarks
        GoRoute(
          name: 'reading-chamber-bookmark',
          path: 'bookmarks',
          pageBuilder: (context, state) {
            return MaterialPage(
              child: I18n(
                child: const StoryListBookmarkView(),
              ),
            );
          },
          routes: [
            GoRoute(
                name: 'bookmark-to-reading-space',
                path: 'reading-space',
                pageBuilder: (context, state) {
                  return MaterialPage(
                    child: I18n(
                      child: StoryReadingView(
                        story: state.extra as Story,
                      ),
                    ),
                  );
                })
          ],
        ),
      ],
    ),

    /// Essential 1848
    GoRoute(
        name: 'essential-1848',
        path: '/essential-1848',
        pageBuilder: (context, state) {
          return MaterialPage(child: I18n(child: const EssentialView()));
        },
        routes: [
          GoRoute(
            name: 'learning-flash-card',
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
            name: 'learning-favourite',
            path: 'favourite',
            pageBuilder: (context, state) {
              var params = state as FavouriteReviewView;
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
