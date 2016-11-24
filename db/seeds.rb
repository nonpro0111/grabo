Dir.glob("#{Rails.root}/db/seeds/*.yml").each do |filename|
  table_name = File.basename(filename,".yml")
  ActiveRecord::Base.connection.execute("TRUNCATE TABLE `#{table_name}`")
  klass = File.basename(filename,".yml").classify.constantize
  data = YAML.load_file(filename)
  data.values.each do |attr|
    klass.create(attr)
  end
end
