require 'lingo_kids'

# This class is scalable to be used for any other item
#
class LingoKids::Downloader

  def initialize(item_name)
    @item_name = item_name # will be always "cards"
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

  private

  def each_group
    groups do |group|
      items = group[:body][@item_name]
      items.each do |item|
        yield item
      end
    end
  end

  def groups
    @all = []
    @first_page = client.get
    num_page = 1
    total_pages = last_page

    # TODO: use Thread to download all the pages
    while num_page <= total_pages do
      if num_page == 1
        page = @first_page
      else
        puts rss
        page = client.get(page: num_page)
      end

      yield page if block_given?

      num_page += 1
    end
  end

  def rss
    # RAM used by the Ruby process
    ["RSS", `ps -eo pid,rss | grep #{Process.pid} | awk '{print $2}'`.to_i].join(": ")
  end

  def last_page
    # NOTE: I could just increment a page param one by one, but given that the
    # header provides this value, I have considered better to use it. I cannot
    # assume that all the pages will include a list of present cards (maybe
    # there is a page in the middle where cards=[]
    # TODO: create a class for next two lines
    @last_page ||=
      begin
        return 0 unless @first_page
        link_last = @first_page[:headers]["link"].first.split(',').select { |link| link[/\; rel=\"last\"$/] }.first
        link_last.split(';').first.gsub(/(<|>)/, '').split("page=").last.to_i
      end
  end

  def client
    LingoKids::ApiClient.new
  end
end
