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
  version "0.26"
  url "https://github.com/oleg-st/DevSync/releases/download/#{version}/DevSync.zip"
  homepage "https://github.com/oleg-st/DevSync"
  sha256 "c0c1ecc13cd58ee1fbe0e59fedbf958d70a1efac7113f56f71b50a5d7d03e53e"

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
