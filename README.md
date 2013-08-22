Batchr
======

[![Build Status](https://secure.travis-ci.org/listrophy/batchr.png)](http://travis-ci.org/listrophy/batchr)

Installation
------------

### With Bundler

    gem 'batchr'

### With Only Rubygems

    $ gem install batchr

Usage
-----

    class ApiSender
      def bulk_send objects = []
        # use some API that allows sending, say, up to 10 objects at once
      end
    end

    Batchr.batch(ApiSender.new, :bulk_send) do |batchr|
      b.batch_size = 10 # optional; default is 400
      read_really_really_long_csv_file do |row|
        batchr << row
      end
    end

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
1. Create a Pull Request
1. Enjoy a refreshing beverage of your choice and wait.
