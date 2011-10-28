Batchr
======

Installation
------------

### With Bundler

    gem 'batchr'

### With Only Rubygems

    $ gem install batchr

Usage
-----

    class Receiver
      def self.message objects = []
        # your code do deal with a "batch" of objects
      end
      def instance_message objects = []
        # perhaps send the objects off to a DB
      end
    end

    Batchr.batch(Receiver, :message) do |batchr|
      1_000_000.times do
        batchr << rand(2)
      end
    end

    Batchr.batch(Receiver.new, :instance_message) do |b|
      b.batch_size = 4000 # default is 400
      5_000.times do # instance_message will be sent once, after 4000 calls
        b << rand(2)
      end
    end # instance_message will be sent once here, too, with the remaining 1000 random numbers

Why?
----

I found this useful when I was parsing a large CSV file and storing the results in a DB. The DB was slow to insert the rows individually, and couldn't handle an import the size of the entire file. So, I created Batchr to batch the parsed CSV into the DB.

Contributing
------------

Want to contribute? Great!

1. Fork it.
1. Create a branch (git checkout -b my_feature).
1. Commit your changes (git commit -am "Added Awesomeness").
1. Push to the branch (git push origin my_feature).
1. Create an Issue with a link to your branch.
1. Enjoy a refreshing beverage of your choice and wait.
