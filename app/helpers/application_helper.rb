module ApplicationHelper
  def identicon_for(
    user: '',
    identicon_grid_size: 6,
    identicon_square_size: 15,
    identicon_width: 32,
    identicon_height: 32
  )
    base64_identicon = RubyIdenticon.create_base64(
      (user.instance_of?(User) ? user.email : 'default'),
      background_color: 168_041,
      grid_size: identicon_grid_size,
      square_size: identicon_square_size
    )
    image_tag(
      "data:image/png;base64,#{base64_identicon}",
      alt: (user.instance_of?(User) ? user.email : 'default'),
      width: identicon_width,
      height: identicon_height,
      class: 'rounded-full'
    )
  end
end
