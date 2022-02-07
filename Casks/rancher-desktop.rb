cask "rancher-desktop" do
  arch = Hardware::CPU.intel? ? "x86_64" : "aarch64"

  version "1.0.1"

  if Hardware::CPU.intel?
    sha256 "01dcabe09dca068853da7a3966a6f9895fa7537eeef296f0363da64f42ad78fc"
  else
    sha256 "b5a3af6c95355efe05dcee8afbf57d8af170e1356d502b1bb9f2f3f58a2bd147"
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
    "/private/etc/sudoers.d/rancher-desktop-lima",
    "/private/var/run/docker.sock",
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
