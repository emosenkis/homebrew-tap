class Terminai < Formula
  desc "Interactive terminal wrapper with AI assistant"
  homepage "https://github.com/emosenkis/terminai"
  url "https://github.com/emosenkis/terminai/archive/refs/tags/v0.1.25.tar.gz"
  sha256 "d75b138935b62ed2ee4d62cfbe80939faf1cd39eb091eb90487713000383458a"
  license "MIT"

  bottle do
    root_url "https://github.com/emosenkis/homebrew-tap/releases/download/terminai-0.1.25"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "64507e474851438ce3f4e3f67c37883b9edc26826b20faa20aec1376e51c16cb"
    sha256 cellar: :any,                 x86_64_linux: "de0f146446c727c34c8afcb620d6145f9461ab0112a6914e29c112a60e3cd44d"
  end

  depends_on "rust" => :build

  resource "ratatui" do
    url "https://github.com/emosenkis/ratatui/archive/36ef83e95b2d4ddd3268fa648930cff79d2ea33b.tar.gz"
    sha256 "1ecf8d1c9f017d1aacc636d47ba3a94bcff0f745ea34ad879c3712eae481a6e9"
  end

  resource "rat-salsa" do
    url "https://github.com/emosenkis/rat-salsa/archive/30dec1f603c8c79ca1c79cf6f832fac7a26b84e5.tar.gz"
    sha256 "df8513c774a3f8f8b1e2141b2c76538049dcede8a3b09617a4a7fcd19fb2779e"
  end

  resource "redact" do
    url "https://github.com/emosenkis/terminai-redact/archive/9af9fdd7aac08267045527c143a51892b83de747.tar.gz"
    sha256 "a1f2e0e267a068a11f9e5e216589d3f17676e58a7ff98d3bb7b22726130c1d11"
  end

  def install
    resource("ratatui").stage { (buildpath/"ratatui").install Dir["*"] }
    resource("rat-salsa").stage { (buildpath/"rat-salsa").install Dir["*"] }
    resource("redact").stage { (buildpath/"vendor/redact").install Dir["*"] }
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
