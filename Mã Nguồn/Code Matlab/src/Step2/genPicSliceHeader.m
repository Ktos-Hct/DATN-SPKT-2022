function Header = genPicSliceHeader(temp_ref,pic_type,qScale)

%As a part of ISO/IEC 13818-2 specification and also
%according to pages 31-32 of the given mpg-video.pdf file,we have
Header.PicSliceHeader.picture_start_code = hex2bin32bits('00000100');
Header.PicSliceHeader.temporal_reference = uint16(temp_ref);
Header.PicSliceHeader.picture_coding_type = uint8(pic_type);
%slice_start_code from 00000101 to 000001AF,slice_vertical_position is given by the last eight bits
Header.PicSliceHeader.slice_start_code = hex2bin32bits('00000101') ;
Header.PicSliceHeader.quantizer_scale =  uint8(qScale);

end
%{
-picture_start_code 32 bslbf
-temporal_reference 10 uimsbf :For the earliest picture (in display order) in each group of
pictures, the temporal_reference is reset to zero.
The temporal_reference is assigned (in sequence) to the pictures in display order, 
no temporal_reference shall be ommited from the sequence.
-picture_coding_type 3 uimsbf (1, 2, 3 για I, P, B frames αντίστοιχα)
-slice_start_code 32 bslbf
-quantizer_scale 5 uimsbf
%}