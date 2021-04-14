require "formula"

class DotnetRequirement < Requirement
  fatal true

  satisfy(:build_env => false) { which("dotnet") }

  def message; <<~EOS
    .NET Core 3+ Runtime is required; install it via:
    brew install --cask dotnet
    EOS
  end
end

class Devsync < Formula
  depends_on DotnetRequirement
  version "0.33"
  url "https://github.com/oleg-st/DevSync/releases/download/#{version}/DevSync5.zip"
  homepage "https://github.com/oleg-st/DevSync"
  sha256 "0745955364c33d41b4324f71b94432ebda48080a17187c882ae3cca400f31d26"

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
