<!-- .github/copilot-instructions.md    -->
# Copilot / AI contributor hints — QuizGame

Purpose: short, actionable guidance so an AI agent can be productive immediately in this repo.

- Root tech: Roblox/Luau project scaffolded with Rojo. Source is under `src/` (client, server, shared).
- Tooling: Rokit (tools listed in `rokit.toml`), Wally for package management (`wally.toml`), Selene for linting (`selene.toml`).

Quick start (what humans run):
- Build the place: `rojo build -o "QuizGame.rbxlx"` (see `README.md`).
- Open the produced `QuizGame.rbxlx` in Roblox Studio and run the Rojo server with `rojo serve` to develop live.

Where to look first (architecture):
- `src/server/` — server-side entry `init.server.luau` wires runtime services and player lifecycle (PlayerAdded/PlayerRemoving).
  - `init.server.luau` requires modules from `ServiceScriptService.Server.*` (module placement convention).
- `src/client/` — client entry `init.client.luau`.
- `src/shared/` — shared modules used by both sides.
- `ServerPackages/` — wally-installed packages live here (see `_Index` and package subfolders). They are required at runtime under `ServerScriptService.ServerPackages`.

Key patterns and conventions (concrete, repo-specific):
- Module resolution: code expects runtime modules under ServiceScriptService. Example: `require(ServiceScriptService.Server.ProfileManager)` in `src/server/init.server.luau`.
- Third-party packages: Wally packages are committed under `ServerPackages/_Index/` and are accessed via `ServerScriptService.ServerPackages.<PackageName>` in server code. Example: ProfileService is pulled from `wally.toml` and required in `ProfileManager.luau`.
- Save/load idioms: `ProfileManager` uses ProfileService API: `GetProfileStore(...):LoadProfileAsync(...)`, `profile:ListenToRelease(...)`, `profile:Save()` and `profile:Release()`. When editing or generating code that touches player persistence, match these patterns.
- Player state: use `player:SetAttribute("Coins", value)` for exposing simple values to client; `ProfileManager` mirrors persistent `profile.Data.Coins` into an Attribute.
- File naming: Luau files use explicit suffixes like `.server.luau` and `.client.luau` for Rojo mappings — preserve these names when adding new entry scripts.

Notable inconsistencies to watch for:
- `init.server.luau` calls `ProfileManager:SetupLeaderstats(player)` but `src/server/ProfileManager.luau` in this branch does not define `SetupLeaderstats`. Before adding calls or edits, search the codebase for alternative implementations or update `ProfileManager` with a matching function. (Agents: prefer to surface this as a PR comment rather than silently adding guessed behavior.)

Development rules for AI edits (be conservative):
- Preserve existing module paths and require patterns; do not move modules between ServiceScriptService and ServerScriptService without updating all callers.
- When adding dependency usage, update `wally.toml` and place package under `ServerPackages/_Index` (follow existing package format). If adding new Wally packages, mention to the human to run Wally/Rokit tooling — do not attempt to modify external package registries.
- Keep comments and naming consistent with existing style (short English/Russian comments are present; preserve language where appropriate).

Examples to reference when generating code:
- Lifecycle wiring: `src/server/init.server.luau` — shows PlayerAdded -> ProfileManager:Load/SetupLeaderstats and PlayerRemoving -> ProfileManager:Release.
- Persistence example: `src/server/ProfileManager.luau` — shows ProfileService usage, attributes sync, Save/Release patterns.

If you need to run or test behavior locally:
- Build and open in Studio: `rojo build -o "QuizGame.rbxlx"` then `rojo serve` while Studio is open and connected.

When in doubt: search for exact symbol names (e.g., `ProfileManager`, `Coins`, `ProfileService`) and prefer small, focused changes with a clear test plan. Mention any missing or mismatched API (like the `SetupLeaderstats` case) in the PR description.

Questions for the maintainer (ask as PR checks):
- Should `ProfileManager` export a `SetupLeaderstats` helper, or was that call meant for a different module?
- Is there a preferred stable Wally registry other than the one in `wally.toml` (the repo currently points to a custom registry)?

Files to inspect when making edits: `src/server/init.server.luau`, `src/server/ProfileManager.luau`, `ServerPackages/_Index/`, `wally.toml`, `rokit.toml`, `README.md`.

End of file.
