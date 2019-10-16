.hsa_code_object_version 2,1
.hsa_code_object_isa 9,0,6,"AMD","AMDGPU"


.p2align 8

.amdgpu_hsa_kernel sconv_32x32_splitk4_asm

sconv_32x32_splitk4_asm:
	.amd_kernel_code_t
		amd_code_version_major = 1
		amd_code_version_minor = 2
		amd_machine_kind = 1
		amd_machine_version_major = 9
		amd_machine_version_minor = 0
		amd_machine_version_stepping = 6
		kernel_code_entry_byte_offset = 256
		kernel_code_prefetch_byte_size = 0
		granulated_workitem_vgpr_count = 20
		granulated_wavefront_sgpr_count = 11
		priority = 0
		float_mode = 192
		priv = 0
		enable_dx10_clamp = 1
		debug_mode = 0
		enable_ieee_mode = 1
		enable_sgpr_private_segment_wave_byte_offset = 0
		user_sgpr_count = 6
		enable_trap_handler = 0
		enable_sgpr_workgroup_id_x = 1
		enable_sgpr_workgroup_id_y = 1
		enable_sgpr_workgroup_id_z = 0
		enable_sgpr_workgroup_info = 0
		enable_vgpr_workitem_id = 0
		enable_exception_msb = 0
		granulated_lds_size = 0
		enable_exception = 0
		enable_sgpr_private_segment_buffer = 1
		enable_sgpr_dispatch_ptr = 0
		enable_sgpr_queue_ptr = 0
		enable_sgpr_kernarg_segment_ptr = 1
		enable_sgpr_dispatch_id = 0
		enable_sgpr_flat_scratch_init = 0
		enable_sgpr_private_segment_size = 0
		enable_sgpr_grid_workgroup_count_x = 0
		enable_sgpr_grid_workgroup_count_y = 0
		enable_sgpr_grid_workgroup_count_z = 0
		enable_ordered_append_gds = 0
		private_element_size = 1
		is_ptr64 = 1
		is_dynamic_callstack = 0
		is_debug_enabled = 0
		is_xnack_enabled = 0
		workitem_private_segment_byte_size = 0
		workgroup_group_segment_byte_size = 16384
		gds_segment_byte_size = 0
		kernarg_segment_byte_size = 52
		workgroup_fbarrier_count = 0
		wavefront_sgpr_count = 96
		workitem_vgpr_count = 84
		reserved_vgpr_first = 0
		reserved_vgpr_count = 0
		reserved_sgpr_first = 0
		reserved_sgpr_count = 0
		debug_wavefront_private_segment_offset_sgpr = 0
		debug_private_segment_buffer_sgpr = 0
		kernarg_segment_alignment = 4
		group_segment_alignment = 4
		private_segment_alignment = 4
		wavefront_size = 6
		call_convention = -1
		runtime_loader_kernel_symbol = 0
	.end_amd_kernel_code_t
    
	//sconv-32x32-splitk4- kernel 

	
	s_mov_b32 s8, s7                                           // 000000003F00: BE880007
	s_load_dwordx2 s[8:9], s[4:5], 0x8                         // 000000003F04: C0060202 00000008
	s_load_dwordx2 s[10:11], s[4:5], 0x10                      // 000000003F0C: C0060282 00000010
	s_load_dwordx2 s[12:13], s[4:5], 0x18                      // 000000003F14: C0060302 00000018
	s_load_dwordx2 s[14:15], s[4:5], 0x20                      // 000000003F1C: C0060382 00000020
	s_load_dwordx2 s[16:17], s[4:5], 0x28                      // 000000003F24: C0060402 00000028
	s_load_dword s18, s[4:5], 0x30                             // 000000003F2C: C0020482 00000030
	s_lshl_b32 s27, s6, 5                                      // 000000003F34: 8E1B8506
	s_lshl_b32 s28, s7, 5                                      // 000000003F38: 8E1C8507
	v_lshlrev_b32_e32 v80, 2, v0                               // 000000003F3C: 24A00082
	v_and_b32_e64 v80, v80, 31                                 // 000000003F40: D1130050 00013F50
	v_lshrrev_b32_e32 v81, 3, v0                               // 000000003F48: 20A20083
	v_lshlrev_b32_e32 v81, 2, v81                              // 000000003F4C: 24A2A282
	v_and_b32_e64 v81, v81, 31                                 // 000000003F50: D1130051 00013F51
	v_readfirstlane_b32 s31, v0                                // 000000003F58: 7E3E0500
	s_lshr_b32 s31, s31, 6                                     // 000000003F5C: 8F1F861F
	s_waitcnt lgkmcnt(0)                                       // 000000003F60: BF8CC07F
	s_mul_i32 s31, s31, s18                                    // 000000003F64: 921F121F
	s_mov_b32 s32, s31                                         // 000000003F68: BEA0001F
	s_mul_i32 s31, s31, s14                                    // 000000003F6C: 921F0E1F
	s_mul_i32 s31, s31, s15                                    // 000000003F70: 921F0F1F
	v_mov_b32_e32 v2, s27                                      // 000000003F74: 7E04021B
	v_add_u32_e64 v2, v2, s31                                  // 000000003F78: D1340002 00003F02
	v_add_u32_e32 v2, v2, v80                                  // 000000003F80: 6804A102
	v_lshlrev_b32_e32 v2, 2, v2                                // 000000003F84: 24040482
	v_mov_b32_e32 v3, 0                                        // 000000003F88: 7E060280
	v_mov_b32_e32 v4, s28                                      // 000000003F8C: 7E08021C
	v_add_u32_e64 v4, v4, s32                                  // 000000003F90: D1340004 00004104
	v_add_u32_e32 v4, v4, v81                                  // 000000003F98: 6808A304
	v_lshlrev_b32_e32 v4, 2, v4                                // 000000003F9C: 24080882
	v_mov_b32_e32 v5, 0                                        // 000000003FA0: 7E0A0280
	s_mul_i32 s33, s14, s15                                    // 000000003FA4: 92210F0E
	s_mul_i32 s33, s33, 4                                      // 000000003FA8: 92218421
	s_mov_b64 s[20:21], s[8:9]                                 // 000000003FAC: BE940108
	s_mov_b64 s[22:23], s[10:11]                               // 000000003FB0: BE96010A
	s_lshl_b32 s38, s16, 2                                     // 000000003FB4: 8E268210
	s_mov_b64 s[36:37], s[22:23]                               // 000000003FB8: BEA40116
	global_load_dwordx4 v[8:11], v[2:3], s[20:21]              // 000000003FBC: DC5C8000 08140002
	s_add_u32 s20, s20, s33                                    // 000000003FC4: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000003FC8: 82158015
	global_load_dwordx4 v[12:15], v[2:3], s[20:21]             // 000000003FCC: DC5C8000 0C140002
	s_add_u32 s20, s20, s33                                    // 000000003FD4: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000003FD8: 82158015
	global_load_dwordx4 v[16:19], v[2:3], s[20:21]             // 000000003FDC: DC5C8000 10140002
	s_add_u32 s20, s20, s33                                    // 000000003FE4: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000003FE8: 82158015
	global_load_dwordx4 v[20:23], v[2:3], s[20:21]             // 000000003FEC: DC5C8000 14140002
	s_add_u32 s20, s20, s33                                    // 000000003FF4: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000003FF8: 82158015
	global_load_dwordx4 v[40:43], v[4:5], s[36:37]             // 000000003FFC: DC5C8000 28240004
	s_add_u32 s36, s36, s38                                    // 000000004004: 80242624
	s_addc_u32 s37, s37, 0                                     // 000000004008: 82258025
	global_load_dwordx4 v[44:47], v[4:5], s[36:37]             // 00000000400C: DC5C8000 2C240004
	s_add_u32 s36, s36, s38                                    // 000000004014: 80242624
	s_addc_u32 s37, s37, 0                                     // 000000004018: 82258025
	global_load_dwordx4 v[48:51], v[4:5], s[36:37]             // 00000000401C: DC5C8000 30240004
	s_add_u32 s36, s36, s38                                    // 000000004024: 80242624
	s_addc_u32 s37, s37, 0                                     // 000000004028: 82258025
	global_load_dwordx4 v[52:55], v[4:5], s[36:37]             // 00000000402C: DC5C8000 34240004
	s_add_u32 s22, s22, 16                                     // 000000004034: 80169016
	s_addc_u32 s23, s23, 0                                     // 000000004038: 82178017
	v_mov_b32_e32 v64, 0                                       // 00000000403C: 7E800280
	v_mov_b32_e32 v65, 0                                       // 000000004040: 7E820280
	v_mov_b32_e32 v66, 0                                       // 000000004044: 7E840280
	v_mov_b32_e32 v67, 0                                       // 000000004048: 7E860280
	v_mov_b32_e32 v68, 0                                       // 00000000404C: 7E880280
	v_mov_b32_e32 v69, 0                                       // 000000004050: 7E8A0280
	v_mov_b32_e32 v70, 0                                       // 000000004054: 7E8C0280
	v_mov_b32_e32 v71, 0                                       // 000000004058: 7E8E0280
	v_mov_b32_e32 v72, 0                                       // 00000000405C: 7E900280
	v_mov_b32_e32 v73, 0                                       // 000000004060: 7E920280
	v_mov_b32_e32 v74, 0                                       // 000000004064: 7E940280
	v_mov_b32_e32 v75, 0                                       // 000000004068: 7E960280
	v_mov_b32_e32 v76, 0                                       // 00000000406C: 7E980280
	v_mov_b32_e32 v77, 0                                       // 000000004070: 7E9A0280
	v_mov_b32_e32 v78, 0                                       // 000000004074: 7E9C0280
	v_mov_b32_e32 v79, 0                                       // 000000004078: 7E9E0280
	s_mov_b32 s26, 0                                           // 00000000407C: BE9A0080
    s_sub_u32 s18,  s18, 16     
    
label_major_loop_begin:
	s_mov_b64 s[36:37], s[22:23]                               // 000000004080: BEA40116
	global_load_dwordx4 v[24:27], v[2:3], s[20:21]             // 000000004084: DC5C8000 18140002
	s_add_u32 s20, s20, s33                                    // 00000000408C: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000004090: 82158015
	global_load_dwordx4 v[28:31], v[2:3], s[20:21]             // 000000004094: DC5C8000 1C140002
	s_add_u32 s20, s20, s33                                    // 00000000409C: 80142114
	s_addc_u32 s21, s21, 0                                     // 0000000040A0: 82158015
	global_load_dwordx4 v[32:35], v[2:3], s[20:21]             // 0000000040A4: DC5C8000 20140002
	s_add_u32 s20, s20, s33                                    // 0000000040AC: 80142114
	s_addc_u32 s21, s21, 0                                     // 0000000040B0: 82158015
	global_load_dwordx4 v[36:39], v[2:3], s[20:21]             // 0000000040B4: DC5C8000 24140002
	s_add_u32 s20, s20, s33                                    // 0000000040BC: 80142114
	s_addc_u32 s21, s21, 0                                     // 0000000040C0: 82158015
	global_load_dwordx4 v[56:59], v[4:5], s[36:37]             // 0000000040C4: DC5C8000 38240004
	s_add_u32 s36, s36, s38                                    // 0000000040CC: 80242624
	s_addc_u32 s37, s37, 0                                     // 0000000040D0: 82258025
	global_load_dwordx4 v[60:63], v[4:5], s[36:37]             // 0000000040D4: DC5C8000 3C240004
	s_add_u32 s36, s36, s38                                    // 0000000040DC: 80242624
	s_addc_u32 s37, s37, 0                                     // 0000000040E0: 82258025
	global_load_dwordx4 v[64:67], v[4:5], s[36:37]             // 0000000040E4: DC5C8000 40240004
	s_add_u32 s36, s36, s38                                    // 0000000040EC: 80242624
	s_addc_u32 s37, s37, 0                                     // 0000000040F0: 82258025
	global_load_dwordx4 v[68:71], v[4:5], s[36:37]             // 0000000040F4: DC5C8000 44240004
	s_add_u32 s22, s22, 16                                     // 0000000040FC: 80169016
	s_addc_u32 s23, s23, 0                                     // 000000004100: 82178017
	s_waitcnt vmcnt(11)                                        // 000000004104: BF8C0F7B
	v_fma_f32 v64, v8, v40, v64                                // 000000004108: D1CB0040 05025108
	v_fma_f32 v64, v12, v41, v64                               // 000000004110: D1CB0040 0502530C
	v_fma_f32 v64, v16, v42, v64                               // 000000004118: D1CB0040 05025510
	v_fma_f32 v64, v20, v43, v64                               // 000000004120: D1CB0040 05025714
	v_fma_f32 v65, v9, v40, v65                                // 000000004128: D1CB0041 05065109
	v_fma_f32 v65, v13, v41, v65                               // 000000004130: D1CB0041 0506530D
	v_fma_f32 v65, v17, v42, v65                               // 000000004138: D1CB0041 05065511
	v_fma_f32 v65, v21, v43, v65                               // 000000004140: D1CB0041 05065715
	v_fma_f32 v66, v10, v40, v66                               // 000000004148: D1CB0042 050A510A
	v_fma_f32 v66, v14, v41, v66                               // 000000004150: D1CB0042 050A530E
	v_fma_f32 v66, v18, v42, v66                               // 000000004158: D1CB0042 050A5512
	v_fma_f32 v66, v22, v43, v66                               // 000000004160: D1CB0042 050A5716
	v_fma_f32 v67, v11, v40, v67                               // 000000004168: D1CB0043 050E510B
	v_fma_f32 v67, v15, v41, v67                               // 000000004170: D1CB0043 050E530F
	v_fma_f32 v67, v19, v42, v67                               // 000000004178: D1CB0043 050E5513
	v_fma_f32 v67, v23, v43, v67                               // 000000004180: D1CB0043 050E5717
	s_waitcnt vmcnt(10)                                        // 000000004188: BF8C0F7A
	v_fma_f32 v68, v8, v44, v68                                // 00000000418C: D1CB0044 05125908
	v_fma_f32 v68, v12, v45, v68                               // 000000004194: D1CB0044 05125B0C
	v_fma_f32 v68, v16, v46, v68                               // 00000000419C: D1CB0044 05125D10
	v_fma_f32 v68, v20, v47, v68                               // 0000000041A4: D1CB0044 05125F14
	v_fma_f32 v69, v9, v44, v69                                // 0000000041AC: D1CB0045 05165909
	v_fma_f32 v69, v13, v45, v69                               // 0000000041B4: D1CB0045 05165B0D
	v_fma_f32 v69, v17, v46, v69                               // 0000000041BC: D1CB0045 05165D11
	v_fma_f32 v69, v21, v47, v69                               // 0000000041C4: D1CB0045 05165F15
	v_fma_f32 v70, v10, v44, v70                               // 0000000041CC: D1CB0046 051A590A
	v_fma_f32 v70, v14, v45, v70                               // 0000000041D4: D1CB0046 051A5B0E
	v_fma_f32 v70, v18, v46, v70                               // 0000000041DC: D1CB0046 051A5D12
	v_fma_f32 v70, v22, v47, v70                               // 0000000041E4: D1CB0046 051A5F16
	v_fma_f32 v71, v11, v44, v71                               // 0000000041EC: D1CB0047 051E590B
	v_fma_f32 v71, v15, v45, v71                               // 0000000041F4: D1CB0047 051E5B0F
	v_fma_f32 v71, v19, v46, v71                               // 0000000041FC: D1CB0047 051E5D13
	v_fma_f32 v71, v23, v47, v71                               // 000000004204: D1CB0047 051E5F17
	s_waitcnt vmcnt(9)                                         // 00000000420C: BF8C0F79
	v_fma_f32 v72, v8, v48, v72                                // 000000004210: D1CB0048 05226108
	v_fma_f32 v72, v12, v49, v72                               // 000000004218: D1CB0048 0522630C
	v_fma_f32 v72, v16, v50, v72                               // 000000004220: D1CB0048 05226510
	v_fma_f32 v72, v20, v51, v72                               // 000000004228: D1CB0048 05226714
	v_fma_f32 v73, v9, v48, v73                                // 000000004230: D1CB0049 05266109
	v_fma_f32 v73, v13, v49, v73                               // 000000004238: D1CB0049 0526630D
	v_fma_f32 v73, v17, v50, v73                               // 000000004240: D1CB0049 05266511
	v_fma_f32 v73, v21, v51, v73                               // 000000004248: D1CB0049 05266715
	v_fma_f32 v74, v10, v48, v74                               // 000000004250: D1CB004A 052A610A
	v_fma_f32 v74, v14, v49, v74                               // 000000004258: D1CB004A 052A630E
	v_fma_f32 v74, v18, v50, v74                               // 000000004260: D1CB004A 052A6512
	v_fma_f32 v74, v22, v51, v74                               // 000000004268: D1CB004A 052A6716
	v_fma_f32 v75, v11, v48, v75                               // 000000004270: D1CB004B 052E610B
	v_fma_f32 v75, v15, v49, v75                               // 000000004278: D1CB004B 052E630F
	v_fma_f32 v75, v19, v50, v75                               // 000000004280: D1CB004B 052E6513
	v_fma_f32 v75, v23, v51, v75                               // 000000004288: D1CB004B 052E6717
	s_waitcnt vmcnt(8)                                         // 000000004290: BF8C0F78
	v_fma_f32 v76, v8, v52, v76                                // 000000004294: D1CB004C 05326908
	v_fma_f32 v76, v12, v53, v76                               // 00000000429C: D1CB004C 05326B0C
	v_fma_f32 v76, v16, v54, v76                               // 0000000042A4: D1CB004C 05326D10
	v_fma_f32 v76, v20, v55, v76                               // 0000000042AC: D1CB004C 05326F14
	v_fma_f32 v77, v9, v52, v77                                // 0000000042B4: D1CB004D 05366909
	v_fma_f32 v77, v13, v53, v77                               // 0000000042BC: D1CB004D 05366B0D
	v_fma_f32 v77, v17, v54, v77                               // 0000000042C4: D1CB004D 05366D11
	v_fma_f32 v77, v21, v55, v77                               // 0000000042CC: D1CB004D 05366F15
	v_fma_f32 v78, v10, v52, v78                               // 0000000042D4: D1CB004E 053A690A
	v_fma_f32 v78, v14, v53, v78                               // 0000000042DC: D1CB004E 053A6B0E
	v_fma_f32 v78, v18, v54, v78                               // 0000000042E4: D1CB004E 053A6D12
	v_fma_f32 v78, v22, v55, v78                               // 0000000042EC: D1CB004E 053A6F16
	v_fma_f32 v79, v11, v52, v79                               // 0000000042F4: D1CB004F 053E690B
	v_fma_f32 v79, v15, v53, v79                               // 0000000042FC: D1CB004F 053E6B0F
	v_fma_f32 v79, v19, v54, v79                               // 000000004304: D1CB004F 053E6D13
	v_fma_f32 v79, v23, v55, v79                               // 00000000430C: D1CB004F 053E6F17
	s_mov_b64 s[36:37], s[22:23]                               // 000000004314: BEA40116
	global_load_dwordx4 v[8:11], v[2:3], s[20:21]              // 000000004318: DC5C8000 08140002
	s_add_u32 s20, s20, s33                                    // 000000004320: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000004324: 82158015
	global_load_dwordx4 v[12:15], v[2:3], s[20:21]             // 000000004328: DC5C8000 0C140002
	s_add_u32 s20, s20, s33                                    // 000000004330: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000004334: 82158015
	global_load_dwordx4 v[16:19], v[2:3], s[20:21]             // 000000004338: DC5C8000 10140002
	s_add_u32 s20, s20, s33                                    // 000000004340: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000004344: 82158015
	global_load_dwordx4 v[20:23], v[2:3], s[20:21]             // 000000004348: DC5C8000 14140002
	s_add_u32 s20, s20, s33                                    // 000000004350: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000004354: 82158015
	global_load_dwordx4 v[40:43], v[4:5], s[36:37]             // 000000004358: DC5C8000 28240004
	s_add_u32 s36, s36, s38                                    // 000000004360: 80242624
	s_addc_u32 s37, s37, 0                                     // 000000004364: 82258025
	global_load_dwordx4 v[44:47], v[4:5], s[36:37]             // 000000004368: DC5C8000 2C240004
	s_add_u32 s36, s36, s38                                    // 000000004370: 80242624
	s_addc_u32 s37, s37, 0                                     // 000000004374: 82258025
	global_load_dwordx4 v[48:51], v[4:5], s[36:37]             // 000000004378: DC5C8000 30240004
	s_add_u32 s36, s36, s38                                    // 000000004380: 80242624
	s_addc_u32 s37, s37, 0                                     // 000000004384: 82258025
	global_load_dwordx4 v[52:55], v[4:5], s[36:37]             // 000000004388: DC5C8000 34240004
	s_add_u32 s22, s22, 16                                     // 000000004390: 80169016
	s_addc_u32 s23, s23, 0                                     // 000000004394: 82178017
	s_waitcnt vmcnt(11)                                        // 000000004398: BF8C0F7B
	v_fma_f32 v64, v24, v56, v64                               // 00000000439C: D1CB0040 05027118
	v_fma_f32 v64, v28, v57, v64                               // 0000000043A4: D1CB0040 0502731C
	v_fma_f32 v64, v32, v58, v64                               // 0000000043AC: D1CB0040 05027520
	v_fma_f32 v64, v36, v59, v64                               // 0000000043B4: D1CB0040 05027724
	v_fma_f32 v65, v25, v56, v65                               // 0000000043BC: D1CB0041 05067119
	v_fma_f32 v65, v29, v57, v65                               // 0000000043C4: D1CB0041 0506731D
	v_fma_f32 v65, v33, v58, v65                               // 0000000043CC: D1CB0041 05067521
	v_fma_f32 v65, v37, v59, v65                               // 0000000043D4: D1CB0041 05067725
	v_fma_f32 v66, v26, v56, v66                               // 0000000043DC: D1CB0042 050A711A
	v_fma_f32 v66, v30, v57, v66                               // 0000000043E4: D1CB0042 050A731E
	v_fma_f32 v66, v34, v58, v66                               // 0000000043EC: D1CB0042 050A7522
	v_fma_f32 v66, v38, v59, v66                               // 0000000043F4: D1CB0042 050A7726
	v_fma_f32 v67, v27, v56, v67                               // 0000000043FC: D1CB0043 050E711B
	v_fma_f32 v67, v31, v57, v67                               // 000000004404: D1CB0043 050E731F
	v_fma_f32 v67, v35, v58, v67                               // 00000000440C: D1CB0043 050E7523
	v_fma_f32 v67, v39, v59, v67                               // 000000004414: D1CB0043 050E7727
	s_waitcnt vmcnt(10)                                        // 00000000441C: BF8C0F7A
	v_fma_f32 v68, v24, v60, v68                               // 000000004420: D1CB0044 05127918
	v_fma_f32 v68, v28, v61, v68                               // 000000004428: D1CB0044 05127B1C
	v_fma_f32 v68, v32, v62, v68                               // 000000004430: D1CB0044 05127D20
	v_fma_f32 v68, v36, v63, v68                               // 000000004438: D1CB0044 05127F24
	v_fma_f32 v69, v25, v60, v69                               // 000000004440: D1CB0045 05167919
	v_fma_f32 v69, v29, v61, v69                               // 000000004448: D1CB0045 05167B1D
	v_fma_f32 v69, v33, v62, v69                               // 000000004450: D1CB0045 05167D21
	v_fma_f32 v69, v37, v63, v69                               // 000000004458: D1CB0045 05167F25
	v_fma_f32 v70, v26, v60, v70                               // 000000004460: D1CB0046 051A791A
	v_fma_f32 v70, v30, v61, v70                               // 000000004468: D1CB0046 051A7B1E
	v_fma_f32 v70, v34, v62, v70                               // 000000004470: D1CB0046 051A7D22
	v_fma_f32 v70, v38, v63, v70                               // 000000004478: D1CB0046 051A7F26
	v_fma_f32 v71, v27, v60, v71                               // 000000004480: D1CB0047 051E791B
	v_fma_f32 v71, v31, v61, v71                               // 000000004488: D1CB0047 051E7B1F
	v_fma_f32 v71, v35, v62, v71                               // 000000004490: D1CB0047 051E7D23
	v_fma_f32 v71, v39, v63, v71                               // 000000004498: D1CB0047 051E7F27
	s_waitcnt vmcnt(9)                                         // 0000000044A0: BF8C0F79
	v_fma_f32 v72, v24, v64, v72                               // 0000000044A4: D1CB0048 05228118
	v_fma_f32 v72, v28, v65, v72                               // 0000000044AC: D1CB0048 0522831C
	v_fma_f32 v72, v32, v66, v72                               // 0000000044B4: D1CB0048 05228520
	v_fma_f32 v72, v36, v67, v72                               // 0000000044BC: D1CB0048 05228724
	v_fma_f32 v73, v25, v64, v73                               // 0000000044C4: D1CB0049 05268119
	v_fma_f32 v73, v29, v65, v73                               // 0000000044CC: D1CB0049 0526831D
	v_fma_f32 v73, v33, v66, v73                               // 0000000044D4: D1CB0049 05268521
	v_fma_f32 v73, v37, v67, v73                               // 0000000044DC: D1CB0049 05268725
	v_fma_f32 v74, v26, v64, v74                               // 0000000044E4: D1CB004A 052A811A
	v_fma_f32 v74, v30, v65, v74                               // 0000000044EC: D1CB004A 052A831E
	v_fma_f32 v74, v34, v66, v74                               // 0000000044F4: D1CB004A 052A8522
	v_fma_f32 v74, v38, v67, v74                               // 0000000044FC: D1CB004A 052A8726
	v_fma_f32 v75, v27, v64, v75                               // 000000004504: D1CB004B 052E811B
	v_fma_f32 v75, v31, v65, v75                               // 00000000450C: D1CB004B 052E831F
	v_fma_f32 v75, v35, v66, v75                               // 000000004514: D1CB004B 052E8523
	v_fma_f32 v75, v39, v67, v75                               // 00000000451C: D1CB004B 052E8727
	s_waitcnt vmcnt(8)                                         // 000000004524: BF8C0F78
	v_fma_f32 v76, v24, v68, v76                               // 000000004528: D1CB004C 05328918
	v_fma_f32 v76, v28, v69, v76                               // 000000004530: D1CB004C 05328B1C
	v_fma_f32 v76, v32, v70, v76                               // 000000004538: D1CB004C 05328D20
	v_fma_f32 v76, v36, v71, v76                               // 000000004540: D1CB004C 05328F24
	v_fma_f32 v77, v25, v68, v77                               // 000000004548: D1CB004D 05368919
	v_fma_f32 v77, v29, v69, v77                               // 000000004550: D1CB004D 05368B1D
	v_fma_f32 v77, v33, v70, v77                               // 000000004558: D1CB004D 05368D21
	v_fma_f32 v77, v37, v71, v77                               // 000000004560: D1CB004D 05368F25
	v_fma_f32 v78, v26, v68, v78                               // 000000004568: D1CB004E 053A891A
	v_fma_f32 v78, v30, v69, v78                               // 000000004570: D1CB004E 053A8B1E
	v_fma_f32 v78, v34, v70, v78                               // 000000004578: D1CB004E 053A8D22
	v_fma_f32 v78, v38, v71, v78                               // 000000004580: D1CB004E 053A8F26
	v_fma_f32 v79, v27, v68, v79                               // 000000004588: D1CB004F 053E891B
	v_fma_f32 v79, v31, v69, v79                               // 000000004590: D1CB004F 053E8B1F
	v_fma_f32 v79, v35, v70, v79                               // 000000004598: D1CB004F 053E8D23
	v_fma_f32 v79, v39, v71, v79                               // 0000000045A0: D1CB004F 053E8F27
	s_mov_b64 s[36:37], s[22:23]                               // 0000000045A8: BEA40116
	global_load_dwordx4 v[24:27], v[2:3], s[20:21]             // 0000000045AC: DC5C8000 18140002
	s_add_u32 s20, s20, s33                                    // 0000000045B4: 80142114
	s_addc_u32 s21, s21, 0                                     // 0000000045B8: 82158015
	global_load_dwordx4 v[28:31], v[2:3], s[20:21]             // 0000000045BC: DC5C8000 1C140002
	s_add_u32 s20, s20, s33                                    // 0000000045C4: 80142114
	s_addc_u32 s21, s21, 0                                     // 0000000045C8: 82158015
	global_load_dwordx4 v[32:35], v[2:3], s[20:21]             // 0000000045CC: DC5C8000 20140002
	s_add_u32 s20, s20, s33                                    // 0000000045D4: 80142114
	s_addc_u32 s21, s21, 0                                     // 0000000045D8: 82158015
	global_load_dwordx4 v[36:39], v[2:3], s[20:21]             // 0000000045DC: DC5C8000 24140002
	s_add_u32 s20, s20, s33                                    // 0000000045E4: 80142114
	s_addc_u32 s21, s21, 0                                     // 0000000045E8: 82158015
	global_load_dwordx4 v[56:59], v[4:5], s[36:37]             // 0000000045EC: DC5C8000 38240004
	s_add_u32 s36, s36, s38                                    // 0000000045F4: 80242624
	s_addc_u32 s37, s37, 0                                     // 0000000045F8: 82258025
	global_load_dwordx4 v[60:63], v[4:5], s[36:37]             // 0000000045FC: DC5C8000 3C240004
	s_add_u32 s36, s36, s38                                    // 000000004604: 80242624
	s_addc_u32 s37, s37, 0                                     // 000000004608: 82258025
	global_load_dwordx4 v[64:67], v[4:5], s[36:37]             // 00000000460C: DC5C8000 40240004
	s_add_u32 s36, s36, s38                                    // 000000004614: 80242624
	s_addc_u32 s37, s37, 0                                     // 000000004618: 82258025
	global_load_dwordx4 v[68:71], v[4:5], s[36:37]             // 00000000461C: DC5C8000 44240004
	s_add_u32 s22, s22, 16                                     // 000000004624: 80169016
	s_addc_u32 s23, s23, 0                                     // 000000004628: 82178017
	s_waitcnt vmcnt(11)                                        // 00000000462C: BF8C0F7B
	v_fma_f32 v64, v8, v40, v64                                // 000000004630: D1CB0040 05025108
	v_fma_f32 v64, v12, v41, v64                               // 000000004638: D1CB0040 0502530C
	v_fma_f32 v64, v16, v42, v64                               // 000000004640: D1CB0040 05025510
	v_fma_f32 v64, v20, v43, v64                               // 000000004648: D1CB0040 05025714
	v_fma_f32 v65, v9, v40, v65                                // 000000004650: D1CB0041 05065109
	v_fma_f32 v65, v13, v41, v65                               // 000000004658: D1CB0041 0506530D
	v_fma_f32 v65, v17, v42, v65                               // 000000004660: D1CB0041 05065511
	v_fma_f32 v65, v21, v43, v65                               // 000000004668: D1CB0041 05065715
	v_fma_f32 v66, v10, v40, v66                               // 000000004670: D1CB0042 050A510A
	v_fma_f32 v66, v14, v41, v66                               // 000000004678: D1CB0042 050A530E
	v_fma_f32 v66, v18, v42, v66                               // 000000004680: D1CB0042 050A5512
	v_fma_f32 v66, v22, v43, v66                               // 000000004688: D1CB0042 050A5716
	v_fma_f32 v67, v11, v40, v67                               // 000000004690: D1CB0043 050E510B
	v_fma_f32 v67, v15, v41, v67                               // 000000004698: D1CB0043 050E530F
	v_fma_f32 v67, v19, v42, v67                               // 0000000046A0: D1CB0043 050E5513
	v_fma_f32 v67, v23, v43, v67                               // 0000000046A8: D1CB0043 050E5717
	s_waitcnt vmcnt(10)                                        // 0000000046B0: BF8C0F7A
	v_fma_f32 v68, v8, v44, v68                                // 0000000046B4: D1CB0044 05125908
	v_fma_f32 v68, v12, v45, v68                               // 0000000046BC: D1CB0044 05125B0C
	v_fma_f32 v68, v16, v46, v68                               // 0000000046C4: D1CB0044 05125D10
	v_fma_f32 v68, v20, v47, v68                               // 0000000046CC: D1CB0044 05125F14
	v_fma_f32 v69, v9, v44, v69                                // 0000000046D4: D1CB0045 05165909
	v_fma_f32 v69, v13, v45, v69                               // 0000000046DC: D1CB0045 05165B0D
	v_fma_f32 v69, v17, v46, v69                               // 0000000046E4: D1CB0045 05165D11
	v_fma_f32 v69, v21, v47, v69                               // 0000000046EC: D1CB0045 05165F15
	v_fma_f32 v70, v10, v44, v70                               // 0000000046F4: D1CB0046 051A590A
	v_fma_f32 v70, v14, v45, v70                               // 0000000046FC: D1CB0046 051A5B0E
	v_fma_f32 v70, v18, v46, v70                               // 000000004704: D1CB0046 051A5D12
	v_fma_f32 v70, v22, v47, v70                               // 00000000470C: D1CB0046 051A5F16
	v_fma_f32 v71, v11, v44, v71                               // 000000004714: D1CB0047 051E590B
	v_fma_f32 v71, v15, v45, v71                               // 00000000471C: D1CB0047 051E5B0F
	v_fma_f32 v71, v19, v46, v71                               // 000000004724: D1CB0047 051E5D13
	v_fma_f32 v71, v23, v47, v71                               // 00000000472C: D1CB0047 051E5F17
	s_waitcnt vmcnt(9)                                         // 000000004734: BF8C0F79
	v_fma_f32 v72, v8, v48, v72                                // 000000004738: D1CB0048 05226108
	v_fma_f32 v72, v12, v49, v72                               // 000000004740: D1CB0048 0522630C
	v_fma_f32 v72, v16, v50, v72                               // 000000004748: D1CB0048 05226510
	v_fma_f32 v72, v20, v51, v72                               // 000000004750: D1CB0048 05226714
	v_fma_f32 v73, v9, v48, v73                                // 000000004758: D1CB0049 05266109
	v_fma_f32 v73, v13, v49, v73                               // 000000004760: D1CB0049 0526630D
	v_fma_f32 v73, v17, v50, v73                               // 000000004768: D1CB0049 05266511
	v_fma_f32 v73, v21, v51, v73                               // 000000004770: D1CB0049 05266715
	v_fma_f32 v74, v10, v48, v74                               // 000000004778: D1CB004A 052A610A
	v_fma_f32 v74, v14, v49, v74                               // 000000004780: D1CB004A 052A630E
	v_fma_f32 v74, v18, v50, v74                               // 000000004788: D1CB004A 052A6512
	v_fma_f32 v74, v22, v51, v74                               // 000000004790: D1CB004A 052A6716
	v_fma_f32 v75, v11, v48, v75                               // 000000004798: D1CB004B 052E610B
	v_fma_f32 v75, v15, v49, v75                               // 0000000047A0: D1CB004B 052E630F
	v_fma_f32 v75, v19, v50, v75                               // 0000000047A8: D1CB004B 052E6513
	v_fma_f32 v75, v23, v51, v75                               // 0000000047B0: D1CB004B 052E6717
	s_waitcnt vmcnt(8)                                         // 0000000047B8: BF8C0F78
	v_fma_f32 v76, v8, v52, v76                                // 0000000047BC: D1CB004C 05326908
	v_fma_f32 v76, v12, v53, v76                               // 0000000047C4: D1CB004C 05326B0C
	v_fma_f32 v76, v16, v54, v76                               // 0000000047CC: D1CB004C 05326D10
	v_fma_f32 v76, v20, v55, v76                               // 0000000047D4: D1CB004C 05326F14
	v_fma_f32 v77, v9, v52, v77                                // 0000000047DC: D1CB004D 05366909
	v_fma_f32 v77, v13, v53, v77                               // 0000000047E4: D1CB004D 05366B0D
	v_fma_f32 v77, v17, v54, v77                               // 0000000047EC: D1CB004D 05366D11
	v_fma_f32 v77, v21, v55, v77                               // 0000000047F4: D1CB004D 05366F15
	v_fma_f32 v78, v10, v52, v78                               // 0000000047FC: D1CB004E 053A690A
	v_fma_f32 v78, v14, v53, v78                               // 000000004804: D1CB004E 053A6B0E
	v_fma_f32 v78, v18, v54, v78                               // 00000000480C: D1CB004E 053A6D12
	v_fma_f32 v78, v22, v55, v78                               // 000000004814: D1CB004E 053A6F16
	v_fma_f32 v79, v11, v52, v79                               // 00000000481C: D1CB004F 053E690B
	v_fma_f32 v79, v15, v53, v79                               // 000000004824: D1CB004F 053E6B0F
	v_fma_f32 v79, v19, v54, v79                               // 00000000482C: D1CB004F 053E6D13
	v_fma_f32 v79, v23, v55, v79                               // 000000004834: D1CB004F 053E6F17
	s_mov_b64 s[36:37], s[22:23]                               // 00000000483C: BEA40116
	global_load_dwordx4 v[8:11], v[2:3], s[20:21]              // 000000004840: DC5C8000 08140002
	s_add_u32 s20, s20, s33                                    // 000000004848: 80142114
	s_addc_u32 s21, s21, 0                                     // 00000000484C: 82158015
	global_load_dwordx4 v[12:15], v[2:3], s[20:21]             // 000000004850: DC5C8000 0C140002
	s_add_u32 s20, s20, s33                                    // 000000004858: 80142114
	s_addc_u32 s21, s21, 0                                     // 00000000485C: 82158015
	global_load_dwordx4 v[16:19], v[2:3], s[20:21]             // 000000004860: DC5C8000 10140002
	s_add_u32 s20, s20, s33                                    // 000000004868: 80142114
	s_addc_u32 s21, s21, 0                                     // 00000000486C: 82158015
	global_load_dwordx4 v[20:23], v[2:3], s[20:21]             // 000000004870: DC5C8000 14140002
	s_add_u32 s20, s20, s33                                    // 000000004878: 80142114
	s_addc_u32 s21, s21, 0                                     // 00000000487C: 82158015
	global_load_dwordx4 v[40:43], v[4:5], s[36:37]             // 000000004880: DC5C8000 28240004
	s_add_u32 s36, s36, s38                                    // 000000004888: 80242624
	s_addc_u32 s37, s37, 0                                     // 00000000488C: 82258025
	global_load_dwordx4 v[44:47], v[4:5], s[36:37]             // 000000004890: DC5C8000 2C240004
	s_add_u32 s36, s36, s38                                    // 000000004898: 80242624
	s_addc_u32 s37, s37, 0                                     // 00000000489C: 82258025
	global_load_dwordx4 v[48:51], v[4:5], s[36:37]             // 0000000048A0: DC5C8000 30240004
	s_add_u32 s36, s36, s38                                    // 0000000048A8: 80242624
	s_addc_u32 s37, s37, 0                                     // 0000000048AC: 82258025
	global_load_dwordx4 v[52:55], v[4:5], s[36:37]             // 0000000048B0: DC5C8000 34240004
	s_add_u32 s22, s22, 16                                     // 0000000048B8: 80169016
	s_addc_u32 s23, s23, 0                                     // 0000000048BC: 82178017
	s_waitcnt vmcnt(11)                                        // 0000000048C0: BF8C0F7B
	v_fma_f32 v64, v24, v56, v64                               // 0000000048C4: D1CB0040 05027118
	v_fma_f32 v64, v28, v57, v64                               // 0000000048CC: D1CB0040 0502731C
	v_fma_f32 v64, v32, v58, v64                               // 0000000048D4: D1CB0040 05027520
	v_fma_f32 v64, v36, v59, v64                               // 0000000048DC: D1CB0040 05027724
	v_fma_f32 v65, v25, v56, v65                               // 0000000048E4: D1CB0041 05067119
	v_fma_f32 v65, v29, v57, v65                               // 0000000048EC: D1CB0041 0506731D
	v_fma_f32 v65, v33, v58, v65                               // 0000000048F4: D1CB0041 05067521
	v_fma_f32 v65, v37, v59, v65                               // 0000000048FC: D1CB0041 05067725
	v_fma_f32 v66, v26, v56, v66                               // 000000004904: D1CB0042 050A711A
	v_fma_f32 v66, v30, v57, v66                               // 00000000490C: D1CB0042 050A731E
	v_fma_f32 v66, v34, v58, v66                               // 000000004914: D1CB0042 050A7522
	v_fma_f32 v66, v38, v59, v66                               // 00000000491C: D1CB0042 050A7726
	v_fma_f32 v67, v27, v56, v67                               // 000000004924: D1CB0043 050E711B
	v_fma_f32 v67, v31, v57, v67                               // 00000000492C: D1CB0043 050E731F
	v_fma_f32 v67, v35, v58, v67                               // 000000004934: D1CB0043 050E7523
	v_fma_f32 v67, v39, v59, v67                               // 00000000493C: D1CB0043 050E7727
	s_waitcnt vmcnt(10)                                        // 000000004944: BF8C0F7A
	v_fma_f32 v68, v24, v60, v68                               // 000000004948: D1CB0044 05127918
	v_fma_f32 v68, v28, v61, v68                               // 000000004950: D1CB0044 05127B1C
	v_fma_f32 v68, v32, v62, v68                               // 000000004958: D1CB0044 05127D20
	v_fma_f32 v68, v36, v63, v68                               // 000000004960: D1CB0044 05127F24
	v_fma_f32 v69, v25, v60, v69                               // 000000004968: D1CB0045 05167919
	v_fma_f32 v69, v29, v61, v69                               // 000000004970: D1CB0045 05167B1D
	v_fma_f32 v69, v33, v62, v69                               // 000000004978: D1CB0045 05167D21
	v_fma_f32 v69, v37, v63, v69                               // 000000004980: D1CB0045 05167F25
	v_fma_f32 v70, v26, v60, v70                               // 000000004988: D1CB0046 051A791A
	v_fma_f32 v70, v30, v61, v70                               // 000000004990: D1CB0046 051A7B1E
	v_fma_f32 v70, v34, v62, v70                               // 000000004998: D1CB0046 051A7D22
	v_fma_f32 v70, v38, v63, v70                               // 0000000049A0: D1CB0046 051A7F26
	v_fma_f32 v71, v27, v60, v71                               // 0000000049A8: D1CB0047 051E791B
	v_fma_f32 v71, v31, v61, v71                               // 0000000049B0: D1CB0047 051E7B1F
	v_fma_f32 v71, v35, v62, v71                               // 0000000049B8: D1CB0047 051E7D23
	v_fma_f32 v71, v39, v63, v71                               // 0000000049C0: D1CB0047 051E7F27
	s_waitcnt vmcnt(9)                                         // 0000000049C8: BF8C0F79
	v_fma_f32 v72, v24, v64, v72                               // 0000000049CC: D1CB0048 05228118
	v_fma_f32 v72, v28, v65, v72                               // 0000000049D4: D1CB0048 0522831C
	v_fma_f32 v72, v32, v66, v72                               // 0000000049DC: D1CB0048 05228520
	v_fma_f32 v72, v36, v67, v72                               // 0000000049E4: D1CB0048 05228724
	v_fma_f32 v73, v25, v64, v73                               // 0000000049EC: D1CB0049 05268119
	v_fma_f32 v73, v29, v65, v73                               // 0000000049F4: D1CB0049 0526831D
	v_fma_f32 v73, v33, v66, v73                               // 0000000049FC: D1CB0049 05268521
	v_fma_f32 v73, v37, v67, v73                               // 000000004A04: D1CB0049 05268725
	v_fma_f32 v74, v26, v64, v74                               // 000000004A0C: D1CB004A 052A811A
	v_fma_f32 v74, v30, v65, v74                               // 000000004A14: D1CB004A 052A831E
	v_fma_f32 v74, v34, v66, v74                               // 000000004A1C: D1CB004A 052A8522
	v_fma_f32 v74, v38, v67, v74                               // 000000004A24: D1CB004A 052A8726
	v_fma_f32 v75, v27, v64, v75                               // 000000004A2C: D1CB004B 052E811B
	v_fma_f32 v75, v31, v65, v75                               // 000000004A34: D1CB004B 052E831F
	v_fma_f32 v75, v35, v66, v75                               // 000000004A3C: D1CB004B 052E8523
	v_fma_f32 v75, v39, v67, v75                               // 000000004A44: D1CB004B 052E8727
	s_waitcnt vmcnt(8)                                         // 000000004A4C: BF8C0F78
	v_fma_f32 v76, v24, v68, v76                               // 000000004A50: D1CB004C 05328918
	v_fma_f32 v76, v28, v69, v76                               // 000000004A58: D1CB004C 05328B1C
	v_fma_f32 v76, v32, v70, v76                               // 000000004A60: D1CB004C 05328D20
	v_fma_f32 v76, v36, v71, v76                               // 000000004A68: D1CB004C 05328F24
	v_fma_f32 v77, v25, v68, v77                               // 000000004A70: D1CB004D 05368919
	v_fma_f32 v77, v29, v69, v77                               // 000000004A78: D1CB004D 05368B1D
	v_fma_f32 v77, v33, v70, v77                               // 000000004A80: D1CB004D 05368D21
	v_fma_f32 v77, v37, v71, v77                               // 000000004A88: D1CB004D 05368F25
	v_fma_f32 v78, v26, v68, v78                               // 000000004A90: D1CB004E 053A891A
	v_fma_f32 v78, v30, v69, v78                               // 000000004A98: D1CB004E 053A8B1E
	v_fma_f32 v78, v34, v70, v78                               // 000000004AA0: D1CB004E 053A8D22
	v_fma_f32 v78, v38, v71, v78                               // 000000004AA8: D1CB004E 053A8F26
	v_fma_f32 v79, v27, v68, v79                               // 000000004AB0: D1CB004F 053E891B
	v_fma_f32 v79, v31, v69, v79                               // 000000004AB8: D1CB004F 053E8B1F
	v_fma_f32 v79, v35, v70, v79                               // 000000004AC0: D1CB004F 053E8D23
	v_fma_f32 v79, v39, v71, v79                               // 000000004AC8: D1CB004F 053E8F27
	s_add_u32 s26, s26, 16                                     // 000000004AD0: 801A901A
	s_cmp_ge_u32 s26, s18                                      // 000000004AD4: BF09121A
    
    //s_branch     label_end 
	s_cbranch_scc0 label_major_loop_begin                      // 000000004AD8: BF84FD69
    
	s_mov_b64 s[36:37], s[22:23]                               // 000000004ADC: BEA40116
	global_load_dwordx4 v[24:27], v[2:3], s[20:21]             // 000000004AE0: DC5C8000 18140002
	s_add_u32 s20, s20, s33                                    // 000000004AE8: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000004AEC: 82158015
	global_load_dwordx4 v[28:31], v[2:3], s[20:21]             // 000000004AF0: DC5C8000 1C140002
	s_add_u32 s20, s20, s33                                    // 000000004AF8: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000004AFC: 82158015
	global_load_dwordx4 v[32:35], v[2:3], s[20:21]             // 000000004B00: DC5C8000 20140002
	s_add_u32 s20, s20, s33                                    // 000000004B08: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000004B0C: 82158015
	global_load_dwordx4 v[36:39], v[2:3], s[20:21]             // 000000004B10: DC5C8000 24140002
	s_add_u32 s20, s20, s33                                    // 000000004B18: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000004B1C: 82158015
	global_load_dwordx4 v[56:59], v[4:5], s[36:37]             // 000000004B20: DC5C8000 38240004
	s_add_u32 s36, s36, s38                                    // 000000004B28: 80242624
	s_addc_u32 s37, s37, 0                                     // 000000004B2C: 82258025
	global_load_dwordx4 v[60:63], v[4:5], s[36:37]             // 000000004B30: DC5C8000 3C240004
	s_add_u32 s36, s36, s38                                    // 000000004B38: 80242624
	s_addc_u32 s37, s37, 0                                     // 000000004B3C: 82258025
	global_load_dwordx4 v[64:67], v[4:5], s[36:37]             // 000000004B40: DC5C8000 40240004
	s_add_u32 s36, s36, s38                                    // 000000004B48: 80242624
	s_addc_u32 s37, s37, 0                                     // 000000004B4C: 82258025
	global_load_dwordx4 v[68:71], v[4:5], s[36:37]             // 000000004B50: DC5C8000 44240004
	s_add_u32 s22, s22, 16                                     // 000000004B58: 80169016
	s_addc_u32 s23, s23, 0                                     // 000000004B5C: 82178017
	s_waitcnt vmcnt(11)                                        // 000000004B60: BF8C0F7B
	v_fma_f32 v64, v8, v40, v64                                // 000000004B64: D1CB0040 05025108
	v_fma_f32 v64, v12, v41, v64                               // 000000004B6C: D1CB0040 0502530C
	v_fma_f32 v64, v16, v42, v64                               // 000000004B74: D1CB0040 05025510
	v_fma_f32 v64, v20, v43, v64                               // 000000004B7C: D1CB0040 05025714
	v_fma_f32 v65, v9, v40, v65                                // 000000004B84: D1CB0041 05065109
	v_fma_f32 v65, v13, v41, v65                               // 000000004B8C: D1CB0041 0506530D
	v_fma_f32 v65, v17, v42, v65                               // 000000004B94: D1CB0041 05065511
	v_fma_f32 v65, v21, v43, v65                               // 000000004B9C: D1CB0041 05065715
	v_fma_f32 v66, v10, v40, v66                               // 000000004BA4: D1CB0042 050A510A
	v_fma_f32 v66, v14, v41, v66                               // 000000004BAC: D1CB0042 050A530E
	v_fma_f32 v66, v18, v42, v66                               // 000000004BB4: D1CB0042 050A5512
	v_fma_f32 v66, v22, v43, v66                               // 000000004BBC: D1CB0042 050A5716
	v_fma_f32 v67, v11, v40, v67                               // 000000004BC4: D1CB0043 050E510B
	v_fma_f32 v67, v15, v41, v67                               // 000000004BCC: D1CB0043 050E530F
	v_fma_f32 v67, v19, v42, v67                               // 000000004BD4: D1CB0043 050E5513
	v_fma_f32 v67, v23, v43, v67                               // 000000004BDC: D1CB0043 050E5717
	s_waitcnt vmcnt(10)                                        // 000000004BE4: BF8C0F7A
	v_fma_f32 v68, v8, v44, v68                                // 000000004BE8: D1CB0044 05125908
	v_fma_f32 v68, v12, v45, v68                               // 000000004BF0: D1CB0044 05125B0C
	v_fma_f32 v68, v16, v46, v68                               // 000000004BF8: D1CB0044 05125D10
	v_fma_f32 v68, v20, v47, v68                               // 000000004C00: D1CB0044 05125F14
	v_fma_f32 v69, v9, v44, v69                                // 000000004C08: D1CB0045 05165909
	v_fma_f32 v69, v13, v45, v69                               // 000000004C10: D1CB0045 05165B0D
	v_fma_f32 v69, v17, v46, v69                               // 000000004C18: D1CB0045 05165D11
	v_fma_f32 v69, v21, v47, v69                               // 000000004C20: D1CB0045 05165F15
	v_fma_f32 v70, v10, v44, v70                               // 000000004C28: D1CB0046 051A590A
	v_fma_f32 v70, v14, v45, v70                               // 000000004C30: D1CB0046 051A5B0E
	v_fma_f32 v70, v18, v46, v70                               // 000000004C38: D1CB0046 051A5D12
	v_fma_f32 v70, v22, v47, v70                               // 000000004C40: D1CB0046 051A5F16
	v_fma_f32 v71, v11, v44, v71                               // 000000004C48: D1CB0047 051E590B
	v_fma_f32 v71, v15, v45, v71                               // 000000004C50: D1CB0047 051E5B0F
	v_fma_f32 v71, v19, v46, v71                               // 000000004C58: D1CB0047 051E5D13
	v_fma_f32 v71, v23, v47, v71                               // 000000004C60: D1CB0047 051E5F17
	s_waitcnt vmcnt(9)                                         // 000000004C68: BF8C0F79
	v_fma_f32 v72, v8, v48, v72                                // 000000004C6C: D1CB0048 05226108
	v_fma_f32 v72, v12, v49, v72                               // 000000004C74: D1CB0048 0522630C
	v_fma_f32 v72, v16, v50, v72                               // 000000004C7C: D1CB0048 05226510
	v_fma_f32 v72, v20, v51, v72                               // 000000004C84: D1CB0048 05226714
	v_fma_f32 v73, v9, v48, v73                                // 000000004C8C: D1CB0049 05266109
	v_fma_f32 v73, v13, v49, v73                               // 000000004C94: D1CB0049 0526630D
	v_fma_f32 v73, v17, v50, v73                               // 000000004C9C: D1CB0049 05266511
	v_fma_f32 v73, v21, v51, v73                               // 000000004CA4: D1CB0049 05266715
	v_fma_f32 v74, v10, v48, v74                               // 000000004CAC: D1CB004A 052A610A
	v_fma_f32 v74, v14, v49, v74                               // 000000004CB4: D1CB004A 052A630E
	v_fma_f32 v74, v18, v50, v74                               // 000000004CBC: D1CB004A 052A6512
	v_fma_f32 v74, v22, v51, v74                               // 000000004CC4: D1CB004A 052A6716
	v_fma_f32 v75, v11, v48, v75                               // 000000004CCC: D1CB004B 052E610B
	v_fma_f32 v75, v15, v49, v75                               // 000000004CD4: D1CB004B 052E630F
	v_fma_f32 v75, v19, v50, v75                               // 000000004CDC: D1CB004B 052E6513
	v_fma_f32 v75, v23, v51, v75                               // 000000004CE4: D1CB004B 052E6717
	s_waitcnt vmcnt(8)                                         // 000000004CEC: BF8C0F78
	v_fma_f32 v76, v8, v52, v76                                // 000000004CF0: D1CB004C 05326908
	v_fma_f32 v76, v12, v53, v76                               // 000000004CF8: D1CB004C 05326B0C
	v_fma_f32 v76, v16, v54, v76                               // 000000004D00: D1CB004C 05326D10
	v_fma_f32 v76, v20, v55, v76                               // 000000004D08: D1CB004C 05326F14
	v_fma_f32 v77, v9, v52, v77                                // 000000004D10: D1CB004D 05366909
	v_fma_f32 v77, v13, v53, v77                               // 000000004D18: D1CB004D 05366B0D
	v_fma_f32 v77, v17, v54, v77                               // 000000004D20: D1CB004D 05366D11
	v_fma_f32 v77, v21, v55, v77                               // 000000004D28: D1CB004D 05366F15
	v_fma_f32 v78, v10, v52, v78                               // 000000004D30: D1CB004E 053A690A
	v_fma_f32 v78, v14, v53, v78                               // 000000004D38: D1CB004E 053A6B0E
	v_fma_f32 v78, v18, v54, v78                               // 000000004D40: D1CB004E 053A6D12
	v_fma_f32 v78, v22, v55, v78                               // 000000004D48: D1CB004E 053A6F16
	v_fma_f32 v79, v11, v52, v79                               // 000000004D50: D1CB004F 053E690B
	v_fma_f32 v79, v15, v53, v79                               // 000000004D58: D1CB004F 053E6B0F
	v_fma_f32 v79, v19, v54, v79                               // 000000004D60: D1CB004F 053E6D13
	v_fma_f32 v79, v23, v55, v79                               // 000000004D68: D1CB004F 053E6F17
	s_mov_b64 s[36:37], s[22:23]                               // 000000004D70: BEA40116
	global_load_dwordx4 v[8:11], v[2:3], s[20:21]              // 000000004D74: DC5C8000 08140002
	s_add_u32 s20, s20, s33                                    // 000000004D7C: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000004D80: 82158015
	global_load_dwordx4 v[12:15], v[2:3], s[20:21]             // 000000004D84: DC5C8000 0C140002
	s_add_u32 s20, s20, s33                                    // 000000004D8C: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000004D90: 82158015
	global_load_dwordx4 v[16:19], v[2:3], s[20:21]             // 000000004D94: DC5C8000 10140002
	s_add_u32 s20, s20, s33                                    // 000000004D9C: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000004DA0: 82158015
	global_load_dwordx4 v[20:23], v[2:3], s[20:21]             // 000000004DA4: DC5C8000 14140002
	s_add_u32 s20, s20, s33                                    // 000000004DAC: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000004DB0: 82158015
	global_load_dwordx4 v[40:43], v[4:5], s[36:37]             // 000000004DB4: DC5C8000 28240004
	s_add_u32 s36, s36, s38                                    // 000000004DBC: 80242624
	s_addc_u32 s37, s37, 0                                     // 000000004DC0: 82258025
	global_load_dwordx4 v[44:47], v[4:5], s[36:37]             // 000000004DC4: DC5C8000 2C240004
	s_add_u32 s36, s36, s38                                    // 000000004DCC: 80242624
	s_addc_u32 s37, s37, 0                                     // 000000004DD0: 82258025
	global_load_dwordx4 v[48:51], v[4:5], s[36:37]             // 000000004DD4: DC5C8000 30240004
	s_add_u32 s36, s36, s38                                    // 000000004DDC: 80242624
	s_addc_u32 s37, s37, 0                                     // 000000004DE0: 82258025
	global_load_dwordx4 v[52:55], v[4:5], s[36:37]             // 000000004DE4: DC5C8000 34240004
	s_add_u32 s22, s22, 16                                     // 000000004DEC: 80169016
	s_addc_u32 s23, s23, 0                                     // 000000004DF0: 82178017
	s_waitcnt vmcnt(11)                                        // 000000004DF4: BF8C0F7B
	v_fma_f32 v64, v24, v56, v64                               // 000000004DF8: D1CB0040 05027118
	v_fma_f32 v64, v28, v57, v64                               // 000000004E00: D1CB0040 0502731C
	v_fma_f32 v64, v32, v58, v64                               // 000000004E08: D1CB0040 05027520
	v_fma_f32 v64, v36, v59, v64                               // 000000004E10: D1CB0040 05027724
	v_fma_f32 v65, v25, v56, v65                               // 000000004E18: D1CB0041 05067119
	v_fma_f32 v65, v29, v57, v65                               // 000000004E20: D1CB0041 0506731D
	v_fma_f32 v65, v33, v58, v65                               // 000000004E28: D1CB0041 05067521
	v_fma_f32 v65, v37, v59, v65                               // 000000004E30: D1CB0041 05067725
	v_fma_f32 v66, v26, v56, v66                               // 000000004E38: D1CB0042 050A711A
	v_fma_f32 v66, v30, v57, v66                               // 000000004E40: D1CB0042 050A731E
	v_fma_f32 v66, v34, v58, v66                               // 000000004E48: D1CB0042 050A7522
	v_fma_f32 v66, v38, v59, v66                               // 000000004E50: D1CB0042 050A7726
	v_fma_f32 v67, v27, v56, v67                               // 000000004E58: D1CB0043 050E711B
	v_fma_f32 v67, v31, v57, v67                               // 000000004E60: D1CB0043 050E731F
	v_fma_f32 v67, v35, v58, v67                               // 000000004E68: D1CB0043 050E7523
	v_fma_f32 v67, v39, v59, v67                               // 000000004E70: D1CB0043 050E7727
	s_waitcnt vmcnt(10)                                        // 000000004E78: BF8C0F7A
	v_fma_f32 v68, v24, v60, v68                               // 000000004E7C: D1CB0044 05127918
	v_fma_f32 v68, v28, v61, v68                               // 000000004E84: D1CB0044 05127B1C
	v_fma_f32 v68, v32, v62, v68                               // 000000004E8C: D1CB0044 05127D20
	v_fma_f32 v68, v36, v63, v68                               // 000000004E94: D1CB0044 05127F24
	v_fma_f32 v69, v25, v60, v69                               // 000000004E9C: D1CB0045 05167919
	v_fma_f32 v69, v29, v61, v69                               // 000000004EA4: D1CB0045 05167B1D
	v_fma_f32 v69, v33, v62, v69                               // 000000004EAC: D1CB0045 05167D21
	v_fma_f32 v69, v37, v63, v69                               // 000000004EB4: D1CB0045 05167F25
	v_fma_f32 v70, v26, v60, v70                               // 000000004EBC: D1CB0046 051A791A
	v_fma_f32 v70, v30, v61, v70                               // 000000004EC4: D1CB0046 051A7B1E
	v_fma_f32 v70, v34, v62, v70                               // 000000004ECC: D1CB0046 051A7D22
	v_fma_f32 v70, v38, v63, v70                               // 000000004ED4: D1CB0046 051A7F26
	v_fma_f32 v71, v27, v60, v71                               // 000000004EDC: D1CB0047 051E791B
	v_fma_f32 v71, v31, v61, v71                               // 000000004EE4: D1CB0047 051E7B1F
	v_fma_f32 v71, v35, v62, v71                               // 000000004EEC: D1CB0047 051E7D23
	v_fma_f32 v71, v39, v63, v71                               // 000000004EF4: D1CB0047 051E7F27
	s_waitcnt vmcnt(9)                                         // 000000004EFC: BF8C0F79
	v_fma_f32 v72, v24, v64, v72                               // 000000004F00: D1CB0048 05228118
	v_fma_f32 v72, v28, v65, v72                               // 000000004F08: D1CB0048 0522831C
	v_fma_f32 v72, v32, v66, v72                               // 000000004F10: D1CB0048 05228520
	v_fma_f32 v72, v36, v67, v72                               // 000000004F18: D1CB0048 05228724
	v_fma_f32 v73, v25, v64, v73                               // 000000004F20: D1CB0049 05268119
	v_fma_f32 v73, v29, v65, v73                               // 000000004F28: D1CB0049 0526831D
	v_fma_f32 v73, v33, v66, v73                               // 000000004F30: D1CB0049 05268521
	v_fma_f32 v73, v37, v67, v73                               // 000000004F38: D1CB0049 05268725
	v_fma_f32 v74, v26, v64, v74                               // 000000004F40: D1CB004A 052A811A
	v_fma_f32 v74, v30, v65, v74                               // 000000004F48: D1CB004A 052A831E
	v_fma_f32 v74, v34, v66, v74                               // 000000004F50: D1CB004A 052A8522
	v_fma_f32 v74, v38, v67, v74                               // 000000004F58: D1CB004A 052A8726
	v_fma_f32 v75, v27, v64, v75                               // 000000004F60: D1CB004B 052E811B
	v_fma_f32 v75, v31, v65, v75                               // 000000004F68: D1CB004B 052E831F
	v_fma_f32 v75, v35, v66, v75                               // 000000004F70: D1CB004B 052E8523
	v_fma_f32 v75, v39, v67, v75                               // 000000004F78: D1CB004B 052E8727
	s_waitcnt vmcnt(8)                                         // 000000004F80: BF8C0F78
	v_fma_f32 v76, v24, v68, v76                               // 000000004F84: D1CB004C 05328918
	v_fma_f32 v76, v28, v69, v76                               // 000000004F8C: D1CB004C 05328B1C
	v_fma_f32 v76, v32, v70, v76                               // 000000004F94: D1CB004C 05328D20
	v_fma_f32 v76, v36, v71, v76                               // 000000004F9C: D1CB004C 05328F24
	v_fma_f32 v77, v25, v68, v77                               // 000000004FA4: D1CB004D 05368919
	v_fma_f32 v77, v29, v69, v77                               // 000000004FAC: D1CB004D 05368B1D
	v_fma_f32 v77, v33, v70, v77                               // 000000004FB4: D1CB004D 05368D21
	v_fma_f32 v77, v37, v71, v77                               // 000000004FBC: D1CB004D 05368F25
	v_fma_f32 v78, v26, v68, v78                               // 000000004FC4: D1CB004E 053A891A
	v_fma_f32 v78, v30, v69, v78                               // 000000004FCC: D1CB004E 053A8B1E
	v_fma_f32 v78, v34, v70, v78                               // 000000004FD4: D1CB004E 053A8D22
	v_fma_f32 v78, v38, v71, v78                               // 000000004FDC: D1CB004E 053A8F26
	v_fma_f32 v79, v27, v68, v79                               // 000000004FE4: D1CB004F 053E891B
	v_fma_f32 v79, v31, v69, v79                               // 000000004FEC: D1CB004F 053E8B1F
	v_fma_f32 v79, v35, v70, v79                               // 000000004FF4: D1CB004F 053E8D23
	v_fma_f32 v79, v39, v71, v79                               // 000000004FFC: D1CB004F 053E8F27
	s_mov_b64 s[36:37], s[22:23]                               // 000000005004: BEA40116
	global_load_dwordx4 v[24:27], v[2:3], s[20:21]             // 000000005008: DC5C8000 18140002
	s_add_u32 s20, s20, s33                                    // 000000005010: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000005014: 82158015
	global_load_dwordx4 v[28:31], v[2:3], s[20:21]             // 000000005018: DC5C8000 1C140002
	s_add_u32 s20, s20, s33                                    // 000000005020: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000005024: 82158015
	global_load_dwordx4 v[32:35], v[2:3], s[20:21]             // 000000005028: DC5C8000 20140002
	s_add_u32 s20, s20, s33                                    // 000000005030: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000005034: 82158015
	global_load_dwordx4 v[36:39], v[2:3], s[20:21]             // 000000005038: DC5C8000 24140002
	s_add_u32 s20, s20, s33                                    // 000000005040: 80142114
	s_addc_u32 s21, s21, 0                                     // 000000005044: 82158015
	global_load_dwordx4 v[56:59], v[4:5], s[36:37]             // 000000005048: DC5C8000 38240004
	s_add_u32 s36, s36, s38                                    // 000000005050: 80242624
	s_addc_u32 s37, s37, 0                                     // 000000005054: 82258025
	global_load_dwordx4 v[60:63], v[4:5], s[36:37]             // 000000005058: DC5C8000 3C240004
	s_add_u32 s36, s36, s38                                    // 000000005060: 80242624
	s_addc_u32 s37, s37, 0                                     // 000000005064: 82258025
	global_load_dwordx4 v[64:67], v[4:5], s[36:37]             // 000000005068: DC5C8000 40240004
	s_add_u32 s36, s36, s38                                    // 000000005070: 80242624
	s_addc_u32 s37, s37, 0                                     // 000000005074: 82258025
	global_load_dwordx4 v[68:71], v[4:5], s[36:37]             // 000000005078: DC5C8000 44240004
	s_add_u32 s22, s22, 16                                     // 000000005080: 80169016
	s_addc_u32 s23, s23, 0                                     // 000000005084: 82178017
	s_waitcnt vmcnt(11)                                        // 000000005088: BF8C0F7B
	v_fma_f32 v64, v8, v40, v64                                // 00000000508C: D1CB0040 05025108
	v_fma_f32 v64, v12, v41, v64                               // 000000005094: D1CB0040 0502530C
	v_fma_f32 v64, v16, v42, v64                               // 00000000509C: D1CB0040 05025510
	v_fma_f32 v64, v20, v43, v64                               // 0000000050A4: D1CB0040 05025714
	v_fma_f32 v65, v9, v40, v65                                // 0000000050AC: D1CB0041 05065109
	v_fma_f32 v65, v13, v41, v65                               // 0000000050B4: D1CB0041 0506530D
	v_fma_f32 v65, v17, v42, v65                               // 0000000050BC: D1CB0041 05065511
	v_fma_f32 v65, v21, v43, v65                               // 0000000050C4: D1CB0041 05065715
	v_fma_f32 v66, v10, v40, v66                               // 0000000050CC: D1CB0042 050A510A
	v_fma_f32 v66, v14, v41, v66                               // 0000000050D4: D1CB0042 050A530E
	v_fma_f32 v66, v18, v42, v66                               // 0000000050DC: D1CB0042 050A5512
	v_fma_f32 v66, v22, v43, v66                               // 0000000050E4: D1CB0042 050A5716
	v_fma_f32 v67, v11, v40, v67                               // 0000000050EC: D1CB0043 050E510B
	v_fma_f32 v67, v15, v41, v67                               // 0000000050F4: D1CB0043 050E530F
	v_fma_f32 v67, v19, v42, v67                               // 0000000050FC: D1CB0043 050E5513
	v_fma_f32 v67, v23, v43, v67                               // 000000005104: D1CB0043 050E5717
	s_waitcnt vmcnt(10)                                        // 00000000510C: BF8C0F7A
	v_fma_f32 v68, v8, v44, v68                                // 000000005110: D1CB0044 05125908
	v_fma_f32 v68, v12, v45, v68                               // 000000005118: D1CB0044 05125B0C
	v_fma_f32 v68, v16, v46, v68                               // 000000005120: D1CB0044 05125D10
	v_fma_f32 v68, v20, v47, v68                               // 000000005128: D1CB0044 05125F14
	v_fma_f32 v69, v9, v44, v69                                // 000000005130: D1CB0045 05165909
	v_fma_f32 v69, v13, v45, v69                               // 000000005138: D1CB0045 05165B0D
	v_fma_f32 v69, v17, v46, v69                               // 000000005140: D1CB0045 05165D11
	v_fma_f32 v69, v21, v47, v69                               // 000000005148: D1CB0045 05165F15
	v_fma_f32 v70, v10, v44, v70                               // 000000005150: D1CB0046 051A590A
	v_fma_f32 v70, v14, v45, v70                               // 000000005158: D1CB0046 051A5B0E
	v_fma_f32 v70, v18, v46, v70                               // 000000005160: D1CB0046 051A5D12
	v_fma_f32 v70, v22, v47, v70                               // 000000005168: D1CB0046 051A5F16
	v_fma_f32 v71, v11, v44, v71                               // 000000005170: D1CB0047 051E590B
	v_fma_f32 v71, v15, v45, v71                               // 000000005178: D1CB0047 051E5B0F
	v_fma_f32 v71, v19, v46, v71                               // 000000005180: D1CB0047 051E5D13
	v_fma_f32 v71, v23, v47, v71                               // 000000005188: D1CB0047 051E5F17
	s_waitcnt vmcnt(9)                                         // 000000005190: BF8C0F79
	v_fma_f32 v72, v8, v48, v72                                // 000000005194: D1CB0048 05226108
	v_fma_f32 v72, v12, v49, v72                               // 00000000519C: D1CB0048 0522630C
	v_fma_f32 v72, v16, v50, v72                               // 0000000051A4: D1CB0048 05226510
	v_fma_f32 v72, v20, v51, v72                               // 0000000051AC: D1CB0048 05226714
	v_fma_f32 v73, v9, v48, v73                                // 0000000051B4: D1CB0049 05266109
	v_fma_f32 v73, v13, v49, v73                               // 0000000051BC: D1CB0049 0526630D
	v_fma_f32 v73, v17, v50, v73                               // 0000000051C4: D1CB0049 05266511
	v_fma_f32 v73, v21, v51, v73                               // 0000000051CC: D1CB0049 05266715
	v_fma_f32 v74, v10, v48, v74                               // 0000000051D4: D1CB004A 052A610A
	v_fma_f32 v74, v14, v49, v74                               // 0000000051DC: D1CB004A 052A630E
	v_fma_f32 v74, v18, v50, v74                               // 0000000051E4: D1CB004A 052A6512
	v_fma_f32 v74, v22, v51, v74                               // 0000000051EC: D1CB004A 052A6716
	v_fma_f32 v75, v11, v48, v75                               // 0000000051F4: D1CB004B 052E610B
	v_fma_f32 v75, v15, v49, v75                               // 0000000051FC: D1CB004B 052E630F
	v_fma_f32 v75, v19, v50, v75                               // 000000005204: D1CB004B 052E6513
	v_fma_f32 v75, v23, v51, v75                               // 00000000520C: D1CB004B 052E6717
	s_waitcnt vmcnt(8)                                         // 000000005214: BF8C0F78
	v_fma_f32 v76, v8, v52, v76                                // 000000005218: D1CB004C 05326908
	v_fma_f32 v76, v12, v53, v76                               // 000000005220: D1CB004C 05326B0C
	v_fma_f32 v76, v16, v54, v76                               // 000000005228: D1CB004C 05326D10
	v_fma_f32 v76, v20, v55, v76                               // 000000005230: D1CB004C 05326F14
	v_fma_f32 v77, v9, v52, v77                                // 000000005238: D1CB004D 05366909
	v_fma_f32 v77, v13, v53, v77                               // 000000005240: D1CB004D 05366B0D
	v_fma_f32 v77, v17, v54, v77                               // 000000005248: D1CB004D 05366D11
	v_fma_f32 v77, v21, v55, v77                               // 000000005250: D1CB004D 05366F15
	v_fma_f32 v78, v10, v52, v78                               // 000000005258: D1CB004E 053A690A
	v_fma_f32 v78, v14, v53, v78                               // 000000005260: D1CB004E 053A6B0E
	v_fma_f32 v78, v18, v54, v78                               // 000000005268: D1CB004E 053A6D12
	v_fma_f32 v78, v22, v55, v78                               // 000000005270: D1CB004E 053A6F16
	v_fma_f32 v79, v11, v52, v79                               // 000000005278: D1CB004F 053E690B
	v_fma_f32 v79, v15, v53, v79                               // 000000005280: D1CB004F 053E6B0F
	v_fma_f32 v79, v19, v54, v79                               // 000000005288: D1CB004F 053E6D13
	v_fma_f32 v79, v23, v55, v79                               // 000000005290: D1CB004F 053E6F17
	s_waitcnt vmcnt(3)                                         // 000000005298: BF8C0F73
	v_fma_f32 v64, v24, v56, v64                               // 00000000529C: D1CB0040 05027118
	v_fma_f32 v64, v28, v57, v64                               // 0000000052A4: D1CB0040 0502731C
	v_fma_f32 v64, v32, v58, v64                               // 0000000052AC: D1CB0040 05027520
	v_fma_f32 v64, v36, v59, v64                               // 0000000052B4: D1CB0040 05027724
	v_fma_f32 v65, v25, v56, v65                               // 0000000052BC: D1CB0041 05067119
	v_fma_f32 v65, v29, v57, v65                               // 0000000052C4: D1CB0041 0506731D
	v_fma_f32 v65, v33, v58, v65                               // 0000000052CC: D1CB0041 05067521
	v_fma_f32 v65, v37, v59, v65                               // 0000000052D4: D1CB0041 05067725
	v_fma_f32 v66, v26, v56, v66                               // 0000000052DC: D1CB0042 050A711A
	v_fma_f32 v66, v30, v57, v66                               // 0000000052E4: D1CB0042 050A731E
	v_fma_f32 v66, v34, v58, v66                               // 0000000052EC: D1CB0042 050A7522
	v_fma_f32 v66, v38, v59, v66                               // 0000000052F4: D1CB0042 050A7726
	v_fma_f32 v67, v27, v56, v67                               // 0000000052FC: D1CB0043 050E711B
	v_fma_f32 v67, v31, v57, v67                               // 000000005304: D1CB0043 050E731F
	v_fma_f32 v67, v35, v58, v67                               // 00000000530C: D1CB0043 050E7523
	v_fma_f32 v67, v39, v59, v67                               // 000000005314: D1CB0043 050E7727
	s_waitcnt vmcnt(2)                                         // 00000000531C: BF8C0F72
	v_fma_f32 v68, v24, v60, v68                               // 000000005320: D1CB0044 05127918
	v_fma_f32 v68, v28, v61, v68                               // 000000005328: D1CB0044 05127B1C
	v_fma_f32 v68, v32, v62, v68                               // 000000005330: D1CB0044 05127D20
	v_fma_f32 v68, v36, v63, v68                               // 000000005338: D1CB0044 05127F24
	v_fma_f32 v69, v25, v60, v69                               // 000000005340: D1CB0045 05167919
	v_fma_f32 v69, v29, v61, v69                               // 000000005348: D1CB0045 05167B1D
	v_fma_f32 v69, v33, v62, v69                               // 000000005350: D1CB0045 05167D21
	v_fma_f32 v69, v37, v63, v69                               // 000000005358: D1CB0045 05167F25
	v_fma_f32 v70, v26, v60, v70                               // 000000005360: D1CB0046 051A791A
	v_fma_f32 v70, v30, v61, v70                               // 000000005368: D1CB0046 051A7B1E
	v_fma_f32 v70, v34, v62, v70                               // 000000005370: D1CB0046 051A7D22
	v_fma_f32 v70, v38, v63, v70                               // 000000005378: D1CB0046 051A7F26
	v_fma_f32 v71, v27, v60, v71                               // 000000005380: D1CB0047 051E791B
	v_fma_f32 v71, v31, v61, v71                               // 000000005388: D1CB0047 051E7B1F
	v_fma_f32 v71, v35, v62, v71                               // 000000005390: D1CB0047 051E7D23
	v_fma_f32 v71, v39, v63, v71                               // 000000005398: D1CB0047 051E7F27
	s_waitcnt vmcnt(1)                                         // 0000000053A0: BF8C0F71
	v_fma_f32 v72, v24, v64, v72                               // 0000000053A4: D1CB0048 05228118
	v_fma_f32 v72, v28, v65, v72                               // 0000000053AC: D1CB0048 0522831C
	v_fma_f32 v72, v32, v66, v72                               // 0000000053B4: D1CB0048 05228520
	v_fma_f32 v72, v36, v67, v72                               // 0000000053BC: D1CB0048 05228724
	v_fma_f32 v73, v25, v64, v73                               // 0000000053C4: D1CB0049 05268119
	v_fma_f32 v73, v29, v65, v73                               // 0000000053CC: D1CB0049 0526831D
	v_fma_f32 v73, v33, v66, v73                               // 0000000053D4: D1CB0049 05268521
	v_fma_f32 v73, v37, v67, v73                               // 0000000053DC: D1CB0049 05268725
	v_fma_f32 v74, v26, v64, v74                               // 0000000053E4: D1CB004A 052A811A
	v_fma_f32 v74, v30, v65, v74                               // 0000000053EC: D1CB004A 052A831E
	v_fma_f32 v74, v34, v66, v74                               // 0000000053F4: D1CB004A 052A8522
	v_fma_f32 v74, v38, v67, v74                               // 0000000053FC: D1CB004A 052A8726
	v_fma_f32 v75, v27, v64, v75                               // 000000005404: D1CB004B 052E811B
	v_fma_f32 v75, v31, v65, v75                               // 00000000540C: D1CB004B 052E831F
	v_fma_f32 v75, v35, v66, v75                               // 000000005414: D1CB004B 052E8523
	v_fma_f32 v75, v39, v67, v75                               // 00000000541C: D1CB004B 052E8727
	s_waitcnt vmcnt(0)                                         // 000000005424: BF8C0F70
	v_fma_f32 v76, v24, v68, v76                               // 000000005428: D1CB004C 05328918
	v_fma_f32 v76, v28, v69, v76                               // 000000005430: D1CB004C 05328B1C
	v_fma_f32 v76, v32, v70, v76                               // 000000005438: D1CB004C 05328D20
	v_fma_f32 v76, v36, v71, v76                               // 000000005440: D1CB004C 05328F24
	v_fma_f32 v77, v25, v68, v77                               // 000000005448: D1CB004D 05368919
	v_fma_f32 v77, v29, v69, v77                               // 000000005450: D1CB004D 05368B1D
	v_fma_f32 v77, v33, v70, v77                               // 000000005458: D1CB004D 05368D21
	v_fma_f32 v77, v37, v71, v77                               // 000000005460: D1CB004D 05368F25
	v_fma_f32 v78, v26, v68, v78                               // 000000005468: D1CB004E 053A891A
	v_fma_f32 v78, v30, v69, v78                               // 000000005470: D1CB004E 053A8B1E
	v_fma_f32 v78, v34, v70, v78                               // 000000005478: D1CB004E 053A8D22
	v_fma_f32 v78, v38, v71, v78                               // 000000005480: D1CB004E 053A8F26
	v_fma_f32 v79, v27, v68, v79                               // 000000005488: D1CB004F 053E891B
	v_fma_f32 v79, v31, v69, v79                               // 000000005490: D1CB004F 053E8B1F
	v_fma_f32 v79, v35, v70, v79                               // 000000005498: D1CB004F 053E8D23
	v_fma_f32 v79, v39, v71, v79                               // 0000000054A0: D1CB004F 053E8F27
	v_lshlrev_b32_e32 v2, 2, v0                                // 0000000054A8: 24040082
	ds_write_b32 v2, v64                                       // 0000000054AC: D81A0000 00004002
	ds_write_b32 v2, v65 offset:1024                           // 0000000054B4: D81A0400 00004102
	ds_write_b32 v2, v66 offset:2048                           // 0000000054BC: D81A0800 00004202
	ds_write_b32 v2, v67 offset:3072                           // 0000000054C4: D81A0C00 00004302
	ds_write_b32 v2, v68 offset:4096                           // 0000000054CC: D81A1000 00004402
	ds_write_b32 v2, v69 offset:5120                           // 0000000054D4: D81A1400 00004502
	ds_write_b32 v2, v70 offset:6144                           // 0000000054DC: D81A1800 00004602
	ds_write_b32 v2, v71 offset:7168                           // 0000000054E4: D81A1C00 00004702
	ds_write_b32 v2, v72 offset:8192                           // 0000000054EC: D81A2000 00004802
	ds_write_b32 v2, v73 offset:9216                           // 0000000054F4: D81A2400 00004902
	ds_write_b32 v2, v74 offset:10240                          // 0000000054FC: D81A2800 00004A02
	ds_write_b32 v2, v75 offset:11264                          // 000000005504: D81A2C00 00004B02
	ds_write_b32 v2, v76 offset:12288                          // 00000000550C: D81A3000 00004C02
	ds_write_b32 v2, v77 offset:13312                          // 000000005514: D81A3400 00004D02
	ds_write_b32 v2, v78 offset:14336                          // 00000000551C: D81A3800 00004E02
	ds_write_b32 v2, v79 offset:15360                          // 000000005524: D81A3C00 00004F02
	s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)                    // 00000000552C: BF8C0000
	s_barrier                                                  // 000000005530: BF8A0000
	v_lshlrev_b32_e32 v2, 2, v0                                // 000000005534: 24040082
	v_and_b32_e32 v2, 0xff, v2                                 // 000000005538: 260404FF 000000FF
	v_lshrrev_b32_e32 v3, 6, v0                                // 000000005540: 20060086
	v_lshlrev_b32_e32 v3, 12, v0                               // 000000005544: 2406008C
	v_add_u32_e32 v2, v2, v3                                   // 000000005548: 68040702
	ds_read_b32 v8, v2                                         // 00000000554C: D86C0000 08000002
	ds_read_b32 v9, v2 offset:256                              // 000000005554: D86C0100 09000002
	ds_read_b32 v10, v2 offset:512                             // 00000000555C: D86C0200 0A000002
	ds_read_b32 v11, v2 offset:512                             // 000000005564: D86C0200 0B000002
	ds_read_b32 v12, v2 offset:1024                            // 00000000556C: D86C0400 0C000002
	ds_read_b32 v13, v2 offset:1280                            // 000000005574: D86C0500 0D000002
	ds_read_b32 v14, v2 offset:1536                            // 00000000557C: D86C0600 0E000002
	ds_read_b32 v15, v2 offset:1536                            // 000000005584: D86C0600 0F000002
	ds_read_b32 v16, v2 offset:2048                            // 00000000558C: D86C0800 10000002
	ds_read_b32 v17, v2 offset:2304                            // 000000005594: D86C0900 11000002
	ds_read_b32 v18, v2 offset:2560                            // 00000000559C: D86C0A00 12000002
	ds_read_b32 v19, v2 offset:2560                            // 0000000055A4: D86C0A00 13000002
	ds_read_b32 v20, v2 offset:3072                            // 0000000055AC: D86C0C00 14000002
	ds_read_b32 v21, v2 offset:3328                            // 0000000055B4: D86C0D00 15000002
	ds_read_b32 v22, v2 offset:3584                            // 0000000055BC: D86C0E00 16000002
	ds_read_b32 v23, v2 offset:3584                            // 0000000055C4: D86C0E00 17000002
	v_lshrrev_b32_e32 v3, 6, v0                                // 0000000055CC: 20060086
	v_readfirstlane_b32 s31, v3                                // 0000000055D0: 7E3E0503
	s_add_u32 s28, s28, s31                                    // 0000000055D4: 801C1F1C
	s_mul_i32 s28, s28, s33                                    // 0000000055D8: 921C211C
	s_add_u32 s12, s12, s33                                    // 0000000055DC: 800C210C
	s_addc_u32 s13, 0, s13                                     // 0000000055E0: 820D0D80
	v_mul_u32_u24_e32 v6, s27, v80                             // 0000000055E4: 100CA01B
	v_lshlrev_b32_e32 v6, 2, v6                                // 0000000055E8: 240C0C82
	v_mov_b32_e32 v7, 0                                        // 0000000055EC: 7E0E0280
	s_waitcnt lgkmcnt(12)                                      // 0000000055F0: BF8CCC7F
	v_add_f32_e32 v64, v8, v9                                  // 0000000055F4: 02801308
	v_add_f32_e32 v64, v64, v10                                // 0000000055F8: 02801540
	v_add_f32_e32 v64, v64, v11                                // 0000000055FC: 02801740
	s_waitcnt lgkmcnt(8)                                       // 000000005600: BF8CC87F
	v_add_f32_e32 v65, v12, v13                                // 000000005604: 02821B0C
	v_add_f32_e32 v65, v65, v14                                // 000000005608: 02821D41
	v_add_f32_e32 v65, v65, v15                                // 00000000560C: 02821F41
	s_waitcnt lgkmcnt(4)                                       // 000000005610: BF8CC47F
	v_add_f32_e32 v66, v12, v13                                // 000000005614: 02841B0C
	v_add_f32_e32 v66, v66, v14                                // 000000005618: 02841D42
	v_add_f32_e32 v66, v66, v15                                // 00000000561C: 02841F42
	s_waitcnt lgkmcnt(0)                                       // 000000005620: BF8CC07F
	v_add_f32_e32 v67, v12, v13                                // 000000005624: 02861B0C
	v_add_f32_e32 v67, v67, v14                                // 000000005628: 02861D43
	v_add_f32_e32 v67, v67, v15                                // 00000000562C: 02861F43
	s_mov_b32 s32, s8                                          // 000000005630: BEA00008
	global_store_dwordx4 v[6:7], v[64:67], s[12:13]            // 000000005634: DC7C8000 000C4006
label_end:
	s_endpgm                                                   // 00000000563C: BF810000
    
