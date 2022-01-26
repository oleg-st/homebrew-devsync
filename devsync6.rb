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
  version "0.35"
  url "https://github.com/oleg-st/DevSync/releases/download/#{version}/DevSync6.zip"
  homepage "https://github.com/oleg-st/DevSync"
  sha256 "6733a29a9affd889637742a3eef9c9ebe3c1f1550be0e7d9fba1110fd93e3607"

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
