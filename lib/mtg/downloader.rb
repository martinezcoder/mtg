require 'mtg'
require 'thwait'

# This class is scalable to be used for any other item
#
class Mtg::Downloader

  attr_reader :item_name

  def initialize(item_name)
    @item_name = item_name # in this test will be always "cards"
  end

  def all
    items = []
    each do |item|
      items << item
    end
    items
  end

  def each
    each_group do |item|
      yield item
    end
  end

  def where(params)
    items = []
    each_group(params) do |item|
      items << item
    end
    items
  end

  private

  def each_group(params={})
    groups(params) do |group|
      items = group[:body][@item_name]
      items.each do |item|
        yield item
      end
    end
  end

  def groups(params={})
    @first_page = client.get(item_name, params)
    total_pages = last_page

    puts params.merge(memory_usage: rss).merge(date: Time.now)

    Thread.abort_on_exception = true
    threads = [ Thread.new { @first_page } ]
    threads += (2..total_pages).map do |num_page|
      sleep 0.05
      Thread.new { client.get(item_name, params.merge({page: num_page})) }
    end

    puts "\nWaiting threads..."
    num_page = 1
    ThreadsWait.all_waits(*threads) do
      $stdout.flush; print "\r#{num_page}/#{total_pages}"
      num_page += 1
    end

    threads.each do |thread|
      yield thread.value
    end

    puts params.merge(memory_usage: rss).merge(date: Time.now)
  end

  def client
    Mtg::ApiClient.new
  end

  # NOTE: I could just increment a page param one by one, but given that the
  # header provides this value, I have considered better to use it.
  # I can assume that all the pages will include a list of present cards but
  # I prefer to be defensive and ensure that we loop until the last page
  class LastPageFinder
    attr_reader :link

    def initialize(link)
      @link = link.first
    end

    # Given a header containing a key-value like next:
    # { "link" => ["<http://test?page=5>; rel=\"last\", "<http://test?page=2>; rel=\"next\""] }
    # returns the number of the last page (in this case, it would return 5)
    def last_page_number
      return 1 if link == ""
      last_link_string.match(/\?page=(\d+)/)[1].to_i
    end

    private

    def last_link_string
      link.split(",").detect{ |l| l[/\; rel=\"last\"$/] }
    end
  end

  def last_page
    return 0 unless @first_page
    @last_page ||= LastPageFinder.new(@first_page[:headers]["link"]).last_page_number
  end

  def rss
    # RAM used by the Ruby process
    ["RSS", `ps -eo pid,rss | grep #{Process.pid} | awk '{print $2}'`.to_i].join(": ")
  end
end
