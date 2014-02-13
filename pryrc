# === Listing config ===
# Better colors - by default the headings for methods are too
# similar to method name colors leading to a "soup"
# These colors are optimized for use with Solarized scheme
# for your terminal

# vi mode in pry
# Readline.vi_editing_mode
Pry.config.ls.separator = "\n" # new lines between methods
Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :green
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :bright_black

Pry.config.prompt = proc do |obj, level, _|
  prompt = ""
  prompt << "#{Rails.version}@" if defined?(Rails)
  prompt << "#{RUBY_VERSION}"
  "#{prompt} (#{obj})> "
end

Pry.config.exception_handler = proc do |output, exception, _|
  output.puts "\e[31m#{exception.class}: #{exception.message}"
  output.puts "from #{exception.backtrace.first}\e[0m"
end

if defined?(Rails)
  begin
    require "rails/console/app"
    require "rails/console/helpers"
  rescue LoadError => e
    require "console_app"
    require "console_with_helpers"
  end
end

begin
  require "awesome_print"
  Pry.config.print = proc {|output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output)}
rescue LoadError => err
  warn "=> Unable to load awesome_print"
end

# === COLOR CUSTOMIZATION ===
# Everything below this line is for customizing colors, you have to use the ugly
# color codes, but such is life.
CodeRay.scan("example", :ruby).term # just to load necessary files

if Gem::Version.new(CodeRay::VERSION) >= Gem::Version.new('1.1.0')
 TERM_TOKEN_COLORS = {
        :attribute_name => "\e[33m",
        :attribute_value => "\e[31m",
        :binary => "\e[1;35m",
        :char => {
          :self => "\e[36m", :delimiter => "\e[34m"
        },
        :class => "\e[1;35m",
        :class_variable => "\e[36m",
        :color => "\e[32m",
        :comment => "\e[37m",
        :complex => "\e[34m",
        :constant => "\e[34m\e[4m",
        :decoration => "\e[35m",
        :definition => "\e[1;32m",
        :directive => "\e[32m\e[4m",
        :doc => "\e[46m",
        :doctype => "\e[1;30m",
        :doc_string => "\e[31m\e[4m",
        :entity => "\e[33m",
        :error => "\e[1;33m\e[41m",
        :exception => "\e[1;31m",
        :float => "\e[1;35m",
        :function => "\e[1;34m",
        :global_variable => "\e[42m",
        :hex => "\e[1;36m",
        :include => "\e[33m",
        :integer => "\e[1;34m",
        :key => "\e[35m",
        :label => "\e[1;15m",
        :local_variable => "\e[33m",
        :octal => "\e[1;35m",
        :operator_name => "\e[1;29m",
        :predefined_constant => "\e[1;36m",
        :predefined_type => "\e[1;30m",
        :predefined => "\e[4m\e[1;34m",
        :preprocessor => "\e[36m",
        :pseudo_class => "\e[34m",
        :regexp => {
          :self => "\e[31m",
          :content => "\e[31m",
          :delimiter => "\e[1;29m",
          :modifier => "\e[35m",
          :function => "\e[1;29m"
        },
        :reserved => "\e[1;31m",
        :shell => {
          :self => "\e[42m",
          :content => "\e[1;29m",
          :delimiter => "\e[37m",
        },
        :string => {
          :self => "\e[36m",
          :modifier => "\e[1;32m",
          :escape => "\e[1;36m",
          :delimiter => "\e[1;32m",
        },
        :symbol => "\e[1;31m",
        :tag => "\e[34m",
        :type => "\e[1;34m",
        :value => "\e[36m",
        :variable => "\e[34m",

        :insert => "\e[42m",
        :delete => "\e[41m",
        :change => "\e[44m",
        :head => "\e[45m"
  }
else
  TERM_TOKEN_COLORS = {
        :attribute_name => '33',
        :attribute_value => '31',
        :binary => '1;35',
        :char => {
          :self => '36', :delimiter => '34'
        },
        :class => '1;35',
        :class_variable => '36',
        :color => '32',
        :comment => '37',
        :complex => '34',
        :constant => ['34', '4'],
        :decoration => '35',
        :definition => '1;32',
        :directive => ['32', '4'],
        :doc => '46',
        :doctype => '1;30',
        :doc_string => ['31', '4'],
        :entity => '33',
        :error => ['1;33', '41'],
        :exception => '1;31',
        :float => '1;35',
        :function => '1;34',
        :global_variable => '42',
        :hex => '1;36',
        :include => '33',
        :integer => '1;34',
        :key => '35',
        :label => '1;15',
        :local_variable => '33',
        :octal => '1;35',
        :operator_name => '1;29',
        :predefined_constant => '1;36',
        :predefined_type => '1;30',
        :predefined => ['4', '1;34'],
        :preprocessor => '36',
        :pseudo_class => '34',
        :regexp => {
          :self => '31',
          :content => '31',
          :delimiter => '1;29',
          :modifier => '35',
          :function => '1;29'
        },
        :reserved => '1;31',
        :shell => {
          :self => '42',
          :content => '1;29',
          :delimiter => '37',
        },
        :string => {
          :self => '36',
          :modifier => '1;32',
          :escape => '1;36',
          :delimiter => '1;32',
        },
        :symbol => '1;31',
        :tag => '34',
        :type => '1;34',
        :value => '36',
        :variable => '34',

        :insert => '42',
        :delete => '41',
        :change => '44',
        :head => '45'
  }
end

module CodeRay
  module Encoders
    class Terminal < Encoder
      # override old colors
      TERM_TOKEN_COLORS.each_pair do |key, value|
        TOKEN_COLORS[key] = value
      end
    end
  end
end
