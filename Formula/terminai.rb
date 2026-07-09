class Terminai < Formula
  desc "Interactive terminal wrapper with AI assistant"
  homepage "https://github.com/emosenkis/terminai"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emosenkis/terminai/releases/download/v0.1.1/terminai-0.1.1-darwin-aarch64.tar.gz"
      sha256 "7a5d138c82856c119bfca8a041ce16c5267a6d0e1737331c601ff471a792e0e2"
    else
      url "https://github.com/emosenkis/terminai/releases/download/v0.1.1/terminai-0.1.1-darwin-x86_64.tar.gz"
      sha256 "ecd960e0ada532e22aa1ca9b5c3801abd8d30214563209670f6340beb0047b16"
    end
  elsif OS.linux?
    odie "Terminai currently ships Linux binaries for x86_64 only" unless Hardware::CPU.intel?

    url "https://github.com/emosenkis/terminai/releases/download/v0.1.1/terminai-0.1.1-linux-x86_64-musl.tar.gz"
    sha256 "718ca69edec12efad274459abce754f4d98d377c8c32aba720ffb4e0475bed5a"
  end

  license "MIT"

  def install
    bin.install "terminai"
  end

  def post_install
    system bin/"terminai", "init-config"
  end

  def caveats
    <<~EOS
      Terminai runs your configured CLI agent in a PTY-backed overlay.
      It does not store AI credentials or choose models itself.

      The default config has been initialized at:
        ~/.config/terminai/terminai.yaml

      Next, authenticate your chosen CLI agent:
        $ codex login
        # or:
        $ claude auth

      To use Terminai:
        $ terminai

      Press Ctrl+Space to open the CLI-agent overlay.

      For more information, see: https://github.com/emosenkis/terminai
    EOS
  end

  test do
    assert_match "Interactive terminal wrapper with AI assistant",
      shell_output("#{bin}/terminai --help")
  end
end
