
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name pico_uart -dir "E:/KITCODE/sp6_lpddr_v1/pico_ddr_bram_ftdififo/planAhead_run_1" -part xc6slx9tqg144-2
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "E:/KITCODE/sp6_lpddr_v1/pico_ddr_bram_ftdififo/TOP.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {E:/KITCODE/sp6_lpddr_v1/pico_ddr_bram_ftdififo} }
set_property target_constrs_file "hw_top.ucf" [current_fileset -constrset]
add_files [list {hw_top.ucf}] -fileset [get_property constrset [current_run]]
link_design
