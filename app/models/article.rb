require 'tree'                 # Load the library


class Article < ApplicationRecord
  has_one_attached :featured_image
  extend FriendlyId
  friendly_id :title, use: :slugged

  before_save :modify_content


  def modify_content

    h1 = Tree::TreeNode.new('h1', self.title)

    h1 << Tree::TreeNode.new("CHILD2", "Child2 Content")

    h1.print_tree

    puts "treenode"
    puts h1


    doc = Nokogiri::HTML.fragment(self.content)
    table_of_content = ""

    doc.css('h1', 'h2', 'h3', 'h4', 'h5', 'h6').each do |node|
      node['id'] = node.content.parameterize
link = <<~EOF
      <a href="##{node.content.parameterize}">#{node.content}</a>
      <br>
EOF

      table_of_content = table_of_content + link
    end

    #https://developer.squareup.com/blog/challenge-table-of-contents-generator/
    self.modified_content = table_of_content + doc.to_html
  end

end
