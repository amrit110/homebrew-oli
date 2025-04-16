class Oli < Formula
  desc "A simple, blazingly fast TUI based AI coding assistant"
  homepage "https://github.com/amrit110/oli"
  url "https://github.com/amrit110/oli/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "e51fa6ac248617f1b1c073c944f2a7d1107086d03ca319d9fda5c4fab76f76fa"
  license "Apache-2.0"

  depends_on "rust" => :build
  depends_on "node" => :build

  def install
    # Build Rust backend
    system "cargo", "build", "--release"
    
    # Build UI
    cd "ui" do
      system "npm", "ci"
      system "npm", "run", "build"
    end
    
    # Create bin directory
    bin_dir = "#{prefix}/bin"
    libexec_dir = "#{prefix}/libexec/oli"
    mkdir_p bin_dir
    mkdir_p libexec_dir
    
    # Copy binaries and UI files
    cp "target/release/oli-server", libexec_dir
    cp_r "ui/dist", "#{libexec_dir}/ui"
    
    # Create wrapper script
    (bin/"oli").write <<~EOS
      #!/bin/bash
      
      # Start the server in the background
      "#{libexec_dir}/oli-server" &
      SERVER_PID=$!
      
      # Start the UI
      cd "#{libexec_dir}"
      node --import tsx ui/cli.js "$@"
      
      # Kill the server when the UI exits
      kill $SERVER_PID
    EOS
    
    chmod 0755, bin/"oli"
  end

  test do
    system "#{bin}/oli", "--version"
  end
end
