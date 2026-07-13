class Terminai < Formula
  desc "Interactive terminal wrapper with AI assistant"
  homepage "https://github.com/emosenkis/terminai"
  version "0.1.5"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emosenkis/terminai/releases/download/v0.1.5/terminai-0.1.5-darwin-aarch64.tar.gz"
      sha256 "6bd6f7314a1968998f77116277f7d28db246f6046ffe6af05b69f418cf8959c7"
    else
      url "https://github.com/emosenkis/terminai/releases/download/v0.1.5/terminai-0.1.5-darwin-x86_64.tar.gz"
      sha256 "a9da4b5635c1a2f9e5eb6d68850426987c3b2f4972727160960e8906431b729f"
    end
  elsif OS.linux?
    odie "Terminai currently ships Linux binaries for x86_64 only" unless Hardware::CPU.intel?

    url "https://github.com/emosenkis/terminai/releases/download/v0.1.5/terminai-0.1.5-linux-x86_64-musl.tar.gz"
    sha256 "47ac1ef4b4f74f17591f385bf2af96ae90a408aa5c3ece7f5254b84796192c5d"
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
