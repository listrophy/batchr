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
    end

    Batchr.batch(Receiver, :message) do |batchr|
      # batchr.batch_size = 400 (default)
      1_000_000.times do
        batchr << rand
      end
    end

Contributing
------------

Want to contribute? Great!

1. Fork it.
1. Create a branch (git checkout -b my_feature).
1. Commit your changes (git commit -am "Added Awesomeness").
1. Push to the branch (git push origin my_feature).
1. Create an Issue with a link to your branch.
1. Enjoy a refreshing beverage of your choice and wait.
