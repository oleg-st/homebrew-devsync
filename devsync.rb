require "formula"

class DotnetRequirement < Requirement
  fatal true

  satisfy(:build_env => false) { which("dotnet") }

  def message; <<~EOS
    .NET Core 3+ Runtime is required; install it via:
    brew cask install dotnet
    EOS
  end
end

class Devsync < Formula
  depends_on DotnetRequirement
  version "0.25"
  url "https://github.com/oleg-st/DevSync/releases/download/#{version}/DevSync.zip"
  homepage "https://github.com/oleg-st/DevSync"
  sha256 "c4637bcf5812985a69e5dd7579865080d4fa0f02eb264b165fe83f3db2bbcb98"

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
