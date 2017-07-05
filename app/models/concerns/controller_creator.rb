module ControllerCreator
	extend ActiveSupport::Concern

	def create_controller(doc)
	  path = "#{Dir.pwd}/app/controllers/#{doc.name.downcase.pluralize.gsub(/[ -]/, "_")}_controller.rb"
	  content = "#{my_header(doc)}\n\n\t#{my_index(doc)}\n\n\t#{my_show(doc)}\n\n\t#{my_new(doc)}\n\n\t#{my_edit(doc)}\n\n\t#{my_create(doc)}\n\n\t #{my_update(doc)}\n\n\t #{my_destroy(doc)}\n\n private\n\n\t#{my_set(doc)}\n\n\t#{my_params(doc)}\n\n#{footer()}"
	  File.open(path, "w+") do |f|
	    f.write(content)
	  end
	end

	def destroy_controller(doc)
	  path = "#{Dir.pwd}/app/controllers/#{doc.name.downcase.pluralize.
	  gsub(/[ -]/, "_")}_controller.rb"
	  File.delete(path)
	end
private

	def my_header(doc)
		"class #{doc.name.camelcase.pluralize.gsub(/[ _]/, '')}Controller < ApplicationController\n\tbefore_action :set_#{doc.name.downcase.gsub(/[ -]/, "_")}, only: [:show, :edit, :update, :destroy]\n\trespond_to :json"
	end

	def my_index(doc)
		"def index\n\t\t@#{doc.name.pluralize.downcase.gsub(/[ -]/, "_")} = #{doc.name.camelcase.singularize.gsub(/[ _]/, '')}.all\n\t\trespond_with @#{doc.name.pluralize.downcase.gsub(/[ -]/, "_")}\n\tend"
	end

	def my_show(doc)
		"def show\n\t\trespond_with @#{doc.name.singularize.downcase.gsub(/[ -]/, "_")}\n\tend"
	end

	def my_new(doc)
		"def new\n\t\t@#{doc.name.singularize.downcase.gsub(/[ -]/, "_")} = #{doc.name.camelcase.singularize.gsub(/[ _]/, '')}.new\n\t\trespond_with @#{doc.name.downcase.gsub(/[ -]/, "_")}\n\tend"
	end

	def my_edit(doc)
		"def edit\n\t\trespond_with @#{doc.name.singularize.downcase.gsub(/[ -]/, "_")}\n\tend"
	end

	def my_create(doc)
		"def create\n\t\t@#{doc.name.singularize.downcase.gsub(/[ -]/, "_")} = #{doc.name.camelcase.singularize.gsub(/[ _]/, '')}.new(#{doc.name.singularize.downcase.gsub(/[ -]/, "_")}_params)\n\t\tflash[:notice]='#{doc.name.downcase} created!' if @#{doc.name.singularize.downcase.gsub(/[ -]/, "_")}.save\n\t\trespond_with @#{doc.name.downcase.gsub(/[ -]/, "_")}\n\tend"
	end

	def my_update(doc)
		"def update\n\t\tflash[:notice]='#{doc.name.downcase} updated!'if @#{doc.name.singularize.downcase.gsub(/[ -]/, "_")}.update(#{doc.name.singularize.downcase.gsub(/[ -]/, "_")}_params)\n\t\trespond_with @#{doc.name.downcase.gsub(/[ -]/, "_")}\n\tend"
	end

	def my_destroy(doc)
		"def destroy\n\t\t@#{doc.name.singularize.downcase.gsub(/[ -]/, "_")}.destroy\n\t\trespond_with @#{doc.name.downcase.gsub(/[ -]/, '_')}\n\tend"
	end

	def my_set(doc)
		param = "find( params[:id] )"
		"def set_#{doc.name.singularize.downcase.gsub(/[ -]/, "_")}\n\t\t@#{doc.name.singularize.downcase.gsub(/[ -]/, "_")} = #{doc.name.camelcase.singularize.gsub(/[ _]/, '')}.find(params[:id])\n\tend"
	end

	def my_params(doc)
		permited = doc.model_fields.select do |f|
      f.field_name.present?
    end.map do |f|
      ":#{f.field_name}"
    end.join(",")

		"def #{doc.name.singularize.downcase.gsub(/[ -]/, "_")}_params\n\t\tparams.require(:#{doc.name.singularize.downcase.gsub(/[ -]/, "_")}).permit( #{permited.gsub(/[ -]/, "_")} )\n\tend"
	end

	def footer()
		"end"
	end

end
