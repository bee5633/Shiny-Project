# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class PortwineItem(scrapy.Item):
    wine_name = scrapy.Field()
    wine_price = scrapy.Field()
    wine_country = scrapy.Field()
    wine_region = scrapy.Field()
    wine_point = scrapy.Field()
    wine_alcohol = scrapy.Field()
    wine_category = scrapy.Field()
    wine_variety = scrapy.Field()
    wine_description = scrapy.Field()