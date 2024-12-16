class Kubeclick < Formula
  desc "CLI tool to simplify Kubernetes operations"
  homepage "https://github.com/kubeclick/kubeclick"
  version "0.1.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/kubeclick/kubeclick/releases/download/v0.1.0/kc-darwin-amd64"
      sha256 "REPLACE_WITH_ACTUAL_SHA256"
    elsif Hardware::CPU.arm?
      url "https://github.com/kubeclick/kubeclick/releases/download/v0.1.0/kc-darwin-arm64"
      sha256 "REPLACE_WITH_ACTUAL_SHA256"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/kubeclick/kubeclick/releases/download/v0.1.0/kc-linux-amd64"
    sha256 "REPLACE_WITH_ACTUAL_SHA256"
  end

  depends_on "kubernetes-cli"

  def install
    bin.install Dir["kc-*"].first => "kc"
  end

  test do
    system "#{bin}/kc", "--version"
  end
end
