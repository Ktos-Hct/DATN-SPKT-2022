function Header = genMBHeader(mbType,qScale)

Header.MBHeader.macroblock_type = uint8(mbType) ;
Header.MBHeader.quantizer_scale = uint8(qScale) ;
end