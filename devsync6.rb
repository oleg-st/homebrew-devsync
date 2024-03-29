require "formula"

class DotnetRequirement < Requirement
  fatal true

  satisfy(:build_env => false) { which("dotnet") }

  def message; <<~EOS
    .NET 6 Runtime is required; install it via:
    brew install --cask dotnet
    EOS
  end
end

class Devsync6 < Formula
  depends_on DotnetRequirement
  version "0.37"
  url "https://github.com/oleg-st/DevSync/releases/download/#{version}/DevSync6.zip"
  homepage "https://github.com/oleg-st/DevSync"
  sha256 "04061868e888f45562e7831c60b7afb0429c447542fc196d07b214f1296228f4"

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
