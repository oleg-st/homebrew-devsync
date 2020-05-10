require "formula"

class DotnetRequirement < Requirement
  fatal true

  satisfy(:build_env => false) { which("dotnet") }

  def message; <<~EOS
    .NET Core 3+ Runtime is required; install it via:
    brew cask install dotnet
    EOS
  end
end

class Devsync < Formula
  depends_on DotnetRequirement
  version "0.24"
  url "https://github.com/oleg-st/DevSync/releases/download/#{version}/DevSync.zip"
  homepage "https://github.com/oleg-st/DevSync"
  sha256 "73542c8f5835843633f321f236f5e065ab333d6a64cf297e123c64a92895c4f3"

  def install
    # write run script
    dotnet = which("dotnet")
    (bin/"DevSync").write <<~EOS
    #!/bin/bash
    exec "#{dotnet}" "#{prefix}/DevSync.dll" "$@"
    EOS
    # install all files
    prefix.install Dir["*"]
  end
end
