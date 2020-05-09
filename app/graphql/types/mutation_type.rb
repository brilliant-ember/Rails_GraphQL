module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end
# One way to create mutaions is like this with the mutation resultion function right below.
    field :create_author, AuthorType, null: true,
     description: "Create an author" do   
      argument :first_name, String, required: false, camelize: false
      argument :yob, Int, required: false, camelize: false
      argument :is_alive, Boolean, required: false, camelize: false
     end
     
    def create_author(first_name:, yob:, is_alive:)
      Author.create(first_name: first_name, yob: yob, is_alive: is_alive)
    end
# The other way to create mutation is by defining it here, then writeing the resolution funciton in the mutation name space
# ie in the file graphql/mutations
  field :create_author2, Types::AuthorType, mutation: Mutations::CreateAuthor2 


  # a third way is to create a class authorinputtype and use it to contain our arguments, example mutation req is 
  # in the author_input_type class
  field :create_author3, AuthorType, null: true, description: "Class contained author" do
    argument :author, Types::AuthorInputType, required: true
    end
    def create_author3(author:)
      #we convert it to has here
      Author.create author.to_h
    end

    # return type is true or false as to say did it update or not
    field :update_author, Boolean, null:false, description: "Update an author" do
      argument :author, Types::AuthorInputType, required: true
    end

    def update_author(author:)
      exists = Author.where(id: author[:id]).first
      exists&.update author.to_h
    end

  end
end
