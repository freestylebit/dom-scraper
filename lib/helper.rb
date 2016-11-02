module Helper

  # In the event nokogiri throws a nil, handle the output differently...
  # or else it'll break the script.
  def parse_text(value)
    if (value.is_a? Nokogiri::XML::Element)
      return value.text.strip
    else
      return nil
    end
  end

end