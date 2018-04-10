# LingoKids test

I have consumed most of the time in the Paralellism and Rate Limit parts.

I enjoyed go deep into details, so I have spent time reading the Ruby api, and
other posts linked bellow.

I have done it in different slots of time, and I think I have spent a total of
12 hours. I tried to be very thorough with the details, but of course this can
be done in 4 hours if I only focus on returning the expected data from the API.

## Notes

### How to run

This project has been made as a gem. You can build the gem and install it, or
simply run under this folder:

```
$ bundle install
$ lk_cards
```

If you want to run with parallelism, take a look at the notes bellow (section
 _Parallelising the retrieval of Cards to speed up things._)

```
$ git checkout parallel
```

To get the results of each exercise, run:

- Returns a list of Cards grouped by Set.

```
$ lk_cards 0
```

- Returns a list of Cards grouped by Set and then by rarity.

```
$ lk_cards 1
```

- Returns a list of cards from the Khans of Tarkir that ONLY have the colors red and blue

```
$ lk_cards 2
```

### Persistence

As I understand from the description of the test, we shouldn't persist the
results. On each call, it will get the cards from the API.

### API Client Scalability

`ApiClient` class and `Downloader` class follow the Single Responsibility
principle. They doesn't know about cards. That means, that these two files can
be the start of a gem to retrieve data from the API.

If you copy the class `LingoKids::Card` and replace `cards` by `set`, you will
have a new class for access the `Set` items. The you can make a `Base` class
to share the methods `all`, `where`, `each`, etc, etc. It has been resolved
thinking in scalability.

## Used just ruby standard library

I only used ruby stuff!

I based my solution on what [this post](http://www.mikeperham.com/2016/02/09/kill-your-dependencies/) recommends.

## Parallelising the retrieval of Cards to speed up things.

This functionality is in the branch `parallel`. I have put it in another
branch because of two reasons:

* I did it without testing it and I didn't fix the other failing tests
* It has to **wait** some miliseconds between every thread creation
* It has to **wait** the finish of the Threads every 50 threads

I couldn't find a good explanation about these two last points. Sometimes, the
returned amount of cards is less than the expected amount (221). It seems that
with this waits it resolves the problem, but I would have to investigate why
some cards are lost and no error is happenning...

```
git checkout parallel
```

## Respecting the API's Rate Limiting facilities

Retryable module is prepared to sleep and retry a code given certain error.

Anyway, there is something not working fine on their side. I have make several
calls and I have seen the `"ratelimit-remaining"` with value `0`, but the next
calls have returned code `200` anyway, when I was expecting to receive a `403`.

However, when I send too many calls, the error `503` is returned. That's why I
have add a retry for this kind of error.

## Writing tests

All the main classes and modules have been tested except for the case of
paralellism.

## References

https://ruby-doc.org/stdlib-2.5.0/libdoc/net/http/rdoc/Net/HTTP.html
https://ruby-doc.org/stdlib-1.9.3/libdoc/erb/rdoc/ERB/Util.html
https://ruby-doc.org/core-2.2.0/Thread.html
https://ruby-doc.org/core-2.5.0/Enumerable.html

http://www.mikeperham.com/2016/02/09/kill-your-dependencies/
https://github.com/bbatsov/ruby-style-guide

