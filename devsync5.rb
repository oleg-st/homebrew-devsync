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
  version "0.34"
  url "https://github.com/oleg-st/DevSync/releases/download/#{version}/DevSync5.zip"
  homepage "https://github.com/oleg-st/DevSync"
  sha256 "ba4ab711e6fba8f5e5621599c51ed2a0d256537cd2f5beae07f6cb631088e571"

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
