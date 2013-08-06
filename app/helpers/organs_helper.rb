# -*- coding: utf-8 -*-
module OrgansHelper
  def recursive_tree(node, memberships, html = '')
    html << ''
    if node.children.blank?
      html << li(node, memberships)
      return html.html_safe
    else
      html << li(node, memberships) # Explanation 2
      for child in node.children
        html << "<ul>#{recursive_tree(child, memberships)}</ul>"
      end
    end
    return html.html_safe
  end

  def li node, memberships
    content_tag :li do
      #  @user.organs.include?(node)
      content_tag( :span, node.name ) + membership_box(node, memberships).html_safe
    end
  end

  def membership_box node, memberships
    '——' + memberships.map { |e|
      check_box_tag( "memberships[organ_#{node.id}][]", e.id,
       !@user.actors.where(organ_id: node.id, membership_id: e.id).blank? ) + content_tag( :span, e.name )
    }.join('')
  end
end
