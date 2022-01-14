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
  version "0.34"
  url "https://github.com/oleg-st/DevSync/releases/download/#{version}/DevSync6.zip"
  homepage "https://github.com/oleg-st/DevSync"
  sha256 "56d80b532185cc66c2ab1ccb7e6e33a40d158548c840863b9961ae6b08743b56"

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
