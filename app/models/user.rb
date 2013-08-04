# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :account, :password_digest, :password, :password_confirmation

  validates_presence_of :account, :password,
    :message => 'が記入されていません'
  validates_uniqueness_of :account,
    :message => 'がすでに他のユーザに利用されています'
  validates_length_of :account,
    :maximum => 15,
    :message => 'は15文字以下で記入してください'
  validates_confirmation_of :password,
    :message => 'が確認用パスワードと一致しません'
  validates_length_of :password,
    :minimum => 4,
    :message => 'は4文字以上12文字以下で記入してください'
  validates_length_of :password,
    :maximum => 12,
    :message => 'は4文字以上12文字以下で記入してください'

  REAL_ATTRIBUTE_NAMES = {
    :account => 'ユーザー名',
    :password => 'パスワード',
    :password_confirmation => '確認用パスワード'
  }

  def self.real_attribute_name(key)
    REAL_ATTRIBUTE_NAMES[key.to_sym]
  end

end
