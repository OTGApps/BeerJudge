class UIImage

	# Crops from the top right of the image for some reason.
	# CGPoint{0, 0} is top right.
	def crop(rect)
    if self.scale > 1.0
			rect = CGRectMake(
				rect.origin.x * self.scale,
				rect.origin.y * self.scale,
				rect.size.width * self.scale,
				rect.size.height * self.scale
			)
    end
		imageRef = CGImageCreateWithImageInRect(self.CGImage, rect)
		UIImage.imageWithCGImage(imageRef, scale:self.scale, orientation:self.imageOrientation)
  end

	def image_resized(size)
    UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
    context = UIGraphicsGetCurrentContext()

		CGContextSetShouldAntialias(context, true)
		CGContextSetAllowsAntialiasing(context, true)

		CGContextSetInterpolationQuality(context, KCGInterpolationLow)

    self.drawInRect(CGRectMake(0, 0, size.width, size.height))
    resizedImage = UIGraphicsGetImageFromCurrentImageContext()

    UIGraphicsEndImageContext()

    resizedImage
  end

end
