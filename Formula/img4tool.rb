class Img4tool < Formula
  desc "Tool for manipulating IMG4, IM4M and IM4P files"
  homepage "https://github.com/tihmstar/img4tool"
  url "https://github.com/tihmstar/img4tool.git",
    :tag => "182"
  head "https://github.com/tihmstar/img4tool.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libplist"
  depends_on "libtihmstar-general"
  depends_on "openssl@1.1"

  def fix_tihmstar
    inreplace %w[configure.ac],
      "git rev-list --count HEAD",
      "echo #{version.to_s.gsub(/[^\d]/, "")}",
      false
  end

  def install
    fix_tihmstar

    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"

    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end
end
