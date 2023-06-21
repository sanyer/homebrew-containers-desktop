cask "rancher-desktop" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.9.0"
  sha256 arm:   "1a0e7178ec4f32e366261bfadaa593e9f0fa9866844f42f96797783875b18487",
         intel: "b6ca589e3e2212609b18d5e08644d33cd2140dd2a82082a72726853f76dd45cf"

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
