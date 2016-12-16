# Documentation: https://github.com/Homebrew/brew/blob/master/docs/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Ic < Formula
  desc ""
  homepage ""
  url "https://github.com/lovelock/ic/archive/0.0.3.tar.gz"
  version "0.0.3"
  sha256 "a6bc45f0496528d65a41e4d92bd81ad3435bc2a1506518b1fa5631e121500d3b"

  depends_on "go"

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
    system "go", "build", "-o", bin/"ic"
    system "export", "PROG=ic source autocomplete/zsh_autocomplete"
  end


  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test ic`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    #system "false"
  end
end
