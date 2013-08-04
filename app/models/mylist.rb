# -*- coding: utf-8 -*-
class Mylist < ActiveRecord::Base
  attr_accessible :account, :title

  validates_uniqueness_of :title, :scope => :account,
    :message => "すでにマイリストに登録されています"
end
