__Ruby notes__

terminal command irb --> ruby interpreter
close it with ctrl + D
ctrl + k clears the screen

puts is the same as print
8.odd? returns false
8.even? returns true
[1,"a", 5] << "hey" --> appends "hey" to the array
[1,2,3] + [4, 5, 6] --> [1, 2, 3, 4, 5, 6]

Symbols data type is like strings, only that it starts by : instead of being wrapped with ""
example:
    :apple --> symbol
    "apple" --> string
Symbols are more efficient and use less memory. If u call :a.object_id it will show a smaller
 number than "a".object_id.
 Symbols are used a lot for hash map-keys
 a = {:first_name => "Mohammed",
  "last_name": "ice cream",
   1=>55}
 a[:first_name] -outputs-> Mohammed ..etc

 _Functions_
 you can do it with out parameter passing
 def hey
    puts "yo"
    end

def hey(x)
    puts x
    end

_Conditional_
if 5 > 2 --> true
unless 5 > 2 --> false (unless is like if not)
elsif and else --> the usual 
example
    if a > 2
        puts "I"
    elsif a ==1
        puts "really"
    else
        puts "like strawberry"
    end
_Loopy loops_
    list = [1,2,3,4]
    list.each do |i|
        puts i*2
    end
or we can do it like this
    list.each{|i| puts i*2}

or even like this:
    for elem in list
        put elem
    end

5.times do  # a way to do something 5 times 
end

_Classes_

    class Book:
        # the attributes this class has
        attr_accessor :title, :author, :pages

        #init
        def initalize(title, auth, pages)
        # @title is like self.title in python 
        @title = title
        @author = auth
        @pages = pages
        end
    end

    book = Book.new()   
    book.title = "harry potter"
    book.author = "jk"
    book.pages = 400

    book_two = Book.new("harry potter", "jk", 400)

    # inheritance
     class BlueBook < Book
      # has access to all funcs from book because I inherit from it
     end

     @var is for instance vars
     @@class_var is for the whole class var "static variable in jave", static methods are denoted with self.method

_modules_

it is just a file of functions so I can use them later, it has to be included even if moduel was defined in teh same file

    module MyTools
        def blah
        end
        def blahblah
        end
    end

Now to use the functions in MyTools inside the same file

    include MyTools
    MyTools.blah

To import the MyTools to other files you can use one of two import keywords "there could be more"
    1. require ""
    2. require_relative "file of my tools.rb" #relative to the importing file

Then you include teh moduel to use it in the other file
    include module


<!-- END OF RUBY BEGINNING OF RAILS -->
To create a project with rails do this:
	rails new project_name
To run it in browser
	rails server

rails creates a lot of directories for you.
. The app dir has the MVC directories, plus assets, javascript and other related stuff. MVC stands for model view controller.

The Model  calls databases, it handles busniess logic ...etc
View handles UI.
Controller sits between view and model, and it controls the data flow between them.
. The bin dir has app executables, ie ruby scripts for example u can call the bundle terminal command.

. config dir handles configs ...duh but also note that the DB dir doesn't handle db configs, the config dir does, it has a file called database.yaml that does that.

. lib dir is for reusable code libraries
. log dir has log files
. public dir has html pages that show even if your app crashes, so good spot to p ut your error pages
. test dir has the tests and other related stuff
. tmp dir holds tmp files like cache, sessions, pid ...etc
. vendor dir assets for 3rd party gems
. Gemfile is has a list of ruby gem dependencies
. Rakefile used to locate files that will be run in the terminal


__Creating a model__

rails generate model model_name title:blah body:blah blah:blah
it is as if it creates a class called model_name with a hashmap that u define
with the following types
string -> short texts </br>
text -> long text </br>
boolean </br>
integer </br>
decimal -> accurate </br>
float -> not as accurate as decmial cuz its rounded </br>
binary --> can be used for files </br>
timestamp </br>
date </br>
time </br>
datetime </br>
priimary_key </br>
	example:
	*rails generate model Article title:string body:text*</br>	

If you run into troubles with the previous command try this which worked for me</br>
	*bundle config --delete bin
	rails app:update:bin
	git add bin* </br>
then run the rails generate command.

This will create a model in ./app/model and will create a migratge rb file that creates your model(object) in the database. But that's just a script that creates it in the database, to actually create it you have to run the command</br>
	*rake db:migrate*</br>
which will create the db schema, a schema is like a snapshot of your current db

__Creating a controller__

The controller's job is to grab data from the model and give it to the view
*rails g controller Articles index* </br>
The index is optional but it will create a view and a route for your article(s).
The create controller command creates the controller in the app/controller dir
and it creates a test_unit in test/controller, and a creates assets in the app/assets dir. If you open the controller created you will see this </br>
*class ArticlesController < ApplicationController
  def index
  end
end* </br>
Which means that the ArticlesController inherites from the ApplicationController
</br> The index function corrsponds to the view at ./app/articles/index.html.erb
, you can navigate to it in the browser with http://127.0.0.1:3000/articles/index

__Routes__

# routes buddy with controllers! in routes file u point to controllers 

*rake routes*</br> shows you all the routes ur app has. Your Articales route is in the ./config/routes.rb </br>
From the last step "createing a controller" we got to view our index page from the local host url, now if we went to the routes dir and changed *get 'articles/index'* to *get 'articles/inddex'* for example we will see that the browswer will error on you even if you changed the url to inddex insted of index. This is because you don't have a controller function in the articles_contoller.rb with the name inddex yet. If you wanna see the route inddex come to life, you have to create a function for it in the controller and create a view ".html" file for it </br>

To create automatically all the routes you need for CRUD (create read update destroy) change the route to *resources :articles* and verifiy with rake routes command.

_Notes for running rails__
You may run into troubles like the computer telling u that rails is not installed, even if it is. This is because it is not loaded to the exexutable path so u can't run it frm terminal
Run this command to fix that in linux.
Replace mo with your username. </br>
  	*export PATH="$PATH:/home/mo/.gem/bin"
  	source ~/.profile* </br>

## in the routes.rb the ruby syntax makes these 4 lines EQUAL
    get '/posts', controller: 'posts', action: 'index'
    get ('/posts', { :controller =>'posts', :action => 'index'})
    get '/posts' => 'posts#index'
    get ({'/posts' => 'posts#index'})

Now the  posts_controller.rb will invoke the function index, and u have to define it
    def index
    end
now even tho it is empty rails automagically types this for u 
    render 'app/views/posts/index.html.erb' and then for 'application/index'
So ur funciton actually is like this, even if it doesnt look it
    def index
        render 'app/views/posts/index.html.erb' # if it fails ut will look at application/index 
    end

## MISC ##

- bundle install command is like npm install, will go through the gemfile and install the dependencies
- someroute/route#index shows u posts list, and if u click on one of them you will go to the #show page
- someroute/route#show shows u a single aritcle or post if you have alist of them, u have to define all those #show and index in the controller of that 'article'
- the hash after a route name is the controller action
- param names ending with ':' are defined vars.
 for example in python I say func(x=3), in Ruby func( x: 3)
- have a console to your app, ie use models and all use this command from inside your webapp dir
    rails console or rails c 


 ## GrapQl ##

- GraphQl, the context object is accessable to all queries and mutations.
example of passing an argument.
- All functions must accept that argument  ':name' otherwise there will be an error, the field function takes in this field(varName, type, canBeNull)

``` ruby

 field :test_field, String, null: false,
      description: "An example field added by the generator" do
      argument :name, String , required: true
      end
    def test_field(name:)
      puts context.inspect
      "Hello #{name}!"
    end
  end

```

- the fields of a graphQl type, say an author has name and last name fields defined in his author_type.rb. You can also define fields if they have functions in the model with the same name, ie, if the name of the field corrsponds to a name on the model then graphQl will take the return of the function in the model 
