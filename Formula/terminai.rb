class Terminai < Formula
  desc "Interactive terminal wrapper with AI assistant"
  homepage "https://github.com/emosenkis/terminai"
  url "https://github.com/emosenkis/terminai.git",
      tag:      "v0.1.11",
      revision: "3fbd3ed4e5ace604e9b9b7dbe8555bd3859e25b5"
  license "MIT"

  bottle do
    root_url "https://github.com/emosenkis/homebrew-tap/releases/download/terminai-0.1.10"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a758b2e8488f115b1319b5b01dc2fe4ca6f9d470854862d70fe5b044e5616579"
    sha256 cellar: :any,                 x86_64_linux: "c608d7130f318df60bf8daa84b2a1299fceb559e250401a2496409e7437c6fd6"
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
