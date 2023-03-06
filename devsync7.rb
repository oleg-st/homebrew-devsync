require "formula"

class DotnetRequirement < Requirement
  fatal true

  satisfy(:build_env => false) { which("dotnet") }

  def message; <<~EOS
    .NET 7 Runtime is required; install it via:
    brew install --cask dotnet
    EOS
  end
end

class Devsync6 < Formula
  depends_on DotnetRequirement
  version "0.37"
  url "https://github.com/oleg-st/DevSync/releases/download/#{version}/DevSync7.zip"
  homepage "https://github.com/oleg-st/DevSync"
  sha256 "9e2a9218bd99734285e3b9f82d0d422052a632f88277bb411d7ac45b2e56df55"

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
