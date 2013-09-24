# -*- coding: utf-8 -*-
class PapersController < ApplicationController
  # GET /papers
  # GET /papers.json
  def index
    @papers = Paper.find(:all, :order => 'created_at desc')
    @query = ""
    @options = "1"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @papers }
    end
  end

  # GET /papers/1
  # GET /papers/1.json
  def show
    @paper = Paper.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @paper }
    end
  end

  # GET /papers/new
  # GET /papers/new.json
  def new
    @paper = Paper.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @paper }
    end
  end

  # GET /papers/1/edit
  def edit
    @paper = Paper.find(params[:id])
  end

  # POST /papers
  # POST /papers.json
  def create
    @paper = Paper.new(params[:paper])

    respond_to do |format|
      if @paper.save
        format.html { redirect_to @paper, :notice => 'Paper was successfully created.' }
        format.json { render :json => @paper, :status => :created, :location => @paper }
      else
        format.html { render :action => "new" }
        format.json { render :json => @paper.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /papers/1
  # PUT /papers/1.json
  def update
    @paper = Paper.find(params[:id])

    respond_to do |format|
      if @paper.update_attributes(params[:paper])
        format.html { redirect_to @paper, :notice => 'Paper was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @paper.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /papers/1
  # DELETE /papers/1.json
  def destroy
    @paper = Paper.find(params[:id])
    @paper.destroy

    respond_to do |format|
      format.html { redirect_to papers_url }
      format.json { head :no_content }
    end
  end

  def search
    if params[:options]["id"] == "1"
      @papers = Paper.find(:all, :conditions => ["title like ?", "%"+params[:query]+"%"], :order => 'created_at desc')
    else
      @papers = Paper.find(:all, :conditions => ["author like ?", "%"+params[:query]+"%"], :order => 'created_at desc')
    end

    @query = params[:query]
#    @options = params[:option]["id"]
    render 'index'
  end

  def add_mylist
    @mylist = Mylist.new(params[:data])

    unless @mylist.save
        @head = "登録失敗"
        @msg = "登録が失敗しました。すでにマイリストに登録されています。"
    else
        @head = "登録完了"
        @msg = params[:data][:title] + "はマイリストに登録されました。"
    end
  end

  def mylist
    @titles = Mylist.find(:all, :select => "title", :conditions => { :account => session[:user_name]})
    titles = []
    for t in @titles do
        titles.append(t.title)
    end
    @papers = Paper.find(:all, :conditions => ["title in (?)", titles], :order => "created_at desc")
  end

  def remove_from_mylist
    @mylist = Mylist.find(:first, :conditions => { :account => params[:account], :title => params[:title]})
    @mylist.destroy
    @head = "削除完了"
    @msg = params[:title] + "をマイリストから削除しました"
    render "add_mylist"
  end

  def add_comment
    @message = ""
    @mylist = Mylist.find(:first, :conditions => { :account => params[:account], :title => params[:title]})
    @comment = Redcarpet.new(@mylist.comment).to_html.html_safe()
  end

  def post_comment
    @mylist = Mylist.find(:first, :conditions => { :account => params[:account], :title => params[:title]})
    @mylist.update_attribute(:comment, params[:comment])
    @comment = Redcarpet.new(@mylist.comment).to_html.html_safe()
    @message = "登録は正常に行われました"
    render "add_comment"
  end
end
