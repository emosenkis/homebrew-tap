class Terminai < Formula
  desc "Interactive terminal wrapper with AI assistant"
  homepage "https://github.com/emosenkis/terminai"
  url "https://github.com/emosenkis/terminai.git",
      tag:      "v0.1.14",
      revision: "051ee14cbab90ce3d3d59466e51a3decdecdc08c"
  license "MIT"

  bottle do
    root_url "https://github.com/emosenkis/homebrew-tap/releases/download/terminai-0.1.13"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "74fadb36936be11ede033bac6be2b32a5e49d2a5f9e4712b2126fe8a7d76d7f5"
    sha256 cellar: :any,                 x86_64_linux: "88e3259b577ea9fdc78a194573ff60a720d5b95e48a21ae31d3849b9579a1816"
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
