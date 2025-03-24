class Oli < Formula
  desc "A simple, blazingly fast TUI based AI coding assistant"
  homepage "https://github.com/amrit110/oli"
  url "https://github.com/amrit110/oli/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "7f9e42d9dd67891707258f2eb087484a2bc1cc69a25388d9791397f76dacc427"
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
