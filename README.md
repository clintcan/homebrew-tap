# clintcan/homebrew-tap

Homebrew formulae and casks for my own tools.

## Install

```sh
brew install clintcan/tap/luvienne
brew install --cask clintcan/tap/macrdp
```

Current Homebrew asks you to trust a third-party tap once before it loads it:
`brew trust clintcan/tap`.

Or track `main` instead of the latest release:

```sh
brew install --HEAD clintcan/tap/luvienne
```

## Formulae

| Formula | Description |
| --- | --- |
| `luvienne` | A keyboard-driven SSH connection manager for the terminal |

## Casks

| Cask | Description |
| --- | --- |
| `macrdp` | Native RDP server for macOS. Installs the notarized, entitled release DMG, so USB redirection works (Apple Silicon, macOS 14+) |

## Updating the macrdp cask

After each macrdp release:

1. Get the checksum of the entitled DMG (note the tag has a `v`, the file name doesn't):

   ```sh
   curl -sL https://github.com/clintcan/macrdp/releases/download/v0.9.11/macrdp-0.9.11-usb.dmg | shasum -a 256
   ```

2. Update `version` and `sha256` in `Casks/macrdp.rb`, then verify before pushing:

   ```sh
   brew style --cask clintcan/tap/macrdp
   brew audit --cask --strict --online clintcan/tap/macrdp
   ```

   Don't add `--new`: its notability rule is for the official `homebrew/cask` repo, not
   a personal tap.

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
