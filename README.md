# ThreadPool

A simple ThreadPool that satisfies the following criteria of the thread pool pattern:

#### Semaphores

Passing in an integer that will spin up that number of threads to execute the queue, and no more.

#### Reuse of threads

Threads will not be recreated when a new task needs to be worked on.  Thread destruction and creation can be expensive, so reusing Threads is an important part of performance in a thread pool.

#### Threadsafe operations

The threads use a shared queue, which is threadsafe by using the ruby ```Queue``` object.

## Usage

The first argument is a list of tasks that have to respond to ```call```.

The second argument is the count for the semaphore.

After instantiation, call ```execute``` and watch it go!

```ruby
task = lambda {p "Threading!"}
tasks = [task]
thread_count = 5

pool = ThreadPool.new(tasks, thread_count)

pool.execute
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'thread_pool_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thread_pool_ruby

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/thread_pool/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

