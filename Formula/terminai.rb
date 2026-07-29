class Terminai < Formula
  desc "Interactive terminal wrapper with AI assistant"
  homepage "https://github.com/emosenkis/terminai"
  url "https://github.com/emosenkis/terminai.git",
      tag:      "v0.1.20",
      revision: "262c12615a95130ef1eff8173ee3906f9be7cde7"
  license "MIT"

  bottle do
    root_url "https://github.com/emosenkis/homebrew-tap/releases/download/terminai-0.1.19"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "84b5c9965ac6da57d8ab7c7f5f505021944a9d70a59c69a8cc036fa7e8cdc6bb"
    sha256 cellar: :any,                 x86_64_linux: "beca5e011cf6068d0d5b8784fe7edddfa4635d263054111d7e2514203fa9e842"
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
