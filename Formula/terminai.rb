class Terminai < Formula
  desc "Interactive terminal wrapper with AI assistant"
  homepage "https://github.com/emosenkis/terminai"
  url "https://github.com/emosenkis/terminai.git",
      tag:      "v0.1.17",
      revision: "d1eb7b2faefa0be259a74409bb086496456a5941"
  license "MIT"

  bottle do
    root_url "https://github.com/emosenkis/homebrew-tap/releases/download/terminai-0.1.17"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "841a02945a760561848226589b3fac0c967e16a6ae2584e342ad53514574803f"
    sha256 cellar: :any,                 x86_64_linux: "2f46ff16c7b725a097c74a5d65c47df71d9ea3f258fa344fd8db270670d153fc"
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
