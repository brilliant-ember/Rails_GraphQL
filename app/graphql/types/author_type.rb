class Types::AuthorType < Types::BaseObject
# This is the "json" object of an author, the field
#key is  :name, and the content type is teh next argument
#field(:key, contentType, isNullable?) 
# a field is key value pair 
    description "An author"

    field :id, ID, null:false
    field :first_name, String, null:true
    field :yob, Int, null: false
    field :is_alive, Boolean, null:true

    # This say_hi function is defined in the model so I can use it here
    field :say_hi, String, null:false 

    #I can define fields to tie em to a funciton like this
    field :name_and_id, String, null:false
    def name_and_id
        [object.id, object.first_name]
    end

    field :coordinates, Types::CoordinatesType, null: false

    def coordinates
        [rand(99), rand(99)]
    end
end