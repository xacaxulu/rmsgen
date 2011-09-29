module Rmsgen
  module Part

    TOKEN_PARTS = {
      /^http/ => Rmsgen::Parts::Url,
      /Return-Path:/ => Rmsgen::Parts::Header,
      /\[Link/i => Rmsgen::Parts::PolnoteUrlRequest,
      /Dr Richard Stallman/ => Rmsgen::Parts::Footer,
      /^   / => Rmsgen::Parts::IndentedLine,
      /^For.*week.*$/ => Rmsgen::Parts::Duration
    }

    def self.parse(raw)
      token_part = TOKEN_PARTS.find { |pattern, part| raw =~ pattern }
      return Rmsgen::Parts::PlainText.new(raw) unless token_part
      token_part[1].new(raw)
    end
  end
end
