cask "macrdp" do
  version "0.9.11"
  sha256 "bcc01fd169a7f51e9413e37f6baeb5e63678af45230a4ad26242b20c29e9d6b5"

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
    Open macrdpController from /Applications to finish setup. It stores your
    Mac password in the Keychain and starts the server at login.

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
