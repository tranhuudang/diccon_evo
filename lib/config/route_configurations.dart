import 'package:diccon_evo/config/route_constants.dart';
import 'package:diccon_evo/screens/conversation/ui/conversation.dart';
import 'package:diccon_evo/screens/dictionary/ui/dictionary_preferences.dart';
import 'package:diccon_evo/screens/dictionary/ui/dictionary.dart';
import 'package:diccon_evo/screens/dictionary/ui/word_history.dart';
import 'package:diccon_evo/screens/essential/ui/essential_3000.dart';
import 'package:diccon_evo/screens/essential/ui/favourite_review.dart';
import 'package:diccon_evo/screens/essential/ui/learning.dart';
import 'package:diccon_evo/screens/home/ui/home.dart';
import 'package:diccon_evo/screens/settings/ui/infos.dart';
import 'package:diccon_evo/screens/settings/ui/login.dart';
import 'package:diccon_evo/screens/settings/ui/release_notes.dart';
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
import '../screens/dictionary/bloc/word_history_bloc.dart';

GoRouter router = GoRouter(
  routes: [
    /// Login
    GoRoute(name: "login",path: '/',pageBuilder: (context, state){
      return MaterialPage(child: I18n(child: const LoginView(),));
    }),
    /// Home
    GoRoute(
        name: RouterConstants.home,
        path: '/home',
        pageBuilder: (context, state) {
          return MaterialPage(child: I18n(child: const HomeView()));
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
            name: RouterConstants.userSettings,
            path: 'user-settings',
            pageBuilder: (context, state) {
              return MaterialPage(child: I18n(child: const UserSettingsView()));
            },
          ),
          // Settings
          GoRoute(
            name: RouterConstants.infos,
            path: 'infos',
            pageBuilder: (context, state) {
              return MaterialPage(child: I18n(child: const InfosView()));
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
              var wordHistoryBloc = state.extra as WordHistoryBloc;
              return MaterialPage(child: I18n(child:  WordHistoryView(wordHistoryBloc: wordHistoryBloc,)));
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
