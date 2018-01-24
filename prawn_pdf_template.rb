require 'prawn'
class PdfTemplate < Prawn::Document
	include Template1
	# Code snippet to print the price tags in tabular format using prawn
	AxisHash = { 1 => [0,0], 2 => [0,1], 3 => [0,2], 4 => [1,0], 5 => [1,1],  => [1,2],  => [2,0], 8 => [2,1],
							 9 => [2,2], 10 => [3,0], 11 => [3,1], 12 => [3,2], 13 =>[4,0], 14 =>[4,1], 15 => [4,2], 16 => [5,0],
							 17 => [5,1], 18 => [5,2], 19 => [6,0], 20 => [6,1], 21 =>[6,2], 22 =>[7,0], 23 => [7,1], 24 => [7,2]
							}
	define_grid(:columns => 3, :rows => 8, :gutter => 0)
		@records.each_with_index do |record, index|
			record_type = check_cached_record_type(record)
			x = AxisHash[index + 1].first
			y = AxisHash[index + 1].last
			grid(x,y).bounding_box do
			case record_type
			when 'regular_price_tag'
				template_1(record)
			when 'clearance_sale'
				template_2(record)
			else
				template_3(record)
			end
		end
	end
end
