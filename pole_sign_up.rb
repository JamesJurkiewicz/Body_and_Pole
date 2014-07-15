require 'mongoid'

class Pole_sign_up
  include Mongoid::Document

  field :name,  		type: String
  field :email, 		type: String
  field :start_date,	type: String
  field :level, 		type:String
 
end
 