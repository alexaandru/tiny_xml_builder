require 'rubygems'
require 'blankslate'

module TinyXml
  class Builder < BlankSlate
    reveal :respond_to? unless RUBY_VERSION >= '1.9'
    def initialize(opts = {}, &block)
      @xml          = []
      @indent_level = opts[:indent_level] || opts['indent_level'] || 0
      @indent_size  = opts[:indent_size]  || opts['indent_size']  || 2
      block and instance_eval(&block)
    end

    def <<(xml)
      @xml << xml.to_s
    end

    def to_s
      @xml.join("\n")
    end

    def to_ary
      [to_s]
    end

    def method_missing(tag, *args, &block)
      indent     = ' ' * @indent_level * @indent_size
      attributes = args.last && args.last.is_a?(Hash) ? args.pop.inject(''){|acc,(k,v)| acc << " #{k}=\"#{v}\""} : ''
      if block
        @xml << "%s<%s%s>" % [indent, tag, attributes]
        @indent_level += 1; instance_eval(&block); @indent_level -= 1
        @xml << "%s</%s>" % [indent, tag]
      elsif args.empty?
        @xml << "%s<%s%s />" % [indent, tag, attributes]
      else
        args.map{|a| a && Array(a)}.flatten.each do |val| 
          @xml << "%s<%s%s>%s</%s>" % [indent, tag, attributes, val, tag]
        end
      end
      self
    end
  end
end
