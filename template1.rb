module Template1
	def regular_retek_description(description)
		text_box description,
			height: 25,
			width: 171,
			at: [4, 90],
			size: 21,
			align: :center,
			style: :bold,
			valign: :center,
			overflow: :shrink_to_fit,
			kerning: true
	end

	def regular_manufacturer(manufacturer)
		text_box manufacturer,
			height: 8,
			width: 70,
			at: [6, 50],
			size: 12,
			style: :normal,
			align: :left,
			overflow: :shrink_to_fit,
			kerning: true
	end

	def regular_pog_item(text)
		text = text.blank? ? ' ' : text
		text_box text,
			height: 8,
			width: 55,
			at: [6, 58],
			size: 12,
			style: :normal,
			align: :left,
			overflow: :shrink_to_fit,
			kerning: true
	end

	def regular_retek(string)
		text_box string,
			height: 8,
			width: 36,
			at: [6, 42],
			size: 12,
			style: :normal,
			align: :left,
			overflow: :shrink_to_fit,
			kerning: true
	end

	def regular_string(string)
		string2 = ''
		if string.present?
			string2 = 'e' + string.rjust(6, "0")
		end
		text_box string2,
			height: 10,
			width: 95,
			at: [6, 43],
			size: 14,
			style: :normal,
			align: :right,
			overflow: :shrink_to_fit,
			kerning: true
	end

	def regular_ims_prod_group(ims_prod_group)
		text_box ims_prod_group,
			height: 10,
			width: 90,
			at: [6, 35],
			size: 14,
			style: :normal,
			align: :right,
			overflow: :shrink_to_fit,
			kerning: true
	end

	def regular_prod_group_box(status, mark_down_condition)
		if status.present?
			bounding_box([97, 34], width: 6, height: 7, style: :normal) do
				stroke do
		      line_width 0.1
		      fill_color regular_status_color(status)
		      fill_and_stroke_rectangle [cursor-bounds.height,cursor], bounds.width, bounds.height
		      stroke_color '000000'
		    end
				stroke_bounds
				text_rendering_mode(:fill_stroke) do
	        stroke_color "000000"
	        fill_color "000000"
	      end
	      if ((status == 'OI') || (status == 'I') && (mark_down_condition))
					draw_text('D', at: [1, 1], kerning: true, size: 7)
				end
	    end
		end
	end

	def regular_status_color(status)
		if (status == 'X') || (status == 'MR')
			'0099CC'
		else
			'FFFFFF'
		end
	end

	def regular_upc(upc_string)
		text_box upc_string,
			height: 8,
			width: 50,
			at: [6, 34],
			size: 14,
			style: :normal,
			align: :left,
			overflow: :shrink_to_fit,
			kerning: true
	end

	def regular_barcode_box(barcode_string)
		bounding_box([8, 25], :width => 72, :height => 15) do
			upc_barcode = barcode_string.to_i == 0 ? ' ' : barcode_string
      if (upc_barcode.size == 13)
		  	barcode = Barby::EAN13.new upc_barcode.first(12)
		  elsif (upc_barcode.size == 12)
		  	barcode = Barby::UPCA.new upc_barcode.first(11)
		  elsif (upc_barcode.size == 8)
	  		barcode = Barby::Code128.new upc_barcode#.first(7)
		  end
      barcode.annotate_pdf(self, :height => 15 ) if barcode
		end
	end

	def regular_retail_price_tag(retail_price)
		string2 = ''
		if retail_price.present?
			string2 = '<sup>$</sup>' + retail_price
		end
		text_box string2,
			width: 88,
			height: 28,
			at: [85, 55],
			size: 46,
			style: :bold,
			inline_format: true,
			align: :right,
			overflow: :shrink_to_fit,
			kerning: true
	end

	def regular_unit_retail_price(unit_retail_price, price_unit)
		string2 = ''
		if unit_retail_price.present?
			string2 = number_to_currency(unit_retail_price, precision: 3) + " per " + price_unit.to_s.downcase
		end
		text_box string2,
			width: 72,
			height: 9,
			at: [100, 30],
			size: 26,
			style: :bold,
			align:  :right,
			overflow: :shrink_to_fit,
			kerning: true
	end
end
