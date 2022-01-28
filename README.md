# homebrew-containers-desktop

Homebrew tap for alternative casks for Rancher Desktop and Docker Desktop.

## Reasoning

If you are curious why this exist, check out these discussions:

[https://github.com/Homebrew/homebrew-cask/pull/117823](https://github.com/Homebrew/homebrew-cask/pull/117823)
[https://github.com/Homebrew/homebrew-cask/pull/111861](https://github.com/Homebrew/homebrew-cask/pull/111861)

Main difference for rancher-desktop cask:

- binaries are no longer tracked by brew (app allows their manual management);
- added simple github_latest livecheck;
- removed conflict with docker cask;
- added caveats explaining co-existence with docker-desktop and binaries.

## Usage

You’ll need [homebrew](http://brew.sh/) installed, before running these.

[Tap](https://github.com/Homebrew/brew/blob/master/docs/Taps.md) this repository by running

```bash
brew tap sanyer/containers-desktop
```

Afterwards, install them as any other formula. For example, to install `rancher-desktop`, run

```bash
brew install rancher-desktop
```

Untap this brew tap:

$ brew untap sanyer/containers-desktop

## License

The Unlicense (Public Domain, effectively)
