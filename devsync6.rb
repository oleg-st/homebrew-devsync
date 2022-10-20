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
  version "0.36"
  url "https://github.com/oleg-st/DevSync/releases/download/#{version}/DevSync6.zip"
  homepage "https://github.com/oleg-st/DevSync"
  sha256 "09505508ba3efffb9c4e9032d0ba3431cb9f2eea24e47277c117bf1a8284eeb0"

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
