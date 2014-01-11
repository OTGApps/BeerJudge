module Formotion
  module RowType
    class DisabledTextRow < TextRow

      def after_build(cell)
        @field.editable = false
      end

    end
  end
end
