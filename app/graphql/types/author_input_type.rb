class Types::AuthorInputType < GraphQL::Schema::InputObject
#This is the class that we can use insode the graphql client

graphql_name "AuthorInputType"
description "The attibutes for createing an author"

argument :first_name, String, required: false, camelize: false
argument :yob, Int, required: false, camelize: false
argument :is_alive, Boolean, required: false, camelize: false

''' Example mutation

mutation createAuthorFunc ($author: AuthorInputType!){
    createAuthor3(author: $author){
      firstName
      id
      isAlive
      nameAndId
      sayHi
      yob
    }
  }
'''

end