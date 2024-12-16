class Kubeclick < Formula
  desc "CLI tool to simplify Kubernetes operations"
  homepage "https://github.com/kubeclick/kubeclick"
  version "0.1.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/kubeclick/kubeclick/releases/download/v0.1.0/kc-darwin-amd64"
      sha256 "9f89105d0907eafe5d367dc8c5475acd61973d5bcea31127f9ea4d1b2d993358"
    elsif Hardware::CPU.arm?
      url "https://github.com/kubeclick/kubeclick/releases/download/v0.1.0/kc-darwin-arm64"
      sha256 "d424c90fd06a445070e9880878f37c5767b3c302fe9d9340c269b784926e675d"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/kubeclick/kubeclick/releases/download/v0.1.0/kc-linux-amd64"
    sha256 "feb15ab28c90dcb9544e71c5748c38b50bb7ab5f2272b8a430ea0165bcb35a04"
  end

  depends_on "kubernetes-cli"

  def install
    bin.install Dir["kc-*"].first => "kc"
  end

  test do
    system "#{bin}/kc", "--version"
  end
end
