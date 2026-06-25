# Flutter Application — Architecture & Code Review

> Companion to the backend reviews in the repo root. Scope: `flutter_app/` (Dio, BLoC scaffold, get_it, go_router, Hive, video_player/media_kit).
> **Date:** 2026-06-23

## TL;DR — The One Thing You Must Know

The project contains **two parallel, mutually exclusive codebases**:

1. **The app that actually runs** — `lib/main.dart`, a **2,162-line single-file monolith** with its *own* `Api` client (on `SharedPreferences`), `StatefulWidget` + `setState` + `FutureBuilder`, and inline `ThemeData`. Its own header comment says it is *"Independent of the older half-built screens/blocs (still in lib/, not imported)."*

2. **The clean-architecture scaffold** — `presentation/blocs/*` (9 BLoCs), `data/repositories/*`, `data/models/*` (freezed), `core/di/injection.dart` (get_it), `core/router/app_router.dart` (go_router), `core/theme/app_theme.dart`. This is **dead code**: `configureDependencies()` is never called, nothing in `main.dart` imports it, and it **does not compile** — `injection.dart` calls `ApiService(settingsBox:)` while the class exposes `ApiService._(storage, logger)`, and `content_repository.dart` calls `_api.getBanners()` / `getContent(contentId)` returning decoded JSON while the real `ApiService` returns Dio `Response` objects with `int` ids.

**So every item on your checklist has a split verdict:** the *scaffold* implements the pattern (often well), but the *running app* implements none of them. You must first decide which codebase is the product. Everything below is framed around that decision.

---

## Checklist Verdicts

| Aspect | Running app (`main.dart`) | Scaffold (`presentation/`, `data/`, `core/`) | Verdict |
|--------|---------------------------|-----------------------------------------------|---------|
| **Clean Architecture** | None — UI, networking, models, business logic all in one file | Layered (data/domain-ish/presentation/core) | Scaffold-only, **not in effect** |
| **MVVM** | No — `setState` | BLoC is MVI/MVVM-ish | Not in effect |
| **BLoC** | Not used | 9 BLoCs with events/states | Present but **unwired** |
| **Riverpod** | **Not used anywhere; not a dependency** | — | N/A — app uses BLoC + get_it |
| **State Management** | `setState` + `FutureBuilder`, refetch on every nav | BLoC | Two paradigms; only `setState` runs |
| **Dependency Injection** | Global `late final Api api` singleton | get_it (`injection.dart`) | DI **never initialized**; won't compile |
| **API Layer** | `Api` on `SharedPreferences`, returns decoded JSON | `ApiService` on secure storage, returns `Response`, `int` ids | **Three divergent contracts** |
| **Repository Pattern** | None (Dio called from widgets) | Clean repos, but uncompilable + no error mapping | Scaffold-only |
| **Offline Support** | None | None (Hive boxes opened, never read/written) | **Absent** |
| **Error Handling** | try/catch → `friendly(e)` + `ErrorView` retry (decent UX) | Repos let exceptions propagate raw; `dartz` unused | Inconsistent |
| **Responsive Design** | **Zero** `MediaQuery`/`LayoutBuilder`; fixed px | Some `LayoutBuilder`/`NavigationRail` | Running app **not responsive** |
| **Tablet Support** | Phone layout stretched | Intended (NavigationRail) but dead | **Effectively none** |
| **Performance** | `Image.network` (no cache), `Future.wait` blocks home, repeated JWT decode | n/a (unused) | Multiple issues |
| **Memory Leaks** | Controllers in players/timers disposed ✓; several `TextEditingController`s **not disposed** | n/a | Minor leaks |

---

## 1. Clean Architecture
**Status:** scaffold exists but is dead; running app has none.
The folder layout (`core/`, `data/models|repositories`, `presentation/blocs|screens|widgets`) is a textbook Clean/feature structure — but `main.dart` bypasses all of it. The dependency rule is also violated *within* the scaffold (repositories import `ApiService` concretely; no domain abstractions/use-cases; `dartz` `Failure` types never defined).
**Fix:** pick one codebase (see §Decision). If keeping the architecture, add a `domain/` layer with `UseCase` + `Repository` *interfaces*, and make `data/` depend on `domain/`, not vice-versa.

## 2. MVVM
Neither codebase is strictly MVVM. The BLoC scaffold is the closest (BLoC = ViewModel). The running app is raw `setState` with logic embedded in widgets. **Recommendation:** standardize on **BLoC/Cubit** (already chosen via deps) rather than introducing MVVM — don't mix paradigms.

## 3. BLoC
Nine BLoCs exist (`auth`, `content`, `player`, `profile`, `subscription`, `search`, `live`, `admin`, `theme`) with proper event/state separation and `equatable`. They are never instantiated (no `BlocProvider`/`MultiBlocProvider` in `main.dart`). `bloc_test` is a dev dependency but there are **no bloc tests**.
**Fix:** wire `MultiBlocProvider` at the root and provide blocs from get_it.

## 4. Riverpod
**Not present** — no `flutter_riverpod`/`hooks_riverpod` dependency, no `ProviderScope`, no `ConsumerWidget`. The app is committed to **BLoC + get_it**. That's a valid choice; **do not add Riverpod on top** — running two DI/state systems is a maintenance trap. (If you ever prefer Riverpod, migrate wholesale, don't blend.)

## 5. State Management
- Running app: `FutureBuilder` re-runs its future on every `setState`/navigation → **refetches from the network on every screen entry** (no caching, no shared state across tabs). The home tab does `Future.wait([featured, trending, newReleases, continueWatching])` so the **entire screen blocks on the slowest of four calls** and one failure fails all four.
- Scaffold: BLoC would solve this but is unused.
**Fix:** BLoC/Cubit with cached state + per-row independent loading (skeleton per row).

## 6. Dependency Injection
`get_it` is configured (`core/di/injection.dart`) but `configureDependencies()` is **never called** from `main()`, and it wouldn't compile (`ApiService(settingsBox:)` mismatch). The running app uses a top-level mutable global `late final Api api`.
**Fix:** call `await configureDependencies()` in `main()`, fix the `ApiService` constructor contract, and resolve blocs/repos via `sl<T>()`.

## 7. API Layer
Three incompatible clients:
- `main.dart`'s `Api` — **stores the JWT in `SharedPreferences` (plaintext)**, no refresh-token handling, no secure storage.
- `core/network/api_service.dart`'s `ApiService` — uses `flutter_secure_storage`, has a refresh interceptor, but uses **`int` ids** while the backend uses **`Guid`**, and returns raw `Response`.
- What `content_repository.dart` *expects* — decoded JSON + named params (`getBanners()`, `updateWatchHistory(...)`) that don't exist on either client.

**Fixes:**
1. Single canonical client.
2. Move the token to `flutter_secure_storage` (the running app currently leaks it to prefs).
```dart
// running app uses SharedPreferences — migrate to:
final _storage = const FlutterSecureStorage();
Future<String?> get token => _storage.read(key: 'access_token');
```
3. Use `String` (Guid) ids everywhere; delete the `int`-id client.
4. Keep one refresh-token interceptor (the secure `_AuthInterceptor` is the better base, but fix its queued-request handlers — see backend review §13).

## 8. Repository Pattern
Structurally clean in the scaffold (`ContentRepository`, `AuthRepository`, …) but: (a) uncompilable against the real API, (b) **no error handling** — every method is `await _api.x()` with exceptions propagating raw, (c) `dartz` is a dependency yet **no `Either<Failure, T>`** is used. The running app has no repositories at all (Dio is called directly from widgets).
**Fix:** make repositories the single seam; return `Either<Failure, T>` (or typed exceptions) and map `DioException` → domain `Failure`.

## 9. Offline Support
**None.** `injection.dart` opens three Hive boxes (`settings`, `cache`, `downloads`) but **no repository ever reads/writes them**. `connectivity_plus` is registered in DI but **used nowhere**. Only `cached_network_image` (image cache) provides any offline benefit — and the running app uses raw `Image.network` instead of it.
**Fix:** cache-aside in repositories (Hive read → network → write-back), a `ConnectivityCubit`, and an offline banner. `flutter_downloader` is present for downloads but unwired.

## 10. Error Handling
The **running app is actually the better one here**: consistent `try/catch` → `friendly(e)` messages and an `ErrorView` with retry (`ProfileGate`, `HomeTab`, `LiveTab`). Gaps: no typed failures, no global error boundary, silent swallows (`saveProgress` `catch (_) {}`, search `catch (_) => _results = []`). The scaffold repos have **no** error handling.
**Fix:** centralize `DioException` → `Failure` mapping; surface (not swallow) non-best-effort failures; add a global `FlutterError.onError` + `runZonedGuarded` hook to Crashlytics (the dependency is already present, unused).

## 11. Responsive Design
The running app has **zero** responsive logic: no `MediaQuery`/`LayoutBuilder` (verified), hard-coded sizes (`PosterTile width: 110/120`, hero `height: 230`, grids `maxCrossAxisExtent: 120`). `AppConstants` *defines* `mobileBreakpoint/tabletBreakpoint/desktopBreakpoint/tvBreakpoint` — **never referenced**.
**Fix:** a `Responsive` helper + adaptive grid column counts.
```dart
int gridColumns(BuildContext c) {
  final w = MediaQuery.sizeOf(c).width;
  if (w >= AppConstants.tvBreakpoint) return 8;
  if (w >= AppConstants.desktopBreakpoint) return 6;
  if (w >= AppConstants.tabletBreakpoint) return 4;
  return 3;
}
```

## 12. Tablet Support
Effectively none in the running app — phone UI stretched across the width; bottom `NavigationBar` on all sizes. The scaffold's `app_theme.dart` themes a `NavigationRail` and `main_shell.dart`/`admin_shell.dart` use `LayoutBuilder` (the right idea) but are unused.
**Fix:** `NavigationRail` on `width >= tabletBreakpoint`, master-detail for content lists, max content width on large screens.

## 13. Performance
- **`Image.network` everywhere** in `main.dart` (hero, posters, channels) — no memory/disk cache, no `cacheWidth`, re-decodes full-res on every scroll. `cached_network_image` is a dependency but unused by the running app. → jank + memory pressure on long grids.
- **`Future.wait` of 4 calls** gates the whole home screen; first paint waits on the slowest.
- **JWT decoded repeatedly** — `claims`/`email`/`role`/`isAdmin` re-parse base64 on every access (`ProfileTab` reads several per build).
- `ListView(children: [...])` for home rows builds all rows eagerly (acceptable here, but rows themselves use `ListView.separated` — good).
**Fixes:** `CachedNetworkImage` with `memCacheWidth`; load rows independently; decode the JWT once and cache claims.

## 14. Memory Leaks
Good: `PageController` (`_HeroCarousel`), `VideoPlayerController` + `Timer` (`_PlayerScreenState`) are disposed correctly.
Leaks: several `TextEditingController`s are created as state fields but **never disposed**:
- `_LoginScreenState._email`, `_pass`
- `_RegisterScreenState._first`, `_last`, `_email`, `_pass`
- `_SearchTabState._c`
- `_LiveTvChannelsScreenState._q`
```dart
@override
void dispose() { _email.dispose(); _pass.dispose(); super.dispose(); }
```
Small individually, but they're the kind of thing static analysis (`flutter_lints` is present) should already be flagging — confirm lints actually run in CI.

## 15. Testing
One trivial test (`test/widget_test.dart`: `expect(1 + 1, 2)`). `mockito` + `bloc_test` are dev deps but unused. No widget/bloc/golden tests.

---

## Recommended Decision

**Delete one codebase.** Two realistic paths:

- **Path A — Ship the monolith (fastest to production).** Keep `main.dart` as the product; delete the entire unused scaffold (`presentation/blocs`, `data/repositories`, `core/di`, `core/network/api_service.dart`, `core/router`, `core/theme`, unused screens). Then incrementally harden `main.dart`: secure token storage, `CachedNetworkImage`, responsive helper, dispose controllers, split the 2,162-line file by feature. *Lowest effort, but you keep a monolith.*
- **Path B — Finish the scaffold (right long-term).** Make the scaffold compile (one `ApiService` contract, Guid ids), wire `configureDependencies()` + `MultiBlocProvider`, add error mapping + offline cache, then delete `main.dart`. *Higher effort, but you get Clean Architecture + BLoC + DI + tablet support that already half-exists.*

Given the backend is the real asset and the scaffold is ~70% there structurally, **Path B** is the better investment if you have runway; **Path A** if you need a demo next week. What you should *not* do is leave both in the tree — it guarantees confusion and the "which file do I edit?" tax on every change.

---

## Recommended Folder Structure (Path B target)

```
lib/
  main.dart                      # ~30 lines: bootstrap DI, ProviderScope/MultiBlocProvider, runApp
  app/
    app.dart                     # MaterialApp.router, theme from ThemeBloc
    router.dart                  # go_router config + guards (auth/profile)
  core/
    config/        (env, constants)
    network/       (dio_client.dart, auth_interceptor.dart, api_result.dart)
    error/         (failure.dart, exception_mapper.dart)
    responsive/    (breakpoints.dart, responsive.dart)
    storage/       (secure_storage.dart, hive_boxes.dart)
    theme/         (app_theme.dart, ott_colors.dart)
    di/            (injection.dart)
  features/                      # feature-first; each owns its layers
    auth/
      data/        (auth_api.dart, auth_repository_impl.dart, dtos)
      domain/      (entities, auth_repository.dart, usecases)
      presentation/(bloc, screens, widgets)
    catalog/  (home, detail, search, genre)
    player/
    live/
    subscription/
    profile/
    downloads/
    admin/
  shared/
    widgets/       (poster_tile, error_view, shimmer_loaders, adaptive_scaffold)
    models/        (paged_result, branding_config)
test/
  features/<feature>/ (bloc_test + widget tests)   golden/
```
Key rules: one canonical Dio client; repositories return `Either<Failure, T>`; ids are `String` (Guid); blocs come from get_it; responsive `AdaptiveScaffold` (NavigationBar ↔ NavigationRail) chosen by breakpoint.

---

## Priority Fix List

| Priority | Fix | Effort |
|----------|-----|--------|
| P0 | Decide Path A or B; delete the other codebase | 0.5d |
| P0 | Move JWT from `SharedPreferences` → `flutter_secure_storage` (running app leaks token) | 0.5d |
| P0 | Align ids to Guid `String`; one API client | 1–2d |
| P1 | Dispose all `TextEditingController`s; confirm `flutter_lints` runs in CI | 0.5d |
| P1 | `CachedNetworkImage` + `memCacheWidth`; independent row loading | 1d |
| P1 | Responsive helper + tablet `NavigationRail` | 2–3d |
| P2 | Offline cache (Hive cache-aside) + `ConnectivityCubit` | 3–4d |
| P2 | Repository error mapping (`Either<Failure,T>`) + global Crashlytics hook | 2d |
| P2 | Wire BLoC + DI (Path B) and add bloc/widget tests | 1–2wk |
