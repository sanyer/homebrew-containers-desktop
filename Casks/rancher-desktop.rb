cask "rancher-desktop" do
  arch = on_intel do
    "x86_64"
  end
  on_arm do
    "aarch64"
  end

  version "1.5.1"
  sha256 arm:   "4ac3defdbdbd5a48655e7c4514692fdf248afb2d26ac7e5c5c0487b92fb4659a",
         intel: "080c3eb05e01285413f984e53dbf6204df9b9b3485208b7887353688796c6def"

  url "https://github.com/rancher-sandbox/rancher-desktop/releases/download/v#{version}/Rancher.Desktop-#{version}.#{arch}.dmg",
      verified: "github.com/rancher-sandbox/rancher-desktop/"
  name "Rancher Desktop"
  desc "Kubernetes and container management on the desktop"
  homepage "https://rancherdesktop.io/"

  auto_updates true

  app "Rancher Desktop.app"

  uninstall delete: [
              "/opt/rancher-desktop",
              "/private/etc/sudoers.d/zzzzz-rancher-desktop-lima", # zzzzz is not a typo
              "/private/var/run/docker.sock",
              "/private/var/run/rancher-desktop-*",
            ],
            quit:   "io.rancherdesktop.app"

  zap trash: [
    "~/.kuberlr",
    "~/.rd",
    "~/Library/Application Support/Caches/rancher-desktop-updater",
    "~/Library/Application Support/Rancher Desktop",
    "~/Library/Application Support/rancher-desktop",
    "~/Library/Caches/io.rancherdesktop.app*",
    "~/Library/Caches/rancher-desktop",
    "~/Library/Logs/rancher-desktop",
    "~/Library/Preferences/ByHost/io.rancherdesktop.app*",
    "~/Library/Preferences/io.rancherdesktop.app.plist",
    "~/Library/Preferences/rancher-desktop",
    "~/Library/Saved Application State/io.rancherdesktop.app.savedState",
  ]

  caveats <<~EOS
    Docker Desktop cannot be run at the same time Rancher Desktop.
    Before starting one, be sure to stop the other first.
    See https://docs.rancherdesktop.io/faq/

    Additionally, because Rancher Desktop (unlike Docker Desktop) allows
    manual management of Supporting Utilities, these utilities won't be
    removed by Homebrew during cask uninstall:

    /usr/local/bin/docker
    /usr/local/bin/helm
    /usr/local/bin/kubectl
    /usr/local/bin/nerdctl

    So, please make sure to unlink them in Rancher Desktop UI beforehand.
  EOS
end
