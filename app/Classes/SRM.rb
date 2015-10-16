# Better colors for next version:
# http://www.homebrewtalk.com/f84/ebc-srm-color-rgb-78018/

class SRM

	# Colors extracted from http://methodbrewery.com/srm.php
	@@matrix = {
		"1"   => [250, 250, 160],
		"2"   => [250, 250, 105],
		"3"   => [245, 246, 50],
		"4"   => [235, 228, 47],
		"5"   => [225, 208, 50],
		"6"   => [215, 188, 52],
		"7"   => [205, 168, 55],
		"8"   => [198, 148, 56],
		"9"   => [193, 136, 56],
		"10"   => [192, 129, 56],
		"11"   => [192, 121, 56],
		"12"   => [192, 114, 56],
		"13"   => [190, 106, 56],
		"14"   => [180, 99, 56],
		"15"   => [167, 91, 54],
		"16"   => [152, 84, 51],
		"17"   => [138, 75, 48],
		"18"   => [124, 68, 41],
		"19"   => [109, 60, 34],
		"20"   => [95, 53, 23],
		"21"   => [81, 45, 11],
		"22"   => [67, 38, 12],
		"23"   => [52, 30, 17],
		"24"   => [38, 23, 22],
		"25"   => [33, 19, 18],
		"26"   => [28, 16, 15],
		"27"   => [23, 13, 12],
		"28"   => [18, 9, 8],
		"29"   => [13, 6, 5],
		"30"   => [8, 3, 2]
	}

	def self.color(value)
		srm_color = @@matrix[value.to_s]
		return false unless srm_color

		BubbleWrap.rgb_color(srm_color[0], srm_color[1], srm_color[2])
	end

	def self.cgcolor(value)
		c = SRM.color(value)
		c.CGColor
	end

	def self.imageWithSRM(value, andSize:size)
		# size expects a CGSize
    color = SRM.color(value)

    size = CGSizeMake(size, size) if size.is_a?(Integer)

    rect = CGRectMake(0.0, 0.0, size.width, size.height)
    UIGraphicsBeginImageContext(rect.size)
    context = UIGraphicsGetCurrentContext()

    CGContextSetFillColorWithColor(context, color.CGColor)
    CGContextFillRect(context, rect)

    image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    image
	end

	def self.steps
		@@matrix
	end

	def self.spectrum
		colors = []
		@@matrix.each do |key, value|
			colors << BubbleWrap.rgb_color(value[0], value[1], value[2].to_f).CGColor
		end
		colors
	end

	def self.closest_srm_to_color(compare_color)
		colors = compare_color.arrayFromRGBAComponents
		colors_rgba ||= []
		colors.each_with_index do |component,i|
			colors_rgba[i] = (component * 255).to_i
		end

		# Loop through all the SRM colors and give it a closeness score
		color_match = {}
		@@matrix.each do |key, value|
			r_distance = value[0] - colors_rgba[0]
			g_distance = value[1] - colors_rgba[1]
			b_distance = value[2] - colors_rgba[2]

			color_match[key] = (r_distance.abs + g_distance.abs + b_distance.abs)
		end

		# Return the closest SRM color match and the calculated distance
		color_match.sort_by{|srm, closeness| closeness}.first

	end

end
