# typed: false
# frozen_string_literal: true

class Autotidy < Formula
  desc "Automatically organize files using declarative rules"
  homepage "https://github.com/prettymuchbryce/autotidy"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/prettymuchbryce/autotidy/releases/download/v#{version}/autotidy_#{version}_darwin_amd64.tar.gz"
      sha256 "5880c8b551fb0f87d63fc40551a691ff6cedbfad1a12334922505425f7d82476"
    end

    on_arm do
      url "https://github.com/prettymuchbryce/autotidy/releases/download/v#{version}/autotidy_#{version}_darwin_arm64.tar.gz"
      sha256 "18c059ab57efba59bf91b45c2f9c9ee64ca4adafd9b57c4aac99cb8bf61da943"
    end
  end

  def install
    bin.install "autotidy"
  end

  service do
    run [opt_bin/"autotidy", "daemon"]
    keep_alive true
    log_path var/"log/autotidy.log"
    error_log_path var/"log/autotidy.log"
  end

  def caveats
    <<~EOS
      To start autotidy as a background service:
        brew services start autotidy && autotidy status

      To stop the service:
        brew services stop autotidy

      To check the current status:
        autotidy status
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/autotidy --version")
  end
end
