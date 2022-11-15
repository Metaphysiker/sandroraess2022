require 'tree'                 # Load the library


class Article < ApplicationRecord
  has_one_attached :featured_image
  extend FriendlyId
  friendly_id :title, use: :slugged

  before_save :modify_content

  def add_to_tree




  end

  def modify_content

    doc = Nokogiri::HTML.fragment(self.content)
    table_of_content = ""

    root = Tree::TreeNode.new(self.title, 1)

    current_node = root
    parent_node = root
    last_node = root
    current_level = 1


    doc.css("h2, h3, h4, h5, h6").each do |node|
      node['id'] = node.content.parameterize

      level = node.name.delete("^0-9").to_i

      new_node = Tree::TreeNode.new(node.content, level)

      if parent_node.content == level

        if parent_node.parent.blank?
          root << new_node
          parent_node = root
        else
          parent_node.parent << new_node
          parent_node = parent_node.parent
        end

      elsif parent_node.content + 1 == level
        parent_node << new_node
      elsif parent_node.content + 2 == level
        parent_node = last_node
        parent_node << new_node
      elsif parent_node.content > level

        while parent_node.content + 1 != level

          if parent_node.parent.blank?
            parent_node = root
            break
          end

          parent_node = parent_node.parent

        end

        parent_node << new_node
      end

      current_level = level
      last_node = new_node

    end

    root.print_tree

    self.modified_content = tree_to_toc(root) + "<hr>" + doc.to_html

  end


  def tree_to_toc(tree)

    list = ""

    tree.children.each do |child|

      link = <<~EOF
            <a href="##{child.name.parameterize}">#{child.name}</a>
      EOF

      list = list + "<li>" +  link + "</li>"

      if child.children.present?
        list = list + tree_to_toc(child)
      end
    end


    return "<ol>" + list + "</ol>"
  end


  def modify_content_old

    root = Tree::TreeNode.new('root', self.title)

    #h2 << Tree::TreeNode.new("CHILD2", "Child2 Content")

    #h1.print_tree

    puts "treenode"
    #puts h1


    doc = Nokogiri::HTML.fragment(self.content)
    table_of_content = ""

    current_heading_level = 1
    current_node = root
    last_node = root

    doc.css("h1, h2, h3, h4, h5, h6").each do |node|
      new_node = Tree::TreeNode.new(node.content, node.content)
      node['id'] = node.name.parameterize


      heading_level = node.name.delete("^0-9").to_i
      puts heading_level
      puts current_heading_level
      puts heading_level == (current_heading_level + 1)


      if heading_level == (current_heading_level + 1)
        current_node << new_node

      elsif heading_level > (current_heading_level + 1)
        current_node = last_node

        current_node << new_node

        current_heading_level = heading_level - 1

      else

        current_node = root
        current_node << new_node
        current_heading_level = heading_level - 1
      end

      last_node = new_node



      times_of_space = node.name.delete("^0-9").to_i
      puts "node"
      #puts node.attributes
      #puts node.methods
      #puts node.name
      #puts node.children.count
      #puts node.children[0].content
      node['id'] = node.content.parameterize

      times_of_space_string = ""
      times_of_space.times do |time|
          times_of_space_string += "&nbsp;&nbsp;&nbsp;&nbsp;"
      end
link = <<~EOF
      <a href="##{node.content.parameterize}">#{node.content}</a>
      <br>
EOF

      table_of_content = table_of_content + times_of_space_string + link
    end

    #https://developer.squareup.com/blog/challenge-table-of-contents-generator/
    self.modified_content = table_of_content + "<hr>" + doc.to_html

    root.print_tree
  end

end
