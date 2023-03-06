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
  version "0.37"
  url "https://github.com/oleg-st/DevSync/releases/download/#{version}/DevSync5.zip"
  homepage "https://github.com/oleg-st/DevSync"
  sha256 "6750322c631310554d6eb95b8b2151e10c5c8838323b7e6f3bcfc86969115381"

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
