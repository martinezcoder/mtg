# LingoKids test

https://gist.github.com/christos/d80248f21cbb722800561bdb7b79ac59

## Notes

### How to run

This project has been made as a gem. You can build the gem and install it, or
simple run under this folder:

```
$ lk_cards
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
results. On each call, it will get the cards from the API...

### API Client Scalability

`ApiClient` class and `Downloader` class follow the Single Responsibility
principle. They doesn't know about cards. That means, that these two files can
be the start of a gem to retrieve data from the API.

If you copy the class `Mtg::Card` and replace `cards` by `set`, you will
have a new class for access the `Set` items. The you can make a `Base` class
to share the methods `all`, `where`, `each`, etc, etc. It has been resolved
thinking in scalability.

## Used just ruby standard library

I only used ruby stuff!

I based my solution on what [this post](http://www.mikeperham.com/2016/02/09/kill-your-dependencies/) recommends.

## Parallelising the retrieval of Cards to speed up things.

This functionality is in the branch `parallel`. I have put it in another
branch because I did it without fixing the tests.

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
https://ruby-doc.org/core-2.5.0/Thread.html
https://ruby-doc.org/core-2.5.0/Enumerable.html

http://www.mikeperham.com/2016/02/09/kill-your-dependencies/
https://github.com/bbatsov/ruby-style-guide

