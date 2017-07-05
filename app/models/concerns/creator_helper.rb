module CreatorHelper
	extend ActiveSupport::Concern

  def create_model(doc)
    path = "#{Dir.pwd}/app/models/#{doc.name.downcase.singularize.gsub(/[ -]/, "_")}.rb"
    fields = doc.model_fields.select do |f| 
      f.field_name.present?
    end.map do |f|
      "field :#{f.field_name.gsub(/[ -]/, "_")}, type: #{f.field_type}\n\t"
    end.join
    content = "class #{doc.name.camelcase.gsub(/[ _]/, "")}\n\tinclude Mongoid::Document\n\tinclude Mongoid::Timestamps\n\n\t#{fields}\nend"
    File.open(path, "w+") do |f|
      f.write(content)
    end
  end

  def destroy_model(doc)
    path = "#{Dir.pwd}/app/models/#{doc.name.downcase.gsub(/[ -]/, "_")}.rb"
    File.delete(path)
  end

  def create_route(doc)
    path = "#{Dir.pwd}/config/routes.rb"
    tmp_path = "#{Dir.pwd}/config/routes.tmp"
    content = "\tresources :#{doc.name.downcase.gsub(/[ -]/, "_").pluralize}"

    tempfile=File.open(tmp_path, 'w')

    f=File.new(path)
    f.each do |line|
     tempfile<<line
     if line.downcase=~/:creators/
       tempfile << "#{content}\n"
     end
    end
    f.close
    tempfile.close

    FileUtils.mv(tmp_path, path)
  end

  def destroy_route(doc)
    path = "#{Dir.pwd}/config/routes.rb"
    content = "\tresources :#{doc.name.downcase.gsub(/[ -]/, "_").pluralize}"
    lines = File.readlines(path)
    
    File.open(path, "w") do |f|
     lines.each { |line| f.puts(line) unless line.end_with? "#{doc.name.downcase.gsub(/[ -]/, "_").pluralize}\n" }
    end
  end
end
