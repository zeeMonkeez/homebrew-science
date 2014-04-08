require "formula"

class Gapfiller < Formula
  homepage "http://www.baseclear.com/landingpages/gapfiller/"
  #doi "10.1186/gb-2012-13-6-r56"
  url "http://www.baseclear.com/download.php?file_id=1170"
  version "1.11"
  sha1 "b37861c0e7140091c826260f8b3b45e00df7f9a8"

  depends_on "bowtie"
  depends_on "bwa"
  depends_on "Perl4::CoreLibs" => :perl # for getopts.pl

  def install
    # Convert CR-LF line endings to LF
    inreplace "GapFiller.pl", "\r", ""

    bin.install "GapFiller.pl"
    doc.install "README", "example", Dir["*.pdf"]
  end

  test do
    system "#{bin}/GapFiller.pl 2>&1 |grep GapFiller"
  end
end
