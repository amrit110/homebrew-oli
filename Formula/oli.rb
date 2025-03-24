class Oli < Formula
  desc "A simple, blazingly fast TUI based AI coding assistant"
  homepage "https://github.com/amrit110/oli"
  url "https://github.com/amrit110/oli/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "7894bb73af701ef7e8b2cc6cd121a62d02ac83b8f1a57319dac6f745d23f5f12"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release", "--bin", "oli"
    bin.install "target/release/oli"
  end

  test do
    system "#{bin}/oli", "--version"
  end
end
