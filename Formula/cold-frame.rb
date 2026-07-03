# Homebrew formula for Coldframe — `brew install coldzero94/coldframe/cold-frame`.
# Installs the self-contained binary built by the Release workflow (CLI + MCP in one file, no
# Python, no dependency resolution, works offline). Auto-updated by the cold-frame Release workflow.
class ColdFrame < Formula
  desc "Local-first ownable memory layer for LLM agents (one offline SQLite file)"
  homepage "https://github.com/coldzero94/cold-frame"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/coldzero94/cold-frame/releases/download/v0.1.0/cold-frame-macos-arm64"
      sha256 "744901491f18dd1c2f712510214d8cc93472ea6aedbfaeebe285cd6f62fd8bdd"
    end
  end
  on_linux do
    url "https://github.com/coldzero94/cold-frame/releases/download/v0.1.0/cold-frame-linux-x86_64"
    sha256 "db65d271afdf45dec797e17e63f1829141e423125bac3148f869edaad95a83f9"
  end

  def install
    bin.install Dir["cold-frame-*"].first => "cold-frame"
    chmod 0755, bin/"cold-frame"
  end

  test do
    assert_match "0.1.0", shell_output("#{bin}/cold-frame --version")
  end

  def caveats
    <<~EOS
      Turn on AUTOMATIC memory in Claude Code (recall every session, capture as you work):
        cold-frame hook install
        claude mcp add cold-frame -- cold-frame mcp

      Your memory lives in ~/.cold-frame/memory.db — one file, yours, offline. Browse it:
        cold-frame ui
    EOS
  end
end
