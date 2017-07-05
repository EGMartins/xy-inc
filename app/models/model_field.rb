class ModelField
  include Mongoid::Document
  field :field_name, type: String
  field :field_type, type: String

  embedded_in :creator

end
