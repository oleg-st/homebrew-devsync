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
  version "0.29"
  url "https://github.com/oleg-st/DevSync/releases/download/#{version}/DevSync.zip"
  homepage "https://github.com/oleg-st/DevSync"
  sha256 "a35347a41eb6eede72b9c7ba8741ef4db10a51f932b9ab051c86ec6c3a28254c"

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
