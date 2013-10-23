# -*- coding: utf-8 -*-
class PublicsController < ApplicationController
  def index
    @users = Recent.users(current_user)
  end

  def login
    @user = User.new
  end

  def authenticate
    @user = User.login(params[:user])
    if @user.present?
      if params[:remember] == "true"
        cookies[:remember] = {:value => @user.generate_authentication_token, :expires => Time.now + 60 }
      end

      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to root_path, :alert => '账号或密码错误'
    end
  end

  def logout
    current_user.update_attribute(:authentication_token, nil)
    session.clear
    redirect_to root_path, :notice => '退出成功'
  end
  
  def search
    @value = params[:value]

    param_one, param_two, param_three, param_four = params[:value].split(" ").map do |x|
      x.downcase.split('').join("%").insert(0, "%").insert(-1, "%")
    end

    if @value.split.size == 1
      # 直接在用户表中查找用户
      @users = User.where{ (name.like param_one) | (pinyin.like param_one) }

      # 先查找职务或地址，然后再查找用户
      m1 = Member.joins(:jobs).where{
        (jobs.name.like param_one) | (jobs.pinyin.like param_one)
      }
      m2 = Member.joins(:addresses).where{
        (addresses.name.like param_one) | (addresses.pinyin.like param_one)
      }
      @users += User.joins(:members).where{ members.id.in m1 + m2 }

    elsif @value.split.size == 2
      # 组织 职务 或 组织 地址 或 组织 名称
      o = Organ.where{ (name.like param_one) | (pinyin.like param_one) }.map(&:subtree).flatten
      m = Member.joins(:organ).where{organ_id.in o}

      m1 = m.joins(:user).where{
        (user.name.like param_two) | (user.pinyin.like param_two)
      }
      m2 = m.joins(:jobs).where{
        (jobs.name.like param_two) | (jobs.pinyin.like param_two)
      }
      m3 = m.joins(:addresses).where{
        (addresses.name.like param_two) | (addresses.pinyin.like param_two)
      }
      @users = User.joins(:members).where{ members.id.in m1 + m2 + m3 }

      # 职务 名称 或 地址 名称
      m1 = Member.joins(:jobs).where{
        (jobs.name.like param_one) | (jobs.pinyin.like param_one)
      }
      m2 = Member.joins(:addresses).where{
        (addresses.name.like param_one) | (addresses.pinyin.like param_one)
      }
      @users += User.joins(:members).where{ members.id.in m1 + m2 }.where{
        (name.like param_two) | (pinyin.like param_two)
      }

      # 地址 职务 或 职务 地址
      m1 = Member.joins(:jobs).where{
        (jobs.name.like param_one) | (jobs.pinyin.like param_one)
        }.joins(:addresses).where{
          (addresses.name.like param_two) | (addresses.pinyin.like param_two)
        }
      m2 = Member.joins(:addresses).where{
        (addresses.name.like param_one) | (addresses.pinyin.like param_one)
        }.joins(:jobs).where{
          (jobs.name.like param_two) | (jobs.pinyin.like param_two)
        }
      @users += User.joins(:members).where{ members.id.in m1 + m2 }

    elsif @value.split.size == 3
      # 组织 职务 名称 或 组织 地址 名称
      o = Organ.where{ (name.like param_one) | (pinyin.like param_one) }.map(&:subtree).flatten
      m = Member.joins(:organ).where{organ_id.in o}

      m1 = m.joins(:jobs).where{
        (jobs.name.like param_two) | (jobs.pinyin.like param_two)
      }
      m2 = m.joins(:addresses).where{
        (addresses.name.like param_two) | (addresses.pinyin.like param_two)
      }
      @users = User.joins(:members).where{ members.id.in m1 + m2 }.where{
        (name.like param_three) | (pinyin.like param_three)
      }

      # 组织 职务 地址 或 组织 地址 职务
      m1 = m.joins(:jobs).where{
        (jobs.name.like param_two) | (jobs.pinyin.like param_two)
        }.joins(:addresses).where{
          (addresses.name.like param_three) | (addresses.pinyin.like param_three)
        }
      m2 = m.joins(:addresses).where{
        (addresses.name.like param_two) | (addresses.pinyin.like param_two)
        }.joins(:jobs).where{
          (jobs.name.like param_three) | (jobs.pinyin.like param_three)
        }
      @users += User.joins(:members).where{ members.id.in m1 + m2 }

      # 职务 地址 名称 或 地址 职务 名称
      m1 = Member.joins(:jobs).where{
        (jobs.name.like param_one) | (jobs.pinyin.like param_one)
        }.joins(:addresses).where{
          (addresses.name.like param_two) | (addresses.pinyin.like param_two)
        }
      m2 = Member.joins(:addresses).where{
        (addresses.name.like param_one) | (addresses.pinyin.like param_one)
        }.joins(:jobs).where{
          (jobs.name.like param_two) | (jobs.pinyin.like param_two)
        }
      @users += User.joins(:members).where{ members.id.in m1 + m2 }.where{
        (name.like param_three) | (pinyin.like param_three)
      }
    elsif @value.split.size == 4
      # 组织 职务 地址 名称 或 组织 地址 职务 名称
      o = Organ.where{ (name.like param_one) | (pinyin.like param_one) }.map(&:subtree).flatten
      m = Member.joins(:organ).where{organ_id.in o}

      m1 = m.joins(:jobs).where{
        (jobs.name.like param_two) | (jobs.pinyin.like param_two)
        }.joins(:addresses).where{
          (addresses.name.like param_three) | (addresses.pinyin.like param_three)
        }
      m2 = m.joins(:addresses).where{
        (addresses.name.like param_two) | (addresses.pinyin.like param_two)
        }.joins(:jobs).where{
          (jobs.name.like param_three) | (jobs.pinyin.like param_three)
        }
      @users = User.joins(:members).where{ members.id.in m1 + m2 }.where{
        (name.like param_four) | (pinyin.like param_four)
      }
    end

    @users = @users.uniq
  end
end
