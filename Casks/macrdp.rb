cask "macrdp" do
  version "0.12.0"
  sha256 "f28a17112df6bb1876e6448935e108b50c4d8d9a20a737a6a1eca7f29e5e8cb0"

  url "https://github.com/clintcan/macrdp/releases/download/v#{version}/macrdp-#{version}-usb.dmg"
  name "macrdp"
  desc "Native RDP server: connect from Windows Remote Desktop and FreeRDP clients"
  homepage "https://github.com/clintcan/macrdp"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "macrdp.app"
  app "macrdpController.app"

  uninstall launchctl: "com.clintcan.macrdp",
            quit:      "com.clintcan.macrdp.controller"

  zap trash: [
    "~/Library/Application Support/macrdp",
    "~/Library/Logs/macrdp.err.log",
    "~/Library/Logs/macrdp.log*",
  ]

  caveats <<~EOS
    macrdpController is a menu-bar app: opening it shows no window, only a
    small display icon in the menu bar. Click it and choose
    "Start (first run sets up)" to store your Mac password in the Keychain
    and start the server at login.

    On first run, grant macrdp Screen Recording and Accessibility in
    System Settings > Privacy & Security.

    After upgrading, restart the server so it runs the new version (this
    drops any connected session):
      launchctl kickstart -k gui/$(id -u)/com.clintcan.macrdp

    Optional features need a one-time admin install, which this cask doesn't do:
    smart-card redirection, the camera extension and the microphone driver.
    See https://github.com/clintcan/macrdp#documentation
  EOS
end
