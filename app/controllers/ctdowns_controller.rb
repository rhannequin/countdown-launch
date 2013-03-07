# encoding: UTF-8

class CtdownsController < ApplicationController
  protect_from_forgery

  def show
    @ctdown = Ctdown.where(:slug => params[:slug]).first
    @share_url = url_for root_url + @ctdown.slug
    @remaining = ((@ctdown.goal.to_datetime - DateTime.now) * 1.day).to_i
    raise ActionController::RoutingError.new('Not Found') unless @ctdown
  end

  def new
    @ctdown = Ctdown.new
  end

  def create
    # Get year/month/day params
    goal = params[:goal]
    # Create full hash of params
    date = params[:date].merge({  :year  => goal['date(1i)'],
                                  :month => goal['date(2i)'],
                                  :day   => goal['date(3i)']})
    # Create datetime and check if correct
    datetime = DateTime.new(date[:year].to_i, date[:month].to_i, date[:day].to_i, date[:hour].to_i, date[:minute].to_i, date[:second].to_i, date[:timezone]) rescue ArgumentError
    # Create slug if not set
    params[:ctdown][:slug] = slugify(params[:ctdown][:title]) if params[:ctdown][:slug].empty?
    # Create Ctdown instance
    @ctdown = Ctdown.new params[:ctdown]
    # Add datetime to model if correct
    @ctdown.goal = datetime unless datetime == ArgumentError
    # Be sure to have a `slugable`
    @ctdown.slug = slugify @ctdown.slug unless @ctdown.slug.nil?
    if @ctdown.save
      redirect_to ctdown_path(@ctdown.slug), notice: 'Countdown was successfully created.'
    else
      render action: 'new'
    end
  end

  private
    # Slugify: thanks to stackoverflow http://stackoverflow.com/users/480943/ben-lee
    def slugify(str)
      return remove_accents(str).downcase
                                .strip
                                .gsub(' ', '-')
                                .gsub(/[^\w-]/, '')
    end

    # Remove accents : thanks to techniconseils http://www.techniconseils.ca
    def remove_accents(str)
      accents_mapping = {
        'E'  => [200,201,202,203],
        'e'  => [232,233,234,235],
        'A'  => [192,193,194,195,196,197],
        'a'  => [224,225,226,227,228,229,230],
        'C'  => [199],
        'c'  => [231],
        'O'  => [210,211,212,213,214,216],
        'o'  => [242,243,244,245,246,248],
        'I'  => [204,205,206,207],
        'i'  => [236,237,238,239],
        'U'  => [217,218,219,220],
        'u'  => [249,250,251,252],
        'N'  => [209],
        'n'  => [241],
        'Y'  => [221],
        'y'  => [253,255],
        'AE' => [306],
        'ae' => [346],
        'OE' => [188],
        'oe' => [189]
      }
      accents_mapping.each { |letter, accents|
        packed = accents.pack('U*')
        rxp = Regexp.new("[#{packed}]", nil, 'U')
        str.gsub!(rxp, letter)
      }
      str
    end
end