class Luvienne < Formula
  desc "Keyboard-driven SSH connection manager for the terminal"
  homepage "https://github.com/clintcan/luvienne"
  url "https://github.com/clintcan/luvienne/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "a54832e412b0d871cd89ddc6efc6c82f52f983a54156e37d4efbade6f9377576"
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
