# clintcan/homebrew-tap

Homebrew formulae for my own tools.

## Install

```sh
brew install clintcan/tap/luvienne
```

Or track `main` instead of the latest release:

```sh
brew install --HEAD clintcan/tap/luvienne
```

## Formulae

| Formula | Description |
| --- | --- |
| `luvienne` | A keyboard-driven SSH connection manager for the terminal |

## Cutting a luvienne release

1. Bump `version` in luvienne's `Cargo.toml`, commit, and tag:

   ```sh
   git tag v0.1.0 && git push origin v0.1.0
   ```

2. Get the tarball checksum:

   ```sh
   curl -sL https://github.com/clintcan/luvienne/archive/refs/tags/v0.1.0.tar.gz | shasum -a 256
   ```

3. Update `url` and `sha256` in `Formula/luvienne.rb`, then verify before pushing:

   ```sh
   brew install --build-from-source ./Formula/luvienne.rb
   brew test luvienne
   brew audit --strict --online ./Formula/luvienne.rb
   ```
