function Headers = genSeqHeader()

%As a part of ISO/IEC 13818-2 specification and also
%according to pages 27-29 of the given mpg-video.pdf file,we have
Headers.SeqHeader.sequence_header_code = hex2bin32bits('000001B3') ;
Headers.SeqHeader.horizontal_size = uint16(352);
Headers.SeqHeader.vertical_size =  uint16(288);
Headers.SecEnd.sequence_end_code = hex2bin32bits('000001B7') ;
end