require "formula"

class DotnetRequirement < Requirement
  fatal true

  satisfy(:build_env => false) { which("dotnet") }

  def message; <<~EOS
    .NET 5 Runtime is required; install it via:
    brew install --cask dotnet
    EOS
  end
end

class Devsync5 < Formula
  depends_on DotnetRequirement
  version "0.35"
  url "https://github.com/oleg-st/DevSync/releases/download/#{version}/DevSync5.zip"
  homepage "https://github.com/oleg-st/DevSync"
  sha256 "44b04abf8d5b0f2488a0798f0af76fd776d8e00ce9cd1529e18c0a693896a7a5"

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
