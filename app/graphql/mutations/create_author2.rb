class Mutations::CreateAuthor2 < GraphQL::Schema::Mutation
    null true
    argument :first_name, String, required: false, camelize: false
    argument :yob, Int, required: false, camelize: false
    argument :is_alive, Boolean, required: false, camelize: false

    def resolve(first_name:, yob:, is_alive:)
        Author.create(first_name: first_name, yob: yob, is_alive: is_alive)
    end
end