class ListsService
  def for_autocomplete(list)
    json = '{'
    list.each do |element|
      json += "\"#{element}\": null,"
    end
    json = json.chop
    json + '}'
  end

  def java_insert_sqls(list)
    sql = ''
    list.each do |element|
      sql += "&nbsp;&nbsp;&nbsp;&nbsp;db.execSQL(\"#{element.to_sql}\");<br/>"
    end
    sql
  end

  def java_update_sqls(list, with_description, only_description)
    sql = ''
    list.each do |element|
      update_sql = element.to_update_sql(with_description, only_description)
      sql += "&nbsp;&nbsp;&nbsp;&nbsp;db.execSQL(\"#{update_sql}\");<br/>"
    end
    sql
  end

  def java_delete_sqls(list, table)
    sql = ''
    list.each do |element|
      delete_sql = "DELETE FROM #{table} where id = \\\"#{element.id}\\\""
      sql += "&nbsp;&nbsp;&nbsp;&nbsp;db.execSQL(\"#{delete_sql}\");<br/>"
    end
    sql
  end

  def sqls_function(table_name, sqls)
    sql = "function insert#{table_name}() {<br/>"
    sql += sqls
    sql + '}<br/><br/>'
  end
end
