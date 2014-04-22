require "formula"

class Nvbio < Formula
  homepage "https://developer.nvidia.com/nvbio"
  url "https://github.com/NVlabs/nvbio/archive/3e6efbdf5f8e6ac69beaed2f78bb64ac5aab3e09.tar.gz"
  version "0.9.5"
  sha1 "c55f2e804d6a87ce34671f9fe355376350741096"
  head "https://github.com/NVlabs/nvbio.git"

  # No formula: depends_on "cuda"

  fails_with :clang do
    build 503
    cause 'Requires OpenMP. error: identifier "crcCalc" is undefined'
  end

  fails_with :gcc do
    build 5666
    cause "internal compiler error: in get_expr_operands, at tree-ssa-operands.c:2093"
  end

  fails_with :gcc => "4.8" do
    cause 'error: identifier "__int128" is undefined'
  end

  depends_on "cmake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/nvbio --version"
  end
end
