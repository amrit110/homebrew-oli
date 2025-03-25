class Oli < Formula
  desc "A simple, blazingly fast TUI based AI coding assistant"
  homepage "https://github.com/amrit110/oli"
  url "https://github.com/amrit110/oli/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "e51fa6ac248617f1b1c073c944f2a7d1107086d03ca319d9fda5c4fab76f76fa"
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
