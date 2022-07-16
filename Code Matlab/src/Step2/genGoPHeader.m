function Header = genGoPHeader()

%As a part of ISO/IEC 13818-2 specification and also
%according to page 30 of the given mpg-video.pdf file,we have
Header.GoPHeader.group_start_code = hex2bin32bits('000001B8') ;

end