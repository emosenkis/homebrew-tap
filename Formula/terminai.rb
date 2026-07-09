class Terminai < Formula
  desc "Interactive terminal wrapper with AI assistant"
  homepage "https://github.com/emosenkis/terminai"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emosenkis/terminai/releases/download/v0.1.4/terminai-0.1.4-darwin-aarch64.tar.gz"
      sha256 "4f48dde887c055001f468bf1e006d361593d55efa0d06b32e578c3a0cd1b4d9a"
    else
      url "https://github.com/emosenkis/terminai/releases/download/v0.1.4/terminai-0.1.4-darwin-x86_64.tar.gz"
      sha256 "24220daf436d7753177065f1dcac7b0bb2baf4986a8ccaa2ea6f5fe10a7a98f8"
    end
  elsif OS.linux?
    odie "Terminai currently ships Linux binaries for x86_64 only" unless Hardware::CPU.intel?

    url "https://github.com/emosenkis/terminai/releases/download/v0.1.4/terminai-0.1.4-linux-x86_64-musl.tar.gz"
    sha256 "4f1275cca166b758d55b1482cbb61c63222aea2acd72bfe24ebed7f90595266e"
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
