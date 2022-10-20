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
  version "0.36"
  url "https://github.com/oleg-st/DevSync/releases/download/#{version}/DevSync5.zip"
  homepage "https://github.com/oleg-st/DevSync"
  sha256 "27459aa7e3391272a27bee86e020fd6ae105fd8724a0c20f8976d8a64df19697"

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
