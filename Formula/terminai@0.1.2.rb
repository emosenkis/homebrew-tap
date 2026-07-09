class TerminaiAT012 < Formula
  desc "Interactive terminal wrapper with AI assistant"
  homepage "https://github.com/emosenkis/terminai"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emosenkis/terminai/releases/download/v0.1.2/terminai-0.1.2-darwin-aarch64.tar.gz"
      sha256 "c42479045eeb9f86a5939d6b1023a14f5fed7a1fc748e408c5575259df61c4c2"
    else
      url "https://github.com/emosenkis/terminai/releases/download/v0.1.2/terminai-0.1.2-darwin-x86_64.tar.gz"
      sha256 "489219d449c76b1c11ae4941e8de35d3e82b0988a5995758b27997fdbc70d8a7"
    end
  elsif OS.linux?
    odie "Terminai currently ships Linux binaries for x86_64 only" unless Hardware::CPU.intel?

    url "https://github.com/emosenkis/terminai/releases/download/v0.1.2/terminai-0.1.2-linux-x86_64-musl.tar.gz"
    sha256 "0be5d6390f6530ba0699416ccbdcff3088fe862968c47d7d58d3cea6031532ce"
  end

  license "MIT"
  version "0.1.2"

  conflicts_with "terminai", "terminai@0.1.3",
    because: "all Terminai formulae install the terminai binary"

  def install
    bin.install "terminai"
  end

  def post_install
    system bin/"terminai", "init-config"
  end

  test do
    assert_match "Interactive terminal wrapper with AI assistant",
      shell_output("#{bin}/terminai --help")
  end
end
