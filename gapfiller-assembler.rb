require "formula"

class GapfillerAssembler < Formula
  homepage "http://sourceforge.net/projects/gapfiller/"
  #doi "10.1186/1471-2105-13-S14-S8"
  url "https://downloads.sourceforge.net/project/gapfiller/v2.1.1/gapfiller-2.1.1.tar.gz"
  sha1 "931df951ab3f4b4e426a0ffd4e8fe9e835304496"

  depends_on "autoconf" => :build
  depends_on "boost"

  def install
    # error: cannot not find the flags to link with Boost thread
    system "curl https://raw.githubusercontent.com/tsuna/boost.m4/master/build-aux/boost.m4 >m4/boost.m4"
    system "autoconf"

    system *%W[./configure
        --disable-debug --disable-dependency-tracking --disable-silent-rules
        --prefix=#{prefix}]

    # Undefined symbols for architecture x86_64: _gzopen
    system *%W[make LIBS=-lz]

    bin.install "src/GapFiller"
    libexec.install "src/GapFiller_debug"
    doc.install %w[AUTHORS COPYING README]
  end

  test do
    system "#{bin}/GapFiller --help"
  end
end
