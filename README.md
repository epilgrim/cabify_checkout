Cabify Physical Store Checkout Process
======================================

How to run
----------

The expectations required in the description of the assignment can be run with:

    docker-compose run --rm specs rspec spec/cabify_spec.rb

The full test suit of the exercise can be run with:

    docker-compose run --rm specs

If docker/compose not available, then run with the usual

    bundle install --path vendor/bundle
    bundle exec rspec

> ruby >2.1 is required

The file `spec/cabify_spec.rb` contains the expectatios set in the test description. Let's call it "integration test".

All the other tests are unit tests.

Things that I would change if pushing further
---------------------------------------------

* Separation of Item / InvoiceItem.

  At this point, the same model is reused to represent both domain objects. It should be made explicit that they are two different concepts. That way, InvoiceItem would be able to differenciate normal Items (from real products), from the generated ones (eg. discounts)

* Creation of Domain Concepts Cart and Invoice as container for Items and InvoiceItem.

  This will let me model this concepts as immutable objects (as opposed to plain arrays as it is right now), and enforce side-effect free transformations.

* Use Repository inside the discounts classes

  Currently I'm using the first occurrence of the Item with a given code to get it's data. I should be reaching for the repository to return this item.

* Creation of a real repository

  Persistent data is good, isn't it?
