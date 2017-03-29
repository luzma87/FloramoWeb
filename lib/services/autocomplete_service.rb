class AutocompleteService
  def for_autocomplete(list)
    json = '{'
    list.each do |element|
      json += "\"#{element}\": null,"
    end
    json = json.chomp(',')
    json += '}'
  end
end
