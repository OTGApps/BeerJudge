module Formotion
  module RowType
    class StaticImageRow < Base
      include BW::KVO
      IMAGE_VIEW_TAG=1100

      def set_image
        return unless row.value
        row.value = UIImage.imageNamed(row.value) if row.value.is_a?(String)
        @image_view.image = row.value
      end

      def build_cell(cell)
        cell.selectionStyle = self.row.selection_style || UITableViewCellSelectionStyleBlue

        @image_view = UIImageView.alloc.init

        set_image

        @image_view.tag = IMAGE_VIEW_TAG
        @image_view.contentMode = UIViewContentModeScaleAspectFit
        @image_view.backgroundColor = UIColor.whiteColor
        cell.addSubview(@image_view)

        cell.swizzle(:layoutSubviews) do
          def layoutSubviews
            old_layoutSubviews

            # viewWithTag is terrible, but I think it's ok to use here...
            formotion_field = self.viewWithTag(IMAGE_VIEW_TAG)

            field_frame = formotion_field.frame
            field_frame.origin.y = 10
            field_frame.origin.x = self.textLabel.frame.origin.x + self.textLabel.frame.size.width + 20
            field_frame.size.width  = self.frame.size.width - field_frame.origin.x - 20
            field_frame.size.height = self.frame.size.height - 20
            formotion_field.frame = field_frame
          end
        end
      end
    end
  end
end
