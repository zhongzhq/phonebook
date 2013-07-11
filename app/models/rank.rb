# -*- coding: utf-8 -*-
class Rank < ActiveRecord::Base
  attr_accessible :name, :parent_id

  validates :name, presence: true, uniqueness: true

  has_many :organs

  has_ancestry

  def self.get_childs parent_id
    result = []
    rank = Rank.where(:parent_id =>parent_id).first
    if rank && rank.child
      result << rank
      result =result +  get_childs(rank.id)
    else
      result << rank
    end
    return result
  end
end
