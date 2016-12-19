require "language/go"

# Documentation: https://github.com/Homebrew/brew/blob/master/docs/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Ic < Formula
  desc ""
  homepage ""
  url "https://github.com/lovelock/ic/archive/0.0.3.tar.gz"
  version "0.0.3"
  sha256 "a6bc45f0496528d65a41e4d92bd81ad3435bc2a1506518b1fa5631e121500d3b"

  depends_on "go" => :build

  go_resource "github.com/urfave/cli" do
    url "https://github.com/urfave/cli.git",
      :revision => "d86a009f5e13f83df65d0d6cee9a2e3f1445f0da"
  end

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    ENV["GOPATH"] = buildpath
    ENV["GOOS"] = "darwin"
    ENV["GOARCH"] = MacOS.prefer_64_bit? ? "amd64" : "386"

    (buildpath/"src/github.com/lovelock/").mkpath
    ln_sf buildpath, buildpath/"src/github.com/lovelock/ic"
    Language::Go.stage_deps resources, buildpath/"src"
    system "go", "build", "-o", bin/"ic"
  end

  test do
  end
end
