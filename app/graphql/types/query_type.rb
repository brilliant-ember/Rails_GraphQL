module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator" do
      argument :name, String , required: true
      end
    def test_field(name:)
      puts context.inspect
      "Hello #{name}!"
    end

    field :author, Types::AuthorType, null: true, description: "author 1" do 
      argument :id, ID, required: true
      end
      def author(id:)
        Author.where(id: id).first
      end

      # this is the query that loggs a user in, and will return String which is the session key
      field :login, String, null:true, description: "the login query" do
        argument :email, String, required: true
        argument :password, String, required: true
      end

      def login (email:, password:)
        if user = User.where(email: email).first&.authenticate(password)
          user.sessions.create.key
        end
      end

  end
end
