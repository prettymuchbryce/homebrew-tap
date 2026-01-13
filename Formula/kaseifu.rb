# typed: false
# frozen_string_literal: true

class Kaseifu < Formula
  desc "Automatically watch and organize files using configurable rules"
  homepage "https://github.com/prettymuchbryce/kaseifu"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/prettymuchbryce/kaseifu/releases/download/v#{version}/kaseifu_#{version}_darwin_arm64.tar.gz"
      sha256 "10dffac6baff1b536c86a4098e65f748de080aef00a279002d2bfac17672723f"
    end

    on_intel do
      url "https://github.com/prettymuchbryce/kaseifu/releases/download/v#{version}/kaseifu_#{version}_darwin_amd64.tar.gz"
      sha256 "b40c31c8283adc621ad8d9969046f38936f3595c1a74147145b2384bcd242442"
    end
  end

  def install
    bin.install "kaseifu"
  end

  service do
    run [opt_bin/"kaseifu", "daemon"]
    keep_alive true
    log_path var/"log/kaseifu.log"
    error_log_path var/"log/kaseifu.log"
  end

  def caveats
    <<~EOS
      To start kaseifu as a background service:
        brew services start kaseifu

      To stop the service:
        brew services stop kaseifu

      Logs are written to: #{var}/log/kaseifu.log
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kaseifu --version")
  end
end
