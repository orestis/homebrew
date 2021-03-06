require 'brewkit'

class ErlangManuals <Formula
  @homepage='http://www.erlang.org'
  @url='http://erlang.org/download/otp_doc_man_R13B01.tar.gz'
  @md5='fa8f96159bd9a88aa2fb9e4d79d7affe'
end

class ErlangHtmlDocs <Formula
  @homepage='http://www.erlang.org'
  @url='http://erlang.org/download/otp_doc_html_R13B01.tar.gz'
  @md5='42cb55bbfa5dc071fd56034615072f7a'
end

class Erlang <Formula
  @homepage='http://www.erlang.org'
  @url='http://erlang.org/download/otp_src_R13B01.tar.gz'
  @md5='b3db581de6c13e1ec93d74e54a7b4231'

  def deps
    LibraryDep.new 'icu4c'
    LibraryDep.new 'openssl'
  end

  # def patches
  #   [
  #     "http://pastie.org/603456.txt",
  #     "http://pastie.org/603462.txt",
  #     "http://svn.macports.org/repository/macports/trunk/dports/lang/erlang/files/patch-lib-erl_interface-include-ei.h.diff",
  #     "http://svn.macports.org/repository/macports/trunk/dports/lang/erlang/files/patch-lib-erl_interface-src-connect-ei_connect.c.diff",
  #     "http://pastie.org/603469.txt",
  #     "http://pastie.org/603475.txt",
  #     "http://pastie.org/603478.txt",
  #     "http://pastie.org/603480.txt",
  #     "http://pastie.org/603481.txt",
  #     "http://pastie.org/603485.txt"
  #   ]
  # end

  def install
    ENV.deparallelize
    config_flags = ["--disable-debug",
                          "--prefix=#{prefix}",
                          "--enable-kernel-poll",
                          "--enable-threads",
                          "--enable-dynamic-ssl-lib",
                          "--enable-smp-support",
                          "--enable-hipe"]
    config_flags << "--enable-darwin-64bit" if Hardware.intel_family == :core2 and MACOS_VERSION == 10.6

    system "./configure", *config_flags
    system "make"
    system "make install"

    ErlangManuals.new.brew { man.install Dir['man/*'] }
  end
end