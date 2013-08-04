# -*- coding: utf-8 -*-
class RegisterController < ApplicationController

  def new
    @user = User.new
  end

  def done
    @user = User.new(params[:user])
    unless @user.save
      render :action => 'new'
    end
  end
end
