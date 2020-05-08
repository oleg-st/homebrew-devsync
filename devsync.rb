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
  version "0.23"
  url "https://github.com/oleg-st/DevSync/releases/download/#{version}/DevSync.zip"
  homepage "https://github.com/oleg-st/DevSync"
  sha256 "030c632ce30f5389c037155856f0efc7f5590ad9036e5316ab910f0a641a81cd"

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
