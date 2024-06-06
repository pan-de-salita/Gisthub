module ApplicationHelper
  def identicon_for(
    user: '',
    identicon_grid_size: 6,
    identicon_square_size: 15,
    identicon_width: 32,
    identicon_height: 32
  )
    base64_identicon = RubyIdenticon.create_base64(
      (user.empty? ? 'default' : user.email),
      background_color: 2_022_162_301,
      grid_size: identicon_grid_size,
      square_size: identicon_square_size
    )
    image_tag(
      "data:image/png;base64,#{base64_identicon}",
      alt: (user.empty? ? 'default identicon' : user.name),
      width: identicon_width,
      height: identicon_height,
      class: 'rounded-full'
    )
  end
end
