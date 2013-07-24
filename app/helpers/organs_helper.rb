module OrgansHelper
  def recursive_tree(node, html = '')
    html << ''
    if node.children.blank?
      html << li(node)
      return html.html_safe
    else
      html << li(node) # Explanation 2
      for child in node.children
        html << "<ul>#{recursive_tree(child)}</ul>"
      end
    end
    return html.html_safe
  end

  def li node
    content_tag :li do
      check_box_tag( 'new_organ_ids[]', node.id, @user.organs.include?(node) ) + content_tag( :span, node.name )
    end
  end
end
