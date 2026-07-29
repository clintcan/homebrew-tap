class Luvienne < Formula
  desc "Keyboard-driven SSH connection manager for the terminal"
  homepage "https://github.com/clintcan/luvienne"
  url "https://github.com/clintcan/luvienne/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "73cacc3947d064cfc58ee6c53fe9ac9c327d0d9288e814f6d94e35c924039f29"
  license "Apache-2.0"
  head "https://github.com/clintcan/luvienne.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/luvienne --version")

    # luvienne needs a terminal to draw on and `brew test` gives it none, so a
    # bare run must fail with that explanation rather than a panic.
    output = shell_output("#{bin}/luvienne 2>&1", 1)
    assert_match "needs a terminal", output
  end
end
