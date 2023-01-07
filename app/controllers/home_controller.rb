# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    render inertia: 'Application'
  end
end
