# 원본 폴더 경로
set source_folder [file normalize "./"] ;# 현재 디렉토리에서 시작

# 대상 폴더 경로
set report_folder [file normalize "../../../reports"]
set output_folder [file normalize "../../../output"]

# 대상 폴더가 없다면 생성
if {![file exists $report_folder]} {
    file mkdir $report_folder
}

if {![file exists $output_folder]} {
    file mkdir $output_folder
}

# .extension 파일을 검색하여 복사
proc copyRptFiles {source destination extension} {
    foreach item [glob -nocomplain -directory $source -types f *.$extension] {
        set item_name [file tail $item]
        set dest_path [file join $destination $item_name]
        
    	file copy -force $item $dest_path
        puts "File '$item_name' copied to $destination."
    }
}

# 현재 디렉토리에서부터 시작하여 하위 폴더에서 .rpt 파일을 검색하고 복사
copyRptFiles $source_folder $report_folder "rpt"
copyRptFiles $source_folder $output_folder "bit"
copyRptFiles $source_folder $output_folder "bin"
copyRptFiles $source_folder $output_folder "ltx"


puts "Copy process completed."

# flash gen
write_cfgmem  -format mcs -size 16 -interface SPIx4 -loadbit {up 0x00000000 "../../../output/cyan_top.bit" } -force -file "../../../output/cyan_top"

