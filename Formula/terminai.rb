class Terminai < Formula
  desc "Interactive terminal wrapper with AI assistant"
  homepage "https://github.com/emosenkis/terminai"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emosenkis/terminai/releases/download/v0.1.3/terminai-0.1.3-darwin-aarch64.tar.gz"
      sha256 "3a0cbbd0ff71dc9a5ff4279bc0b1f1434aa98dfefd3b5990efe8416e770bd44d"
    else
      url "https://github.com/emosenkis/terminai/releases/download/v0.1.3/terminai-0.1.3-darwin-x86_64.tar.gz"
      sha256 "9e1b0aca670116374dfd8320ce56785e3a0b12fe18838471e6b352c293fc32af"
    end
  elsif OS.linux?
    odie "Terminai currently ships Linux binaries for x86_64 only" unless Hardware::CPU.intel?

    url "https://github.com/emosenkis/terminai/releases/download/v0.1.3/terminai-0.1.3-linux-x86_64-musl.tar.gz"
    sha256 "04c6e350397537abfdb7d82672b04e146bc0960b79d427e1854339d42909cc81"
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
