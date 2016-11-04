#!/usr/bin/ruby

module Helper

  # In the event nokogiri throws a nil, handle the output differently...
  # or else it'll break the script.
  def parse_text(value)
    if (value.class == Nokogiri::XML::Element)
      return value.text.strip
    end

    # Pass the same object type regardless.
    return ''
  end

end