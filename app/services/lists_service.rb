class ListsService
  def for_autocomplete(list)
    json = '{'
    list.each do |element|
      json += "\"#{element}\": null,"
    end
    json = json.chop
    json += '}'
  end

  def java_sqls(list)
    sql = ''
    list.each do |element|
      sql += "&nbsp;&nbsp;&nbsp;&nbsp;db.execSQL(\"#{element.to_sql}\");<br/>"
    end
    sql
  end
end
