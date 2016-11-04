#!/usr/bin/ruby
# frozen_string_literal: true

module Helper
  # In the event nokogiri throws a nil, handle the output differently...
  # or else it'll break the script.
  def parse_text(value)
    return value.text.strip if value.class == Nokogiri::XML::Element

    # Pass the same object type regardless.
    ''
  end
end
