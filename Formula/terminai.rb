class Terminai < Formula
  desc "Interactive terminal wrapper with AI assistant"
  homepage "https://github.com/emosenkis/terminai"
  url "https://github.com/emosenkis/terminai.git",
      tag:      "v0.1.16",
      revision: "2df31f0d7a192787f2fe8476fb574991ca99ffdf"
  license "MIT"

  bottle do
    root_url "https://github.com/emosenkis/homebrew-tap/releases/download/terminai-0.1.15"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "32e6b3014e08040b9db6523ecc43f6363931b26718e27a91e13d29d4e81d5093"
    sha256 cellar: :any,                 x86_64_linux: "87c06623bc82366e0a75e50693b228d19c9d27184ab99f5ee98a906aa3d1c2c0"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "src")
  end

  def caveats
    <<~EOS
      Terminai runs your configured CLI agent in a PTY-backed overlay.
      It does not store AI credentials or choose models itself.

      To initialize the default config:
        $ terminai init-config

      The config will be written to:
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
    assert_match version.to_s, shell_output("#{bin}/terminai --version")
  end
end
