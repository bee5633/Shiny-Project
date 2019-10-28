from scrapy import Spider, Request
from wine.items import WineItem
import re

class WineSpider(Spider):
    name = 'wine_spider'
    #allowed_urls = ['']
    start_urls=['https://www.winemag.com/?s=&price=1-1000&drink_type=wine&page=1&search_type=reviews'] 
        
    def parse(self, response):
        result_urls = ['https://www.winemag.com/?s=&price=1-1000&drink_type=wine&page={}&search_type=reviews'.format(x) for x in range(1,2500)]

        for url in result_urls:
            yield Request(url=url, callback=self.parse_each_page)
        
    def parse_each_page(self, response):
        each_wine_urls = response.xpath('//li[@class="review-item "]/a[@class="review-listing row"]/@href').extract()

        for url in each_wine_urls:
            yield Request(url=url, callback=self.parse_detail_page)

    def parse_detail_page(self, response):

        item = WineItem()
        item['wine_name'] = response.xpath('//div[@class="article-title"]/h1/text()').extract()
        item['wine_price'] = response.xpath('//li[@class="row"]//div[@class="info medium-9 columns"]//span/text()').re(r"\d+")[0]
        item['wine_origin'] = response.xpath('//div[@class="info medium-9 columns"]/span/a/text()').extract()[-1]
        item['wine_point'] = response.xpath('//div[@class="article-title"]/h1/span[@class="rating"]/text()').extract() 
        item['wine_alcohol'] = response.xpath('//div[@class="info small-9 columns"]/span/span/text()').extract_first() 
        item['wine_category'] = response.xpath('//div[@class="info small-9 columns"]/span/span/text()').extract()[2]
        item['wine_variety'] = response.xpath('//div[@class="info medium-9 columns"]/span/a/text()').extract()[0]
        item['wine_description'] = response.xpath('//div[@class="large-10 columns"]/p/text()').extract()
        yield item
        

