! CMD Version:2
! Version 2 enables expanded acceptable characters for object names.
! If unspecified, set to 1 or set to an invalid value, Adams View assumes traditional naming requirements.
!
!-------------------------- Default Units for Model ---------------------------!
!
!
defaults units  &
   length = mm  &
   angle = deg  &
   force = newton  &
   mass = kg  &
   time = sec
!
defaults units  &
   coordinate_system_type = cartesian  &
   orientation_type = body313
!
!------------------------ Default Attributes for Model ------------------------!
!
!
defaults attributes  &
   inheritance = bottom_up  &
   icon_visibility = on  &
   grid_visibility = off  &
   size_of_icons = 50.0  &
   spacing_for_grid = 1000.0
!
!--------------------------- Plugins used by Model ----------------------------!
!
!
plugin load  &
   plugin_name = .MDI.plugins.controls
!
!------------------------------ Adams View Model ------------------------------!
!
!
model create  &
   model_name = quarter_car
!
view erase
!
!-------------------------------- Data storage --------------------------------!
!
!
data_element create variable  &
   variable_name = .quarter_car.var_sprung_acc  &
   adams_id = 32  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .quarter_car.var_sprung_vel  &
   adams_id = 69  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .quarter_car.var_actuator  &
   adams_id = 37  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .quarter_car.var_tire_disp  &
   adams_id = 134  &
   function = ""
!
data_element create variable  &
   variable_name = .quarter_car.var_susp_stroke  &
   adams_id = 135  &
   function = ""
!
data_element create variable  &
   variable_name = .quarter_car.var_tire_force  &
   adams_id = 136  &
   function = ""
!
data_element create variable  &
   variable_name = .quarter_car.var_susp_vel  &
   adams_id = 137  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .quarter_car.var_unsprung_vel  &
   adams_id = 138  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .quarter_car.var_road_disp  &
   adams_id = 170  &
   function = ""
!
data_element create plant input  &
   plant_input_name = .quarter_car.PINPUT  &
   adams_id = 1  &
   variable_name =  &
      .quarter_car.var_actuator,  &
      .quarter_car.var_road_disp
!
data_element create plant output  &
   plant_output_name = .quarter_car.POUTPUT  &
   adams_id = 1  &
   variable_name =  &
      .quarter_car.var_sprung_acc,  &
      .quarter_car.var_sprung_vel,  &
      .quarter_car.var_susp_stroke,  &
      .quarter_car.var_susp_vel,  &
      .quarter_car.var_tire_disp,  &
      .quarter_car.var_unsprung_vel
!
!--------------------------------- Materials ----------------------------------!
!
!
material create  &
   material_name = .quarter_car.steel  &
   adams_id = 1  &
   density = 7.801E-06  &
   youngs_modulus = 2.07E+05  &
   poissons_ratio = 0.29
!
!-------------------------------- Rigid Parts ---------------------------------!
!
! Create parts and their dependent markers and graphics
!
!----------------------------------- ground -----------------------------------!
!
!
! ****** Ground Part ******
!
defaults model  &
   part_name = ground
!
defaults coordinate_system  &
   default_coordinate_system = .quarter_car.ground
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .quarter_car.ground.MARKER_3  &
   adams_id = 3  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .quarter_car.ground.MARKER_24  &
   adams_id = 24  &
   location = 0.0, 0.0, 626.0  &
   orientation = 0.0d, 180.0d, 0.0d
!
part create rigid_body mass_properties  &
   part_name = .quarter_car.ground  &
   material_type = .quarter_car.steel
!
part attributes  &
   part_name = .quarter_car.ground  &
   name_visibility = off
!
!---------------------------------- bod_road ----------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .quarter_car.ground
!
part create rigid_body name_and_position  &
   part_name = .quarter_car.bod_road  &
   adams_id = 2  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .quarter_car.bod_road
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .quarter_car.bod_road.MARKER_1  &
   adams_id = 1  &
   location = 0.0, 0.0, 0.0  &
   orientation = 180.0d, 90.0d, 180.0d
!
marker create  &
   marker_name = .quarter_car.bod_road.cm  &
   adams_id = 7  &
   location = 25.0, 50.0, -25.0  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker create  &
   marker_name = .quarter_car.bod_road.road_ref_1  &
   adams_id = 8  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker attributes  &
   marker_name = .quarter_car.bod_road.road_ref_1  &
   visibility = off
!
marker create  &
   marker_name = .quarter_car.bod_road.MARKER_2  &
   adams_id = 2  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
! ****** Floating Markers for current part ******
!
floating_marker create  &
   floating_marker_name = .quarter_car.bod_road.titr_tire_jf_1  &
   adams_id = 9
!
part create rigid_body mass_properties  &
   part_name = .quarter_car.bod_road  &
   mass = 1.0E-03  &
   center_of_mass_marker = .quarter_car.bod_road.cm  &
   ixx = 2031.5104166667  &
   iyy = 2031.5104166667  &
   izz = 812.6041666667  &
   ixy = 0.0  &
   izx = 0.0  &
   iyz = 0.0
!
! ****** Graphics for current part ******
!
geometry create shape block  &
   block_name = .quarter_car.bod_road.BOX_1  &
   adams_id = 1  &
   corner_marker = .quarter_car.bod_road.MARKER_1  &
   diag_corner_coords = 50.0, 50.0, 100.0
!
part attributes  &
   part_name = .quarter_car.bod_road  &
   color = RED  &
   name_visibility = off
!
!--------------------------------- bod_sprung ---------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .quarter_car.ground
!
part create rigid_body name_and_position  &
   part_name = .quarter_car.bod_sprung  &
   adams_id = 3  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .quarter_car.bod_sprung
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .quarter_car.bod_sprung.MARKER_4  &
   adams_id = 4  &
   location = 0.0, 0.0, 626.0  &
   orientation = 180.0d, 90.0d, 180.0d
!
marker create  &
   marker_name = .quarter_car.bod_sprung.cm  &
   adams_id = 21  &
   location = 0.0, 0.0, 726.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .quarter_car.bod_sprung.MARKER_23  &
   adams_id = 23  &
   location = 0.0, 0.0, 626.0  &
   orientation = 0.0d, 180.0d, 0.0d
!
marker create  &
   marker_name = .quarter_car.bod_sprung.MARKER_26  &
   adams_id = 26  &
   location = 0.0, 0.0, 326.0  &
   orientation = 0.0d, 180.0d, 0.0d
!
marker create  &
   marker_name = .quarter_car.bod_sprung.MARKER_30  &
   adams_id = 30  &
   location = 0.0, 0.0, 626.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .quarter_car.bod_sprung.MARKER_44  &
   adams_id = 44  &
   location = 0.0, 0.0, 626.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
part create rigid_body mass_properties  &
   part_name = .quarter_car.bod_sprung  &
   mass = 300.0  &
   center_of_mass_marker = .quarter_car.bod_sprung.cm  &
   ixx = 1.3070700955E+05  &
   iyy = 1.3070700955E+05  &
   izz = 1.3070700955E+05  &
   ixy = 0.0  &
   izx = 0.0  &
   iyz = 0.0
!
! ****** Graphics for current part ******
!
geometry create shape ellipsoid  &
   ellipsoid_name = .quarter_car.bod_sprung.ELLIPSOID_15  &
   adams_id = 6  &
   center_marker = .quarter_car.bod_sprung.MARKER_4  &
   x_scale_factor = 200.0  &
   y_scale_factor = 200.0  &
   z_scale_factor = 200.0
!
part attributes  &
   part_name = .quarter_car.bod_sprung  &
   color = GREEN  &
   name_visibility = off
!
!-------------------------------- bod_unsprung --------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .quarter_car.ground
!
part create rigid_body name_and_position  &
   part_name = .quarter_car.bod_unsprung  &
   adams_id = 4  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .quarter_car.bod_unsprung
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .quarter_car.bod_unsprung.MARKER_5  &
   adams_id = 5  &
   location = 0.0, 0.0, 326.0  &
   orientation = 180.0d, 90.0d, 180.0d
!
marker create  &
   marker_name = .quarter_car.bod_unsprung.cm  &
   adams_id = 22  &
   location = 0.0, 0.0, 326.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .quarter_car.bod_unsprung.MARKER_25  &
   adams_id = 25  &
   location = 0.0, 0.0, 326.0  &
   orientation = 0.0d, 180.0d, 0.0d
!
marker create  &
   marker_name = .quarter_car.bod_unsprung.MARKER_28  &
   adams_id = 28  &
   location = 0.0, 0.0, 326.0  &
   orientation = 180.0d, 90.0d, 180.0d
!
marker create  &
   marker_name = .quarter_car.bod_unsprung.MARKER_29  &
   adams_id = 29  &
   location = 0.0, 0.0, 326.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .quarter_car.bod_unsprung.MARKER_43  &
   adams_id = 43  &
   location = 0.0, 0.0, 326.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
part create rigid_body mass_properties  &
   part_name = .quarter_car.bod_unsprung  &
   mass = 25.0  &
   center_of_mass_marker = .quarter_car.bod_unsprung.cm  &
   ixx = 1.3070700955E+05  &
   iyy = 1.3070700955E+05  &
   izz = 1.3070700955E+05  &
   ixy = 0.0  &
   izx = 0.0  &
   iyz = 0.0
!
! ****** Graphics for current part ******
!
geometry create shape ellipsoid  &
   ellipsoid_name = .quarter_car.bod_unsprung.ELLIPSOID_16  &
   adams_id = 7  &
   center_marker = .quarter_car.bod_unsprung.MARKER_5  &
   x_scale_factor = 200.0  &
   y_scale_factor = 200.0  &
   z_scale_factor = 200.0
!
part attributes  &
   part_name = .quarter_car.bod_unsprung  &
   color = MAIZE  &
   name_visibility = off
!
!----------------------------------- Joints -----------------------------------!
!
!
constraint create joint translational  &
   joint_name = .quarter_car.con_sprung_to_ground  &
   adams_id = 2  &
   i_marker_name = .quarter_car.bod_sprung.MARKER_23  &
   j_marker_name = .quarter_car.ground.MARKER_24
!
constraint attributes  &
   constraint_name = .quarter_car.con_sprung_to_ground  &
   name_visibility = off
!
constraint create joint translational  &
   joint_name = .quarter_car.con_unsprung_to_sprung  &
   adams_id = 3  &
   i_marker_name = .quarter_car.bod_unsprung.MARKER_25  &
   j_marker_name = .quarter_car.bod_sprung.MARKER_26
!
constraint attributes  &
   constraint_name = .quarter_car.con_unsprung_to_sprung  &
   name_visibility = off
!
!----------------------------------- Forces -----------------------------------!
!
!
force create direct single_component_force  &
   single_component_force_name = .quarter_car.for_actuator  &
   adams_id = 2  &
   type_of_freedom = translational  &
   i_marker_name = .quarter_car.bod_unsprung.MARKER_43  &
   j_marker_name = .quarter_car.bod_sprung.MARKER_44  &
   action_only = off  &
   function = ""
!
!---------------------------------- Sensors -----------------------------------!
!
!
executive_control create sensor  &
   sensor_name = .quarter_car.sen_init_susp_disp  &
   adams_id = 1  &
   compare = eq  &
   value = 0.0  &
   error = 0.001  &
   codgen = off  &
   halt = off  &
   print = off  &
   restart = off  &
   return = off  &
   yydump = off  &
   function = ""  &
   evaluate = ""
!
executive_control create sensor  &
   sensor_name = .quarter_car.sen_init_unsprung_disp  &
   adams_id = 2  &
   compare = eq  &
   value = 0.0  &
   error = 0.001  &
   codgen = off  &
   halt = off  &
   print = off  &
   restart = off  &
   return = off  &
   yydump = off  &
   function = ""  &
   evaluate = ""
!
!---------------------------------- Requests ----------------------------------!
!
!
output_control create request  &
   request_name = .quarter_car.request  &
   adams_id = 5  &
   comment = request  &
   component_names = "", "sprung_acc", "susp_stroke", "unsprung_disp"  &
   component_units = "no_units", "acceleration", "length", "length"  &
   results_name = "request"  &
   f2 = ""  &
   f3 = ""  &
   f4 = ""
!
!----------------------------- Simulation Scripts -----------------------------!
!
!
simulation script create  &
   sim_script_name = .quarter_car.Last_Sim  &
   commands = "simulation single_run equilibrium model_name=.quarter_car"
!
simulation script create  &
   sim_script_name = .quarter_car.SIM_SCRIPT_1  &
   solver_commands = "! Insert ACF commands here:", "SIMULATE/STATIC",  &
                     "SIMULATE/DYNAMIC, END=5.0, DTOUT=1.0E-03"
!
!-------------------------- Adams View UDE Instances --------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .quarter_car.ground
!
undo begin_block suppress = yes
!
ude create instance  &
   instance_name = .quarter_car.road  &
   definition_name = .MDI.Forces.vpg_road  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0, 0.0, 0.0
!
ude attributes  &
   instance_name = .quarter_car.road  &
   color = DimGray  &
   visibility = off
!
ude create instance  &
   instance_name = .quarter_car.tire  &
   definition_name = .MDI.Forces.vpg_tire  &
   location = 0.0, 0.0, 326.0  &
   orientation = 0.0, 90.0, 0.0
!
ude create instance  &
   instance_name = .quarter_car.mot_road  &
   definition_name = .MDI.Constraints.general_motion  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0, 0.0, 0.0
!
ude create instance  &
   instance_name = .quarter_car.for_suspension  &
   definition_name = .MDI.Forces.spring  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0, 0.0, 0.0
!
ude attributes  &
   instance_name = .quarter_car.for_suspension  &
   color = RED
!
ude create instance  &
   instance_name = .quarter_car.Controls_Plant  &
   definition_name = .controls.controls_plant  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0, 0.0, 0.0
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
variable modify  &
   variable_name = .quarter_car.road.ref_marker  &
   object_value = .quarter_car.bod_road.road_ref_1
!
variable modify  &
   variable_name = .quarter_car.road.road_property_file  &
   string_value = "road.rdf"
!
variable modify  &
   variable_name = .quarter_car.road.road_graphics  &
   string_value = "off"
!
ude modify instance  &
   instance_name = .quarter_car.road
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
variable modify  &
   variable_name = .quarter_car.tire.cm_offset  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.tire.center_offset  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.tire.ic_vmode  &
   string_value = "standard"
!
variable modify  &
   variable_name = .quarter_car.tire.vm  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .quarter_car.tire.wm  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .quarter_car.tire.long_vel  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.tire.spin_vel  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.tire.vx  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.tire.vy  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.tire.vz  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.tire.wx  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.tire.wy  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.tire.wz  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.tire.ic_vx  &
   string_value = "off"
!
variable modify  &
   variable_name = .quarter_car.tire.ic_vy  &
   string_value = "off"
!
variable modify  &
   variable_name = .quarter_car.tire.ic_vz  &
   string_value = "off"
!
variable modify  &
   variable_name = .quarter_car.tire.ic_wx  &
   string_value = "off"
!
variable modify  &
   variable_name = .quarter_car.tire.ic_wy  &
   string_value = "off"
!
variable modify  &
   variable_name = .quarter_car.tire.ic_wz  &
   string_value = "off"
!
variable modify  &
   variable_name = .quarter_car.tire.ic_vm  &
   string_value = "ground"
!
variable modify  &
   variable_name = .quarter_car.tire.ic_wm  &
   string_value = "cm"
!
variable modify  &
   variable_name = .quarter_car.tire.vmmrk  &
   object_value = (.quarter_car.tire.wheel_part.wheel_cm)
!
variable modify  &
   variable_name = .quarter_car.tire.wmmrk  &
   object_value = (.quarter_car.tire.wheel_part.wheel_cm)
!
variable modify  &
   variable_name = .quarter_car.tire.side  &
   string_value = "left"
!
variable modify  &
   variable_name = .quarter_car.tire.road_property_file  &
   string_value = (.quarter_car.road.road_property_file)
!
variable modify  &
   variable_name = .quarter_car.tire.j_fmarker  &
   object_value = .quarter_car.bod_road.titr_tire_jf_1
!
variable modify  &
   variable_name = .quarter_car.tire.ref_marker  &
   object_value = (.quarter_car.road.ref_marker.object_value)
!
variable modify  &
   variable_name = .quarter_car.tire.wheel_tire_mass  &
   real_value = 25.0
!
variable modify  &
   variable_name = .quarter_car.tire.Ixx_Iyy  &
   real_value = 8.0E+05
!
variable modify  &
   variable_name = .quarter_car.tire.Izz  &
   real_value = 1.0E+06
!
variable modify  &
   variable_name = .quarter_car.tire.property_file  &
   string_value = "tire.tir"
!
variable modify  &
   variable_name = .quarter_car.tire.road_name  &
   string_value = (.quarter_car.road)
!
ude modify instance  &
   instance_name = .quarter_car.tire
!
defaults coordinate_system  &
   default_coordinate_system = .quarter_car.ground
!
marker create  &
   marker_name = .quarter_car.tire.wheel_part.MARKER_27  &
   adams_id = 27  &
   location = 0.0, 0.0, 326.0  &
   orientation = 180.0d, 90.0d, 180.0d
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
variable modify  &
   variable_name = .quarter_car.mot_road.i_marker  &
   object_value = .quarter_car.bod_road.MARKER_2
!
variable modify  &
   variable_name = .quarter_car.mot_road.j_marker  &
   object_value = .quarter_car.ground.MARKER_3
!
variable modify  &
   variable_name = .quarter_car.mot_road.constraint  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .quarter_car.mot_road.t1_type  &
   integer_value = 1
!
variable modify  &
   variable_name = .quarter_car.mot_road.t2_type  &
   integer_value = 1
!
variable modify  &
   variable_name = .quarter_car.mot_road.t3_type  &
   integer_value = 1
!
variable modify  &
   variable_name = .quarter_car.mot_road.r1_type  &
   integer_value = 1
!
variable modify  &
   variable_name = .quarter_car.mot_road.r2_type  &
   integer_value = 1
!
variable modify  &
   variable_name = .quarter_car.mot_road.r3_type  &
   integer_value = 1
!
variable modify  &
   variable_name = .quarter_car.mot_road.t1_func  &
   string_value = "0 * time"
!
variable modify  &
   variable_name = .quarter_car.mot_road.t2_func  &
   string_value = "0 * time"
!
variable modify  &
   variable_name = .quarter_car.mot_road.t3_func  &
   string_value = "VARVAL(var_road_disp)"
!
variable modify  &
   variable_name = .quarter_car.mot_road.r1_func  &
   string_value = "0 * time"
!
variable modify  &
   variable_name = .quarter_car.mot_road.r2_func  &
   string_value = "0 * time"
!
variable modify  &
   variable_name = .quarter_car.mot_road.r3_func  &
   string_value = "0 * time"
!
variable modify  &
   variable_name = .quarter_car.mot_road.t1_ic_disp  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.mot_road.t2_ic_disp  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.mot_road.t3_ic_disp  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.mot_road.r1_ic_disp  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.mot_road.r2_ic_disp  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.mot_road.r3_ic_disp  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.mot_road.t1_ic_velo  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.mot_road.t2_ic_velo  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.mot_road.t3_ic_velo  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.mot_road.r1_ic_velo  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.mot_road.r2_ic_velo  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.mot_road.r3_ic_velo  &
   real_value = 0.0
!
ude modify instance  &
   instance_name = .quarter_car.mot_road
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
variable modify  &
   variable_name = .quarter_car.for_suspension.i_marker  &
   object_value = (.quarter_car.bod_unsprung.MARKER_29)
!
variable modify  &
   variable_name = .quarter_car.for_suspension.j_marker  &
   object_value = (.quarter_car.bod_sprung.MARKER_30)
!
variable modify  &
   variable_name = .quarter_car.for_suspension.stiffness_mode  &
   string_value = "linear"
!
variable modify  &
   variable_name = .quarter_car.for_suspension.stiffness_coefficient  &
   real_value = 20.0
!
variable modify  &
   variable_name = .quarter_car.for_suspension.stiffness_spline  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .quarter_car.for_suspension.damping_mode  &
   string_value = "linear"
!
variable modify  &
   variable_name = .quarter_car.for_suspension.damping_coefficient  &
   real_value = 0.0
!
variable modify  &
   variable_name = .quarter_car.for_suspension.damping_spline  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .quarter_car.for_suspension.free_length_mode  &
   string_value = "Design_Length"
!
variable modify  &
   variable_name = .quarter_car.for_suspension.free_length  &
   real_value = 1.0
!
variable modify  &
   variable_name = .quarter_car.for_suspension.preload  &
   real_value = (.quarter_car.bod_sprung.mass * 9806.65 * 1.0E-03)
!
variable modify  &
   variable_name = .quarter_car.for_suspension.i_dynamic_visibility  &
   string_value = "On"
!
variable modify  &
   variable_name = .quarter_car.for_suspension.j_dynamic_visibility  &
   string_value = "Off"
!
variable modify  &
   variable_name = .quarter_car.for_suspension.spring_visibility  &
   string_value = "depends"
!
variable modify  &
   variable_name = .quarter_car.for_suspension.damper_visibility  &
   string_value = "depends"
!
ude modify instance  &
   instance_name = .quarter_car.for_suspension
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.input_channels  &
   object_value =   &
      .quarter_car.var_actuator,  &
      .quarter_car.var_road_disp
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.output_channels  &
   object_value =   &
      .quarter_car.var_sprung_acc,  &
      .quarter_car.var_sprung_vel,  &
      .quarter_car.var_susp_stroke,  &
      .quarter_car.var_susp_vel,  &
      .quarter_car.var_tire_disp,  &
      .quarter_car.var_unsprung_vel
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.file_name  &
   string_value = "Controls_Plant"
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.event_name  &
   string_value = ""
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.solver_type  &
   string_value = "cplusplus"
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.target  &
   string_value = "MATLAB"
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.FMI_Master  &
   string_value = "none"
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.analysis_type  &
   string_value = "non_linear"
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.analysis_init  &
   string_value = "yes"
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.analysis_init_str  &
   string_value = ""
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.user_lib  &
   string_value = ""
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.host  &
   string_value = "Adams_Host"
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.dynamic_state  &
   string_value = "on"
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.tcp_ip  &
   string_value = "off"
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.output_rate  &
   integer_value = 1
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.realtime  &
   string_value = "off"
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.include_mnf  &
   string_value = "no"
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.hp_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.pv_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.gp_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.pf_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.ude_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.expose_variant  &
   integer_value = 0
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.expose_event  &
   integer_value = 0
!
variable modify  &
   variable_name = .quarter_car.Controls_Plant.add_to_fmu  &
   string_value = ""
!
ude modify instance  &
   instance_name = .quarter_car.Controls_Plant
!
undo end_block
!
!--------------------------- UDE Dependent Objects ----------------------------!
!
!
constraint create joint fixed  &
   joint_name = .quarter_car.con_tire_to_unsprung  &
   adams_id = 4  &
   i_marker_name = .quarter_car.tire.wheel_part.MARKER_27  &
   j_marker_name = .quarter_car.bod_unsprung.MARKER_28
!
constraint attributes  &
   constraint_name = .quarter_car.con_tire_to_unsprung  &
   name_visibility = off
!
!------------------------------ Dynamic Graphics ------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .quarter_car.ground
!
geometry create shape force  &
   force_name = .quarter_car.SFORCE_2_force_graphic_1  &
   adams_id = 24  &
   force_element_name = .quarter_car.for_actuator  &
   applied_at_marker_name = .quarter_car.bod_unsprung.MARKER_43
!
!---------------------------------- Accgrav -----------------------------------!
!
!
force create body gravitational  &
   gravity_field_name = for_gravity  &
   x_component_gravity = 0.0  &
   y_component_gravity = 0.0  &
   z_component_gravity = -9806.65
!
!----------------------------- Analysis settings ------------------------------!
!
!
output_control set output  &
   model_name = quarter_car  &
   grsave = off
!
!---------------------------- Function definitions ----------------------------!
!
!
data_element modify variable  &
   variable_name = .quarter_car.var_sprung_acc  &
   function = "ACCZ(.quarter_car.bod_sprung.cm)"
!
data_element modify variable  &
   variable_name = .quarter_car.var_sprung_vel  &
   function = "VZ(.quarter_car.bod_sprung.cm)"
!
data_element modify variable  &
   variable_name = .quarter_car.var_actuator  &
   function = "0"
!
data_element modify variable  &
   variable_name = .quarter_car.var_tire_disp  &
   function = "DZ(.quarter_car.bod_unsprung.cm, .quarter_car.bod_road.road_ref_1) - 309.7"
!
data_element modify variable  &
   variable_name = .quarter_car.var_susp_stroke  &
   function = "DZ(.quarter_car.bod_sprung.cm, .quarter_car.bod_unsprung.cm)-400"
!
data_element modify variable  &
   variable_name = .quarter_car.var_tire_force  &
   function = "MOTION(.quarter_car.mot_road.motion_t3, 0, 4, 0)"
!
data_element modify variable  &
   variable_name = .quarter_car.var_susp_vel  &
   function = "VZ(.quarter_car.bod_sprung.cm, .quarter_car.bod_unsprung.cm)"
!
data_element modify variable  &
   variable_name = .quarter_car.var_unsprung_vel  &
   function = "VZ(.quarter_car.bod_unsprung.cm)"
!
data_element modify variable  &
   variable_name = .quarter_car.var_road_disp  &
   function = "0"
!
force modify direct single_component_force  &
   single_component_force_name = .quarter_car.for_actuator  &
   function = "-VARVAL(.quarter_car.var_actuator)"
!
output_control modify request  &
   request_name = .quarter_car.request  &
   f2 = "ACCZ(.quarter_car.bod_sprung.cm)"  &
   f3 = "DZ(.quarter_car.bod_sprung.cm) - DZ(.quarter_car.bod_unsprung.cm) - SENVAL(.quarter_car.sen_init_susp_disp)"  &
   f4 = "DZ(.quarter_car.bod_unsprung.cm) - SENVAL(.quarter_car.sen_init_unsprung_disp)"
!
executive_control modify sensor  &
   sensor_name = .quarter_car.sen_init_susp_disp  &
   function = "time"  &
   evaluate = "DZ(.quarter_car.bod_sprung.cm) - DZ(.quarter_car.bod_unsprung.cm)"
!
executive_control modify sensor  &
   sensor_name = .quarter_car.sen_init_unsprung_disp  &
   function = "time"  &
   evaluate = "DZ(.quarter_car.bod_unsprung.cm)"
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
ude modify instance  &
   instance_name = .quarter_car.road
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
ude modify instance  &
   instance_name = .quarter_car.tire
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
ude modify instance  &
   instance_name = .quarter_car.mot_road
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
ude modify instance  &
   instance_name = .quarter_car.for_suspension
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
ude modify instance  &
   instance_name = .quarter_car.Controls_Plant
!
!------------------------- Part IC Reference Markers --------------------------!
!
!
part modify rigid_body initial_velocity  &
   part_name = .quarter_car.tire.wheel_part  &
   vm = .quarter_car.tire.wheel_part.wheel_cm  &
   wm = .quarter_car.tire.wheel_part.wheel_cm
!
part modify rigid_body initial_velocity  &
   part_name = .quarter_car.tire.belt_part  &
   vm = .quarter_car.tire.wheel_part.wheel_cm  &
   wm = .quarter_car.tire.wheel_part.wheel_cm
!
!--------------------------- Expression definitions ---------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = ground
!
material modify  &
   material_name = .quarter_car.steel  &
   density = (7801.0(kg/meter**3))  &
   youngs_modulus = (2.07E+11(Newton/meter**2))
!
marker modify  &
   marker_name = .quarter_car.bod_road.road_ref_1  &
   location =   &
      (.quarter_car.road.location)  &
   orientation =   &
      (.quarter_car.road.orientation)  &
   relative_to = .quarter_car.bod_road
!
defaults coordinate_system  &
   default_coordinate_system = .quarter_car.ground
!
geometry modify shape block  &
   block_name = .quarter_car.bod_road.BOX_1  &
   diag_corner_coords =   &
      (50.0mm),  &
      (50.0mm),  &
      (100.0mm)
!
geometry modify shape ellipsoid  &
   ellipsoid_name = .quarter_car.bod_sprung.ELLIPSOID_15  &
   x_scale_factor = (2 * 10.0cm)  &
   y_scale_factor = (2 * 10.0cm)  &
   z_scale_factor = (2 * 10.0cm)
!
geometry modify shape ellipsoid  &
   ellipsoid_name = .quarter_car.bod_unsprung.ELLIPSOID_16  &
   x_scale_factor = (2 * 10.0cm)  &
   y_scale_factor = (2 * 10.0cm)  &
   z_scale_factor = (2 * 10.0cm)
!
marker modify  &
   marker_name = .quarter_car.tire.wheel_part.gfo_i  &
   orientation =   &
      (ORI_RELATIVE_TO({0d, 270d, 0d}, .quarter_car.tire.wheel_part.wheel_cm))  &
   relative_to = .quarter_car.tire.wheel_part
!
defaults coordinate_system  &
   default_coordinate_system = .quarter_car.ground
!
geometry modify shape force  &
   force_name = .quarter_car.SFORCE_2_force_graphic_1  &
   applied_at_marker_name = (.quarter_car.for_actuator.i)
!
model display  &
   model_name = quarter_car
