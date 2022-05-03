cask "rancher-desktop" do
  arch = Hardware::CPU.intel? ? "x86_64" : "aarch64"

  version "1.3.0"

  if Hardware::CPU.intel?
    sha256 "b333b6083ebed0b6174c021e437675acc7ef661a15bdd4954eff2ac74d5472ce"
  else
    sha256 "a7e9d572abaf57cdf5cf5f5167dd5f8ee57d38af50386d7749cbb812e7b203c1"
  end

  url "https://github.com/rancher-sandbox/rancher-desktop/releases/download/v#{version}/Rancher.Desktop-#{version}.#{arch}.dmg",
      verified: "github.com/rancher-sandbox/rancher-desktop/"
  name "Rancher Desktop"
  desc "Kubernetes and container management on the desktop"
  homepage "https://rancherdesktop.io/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  conflicts_with formula: %w[
    docker
    helm
    kubernetes-cli
  ]

  app "Rancher Desktop.app"

  uninstall delete: [
    "/opt/rancher-desktop",
    "/private/etc/sudoers.d/zzzzz-rancher-desktop-lima", # zzzzz is not a typo
    "/private/var/run/rancher-desktop-lima",
  ],
            quit:   "io.rancherdesktop.app"

  zap trash: [
    "~/.kuberlr",
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
