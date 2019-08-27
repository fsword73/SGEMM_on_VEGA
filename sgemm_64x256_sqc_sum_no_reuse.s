.hsa_code_object_version 2,1
.hsa_code_object_isa 9,0,6,"AMD","AMDGPU"


.p2align 8

.amdgpu_hsa_kernel sgemm_sqc

sgemm_sqc:
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
		workgroup_group_segment_byte_size = 0
		gds_segment_byte_size = 0
		kernarg_segment_byte_size = 68
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

	//64x256 kernel 

	
	

	s_load_dwordx2 s[12:13], s[4:5], 0x8                       // 000000002300: C0060302 00000008 
	s_load_dwordx2 s[14:15], s[4:5], 0x10                      // 000000002308: C0060382 00000010 
	s_load_dword s8, s[4:5], 0x20                              // 000000002310: C0020202 00000020 
	s_load_dword s9, s[4:5], 0x24                              // 000000002318: C0020242 00000024 
	s_load_dword s10, s[4:5], 0x28                             // 000000002320: C0020282 00000028 
	s_load_dword s26, s[4:5], 0x2c                             // 000000002328: C0020682 0000002C 
	s_load_dword s27, s[4:5], 0x30                             // 000000002330: C00206C2 00000030 
	s_lshl_b32 s22, s7, 6                                      // 000000002338: 8E168607 
	s_mov_b32 s23, 0                                           // 00000000233C: BE970080 
	v_mov_b32_e32 v2, v0                                       // 000000002340: 7E040300 
	v_mov_b32_e32 v3, 0                                        // 000000002344: 7E060280 
	s_lshl_b32 s24, s6, 8                                      // 000000002348: 8E188806 
	s_mov_b32 s16, 0                                           // 00000000234C: BE900080 
	s_mov_b32 s17, 0                                           // 000000002350: BE910080 
	s_mov_b32 s18, 0                                           // 000000002354: BE920080 
	s_mov_b32 s19, 0                                           // 000000002358: BE930080 
	s_mov_b32 s20, 0                                           // 00000000235C: BE940080 
	s_mov_b32 s21, 0                                           // 000000002360: BE950080 
	v_mov_b32_e32 v4, 0                                        // 000000002364: 7E080280 
	v_mov_b32_e32 v5, 0                                        // 000000002368: 7E0A0280 
	v_mov_b32_e32 v6, 0                                        // 00000000236C: 7E0C0280 
	v_mov_b32_e32 v7, 0                                        // 000000002370: 7E0E0280 
	v_mov_b32_e32 v8, 0                                        // 000000002374: 7E100280 
	v_mov_b32_e32 v9, 0                                        // 000000002378: 7E120280 
	v_mov_b32_e32 v10, 0                                       // 00000000237C: 7E140280 
	v_mov_b32_e32 v11, 0                                       // 000000002380: 7E160280 
	v_mov_b32_e32 v12, 0                                       // 000000002384: 7E180280 
	v_mov_b32_e32 v13, 0                                       // 000000002388: 7E1A0280 
	v_mov_b32_e32 v14, 0                                       // 00000000238C: 7E1C0280 
	v_mov_b32_e32 v15, 0                                       // 000000002390: 7E1E0280 
	v_mov_b32_e32 v16, 0                                       // 000000002394: 7E200280 
	v_mov_b32_e32 v17, 0                                       // 000000002398: 7E220280 
	v_mov_b32_e32 v18, 0                                       // 00000000239C: 7E240280 
	v_mov_b32_e32 v19, 0                                       // 0000000023A0: 7E260280 
	v_mov_b32_e32 v20, 0                                       // 0000000023A4: 7E280280 
	v_mov_b32_e32 v21, 0                                       // 0000000023A8: 7E2A0280 
	v_mov_b32_e32 v22, 0                                       // 0000000023AC: 7E2C0280 
	v_mov_b32_e32 v23, 0                                       // 0000000023B0: 7E2E0280 
	v_mov_b32_e32 v24, 0                                       // 0000000023B4: 7E300280 
	v_mov_b32_e32 v25, 0                                       // 0000000023B8: 7E320280 
	v_mov_b32_e32 v26, 0                                       // 0000000023BC: 7E340280 
	v_mov_b32_e32 v27, 0                                       // 0000000023C0: 7E360280 
	v_mov_b32_e32 v28, 0                                       // 0000000023C4: 7E380280 
	v_mov_b32_e32 v29, 0                                       // 0000000023C8: 7E3A0280 
	v_mov_b32_e32 v30, 0                                       // 0000000023CC: 7E3C0280 
	v_mov_b32_e32 v31, 0                                       // 0000000023D0: 7E3E0280 
	v_mov_b32_e32 v32, 0                                       // 0000000023D4: 7E400280 
	v_mov_b32_e32 v33, 0                                       // 0000000023D8: 7E420280 
	v_mov_b32_e32 v34, 0                                       // 0000000023DC: 7E440280 
	v_mov_b32_e32 v35, 0                                       // 0000000023E0: 7E460280 
	v_mov_b32_e32 v36, 0                                       // 0000000023E4: 7E480280 
	v_mov_b32_e32 v37, 0                                       // 0000000023E8: 7E4A0280 
	v_mov_b32_e32 v38, 0                                       // 0000000023EC: 7E4C0280 
	v_mov_b32_e32 v39, 0                                       // 0000000023F0: 7E4E0280 
	v_mov_b32_e32 v40, 0                                       // 0000000023F4: 7E500280 
	v_mov_b32_e32 v41, 0                                       // 0000000023F8: 7E520280 
	v_mov_b32_e32 v42, 0                                       // 0000000023FC: 7E540280 
	v_mov_b32_e32 v43, 0                                       // 000000002400: 7E560280 
	v_mov_b32_e32 v44, 0                                       // 000000002404: 7E580280 
	v_mov_b32_e32 v45, 0                                       // 000000002408: 7E5A0280 
	v_mov_b32_e32 v46, 0                                       // 00000000240C: 7E5C0280 
	v_mov_b32_e32 v47, 0                                       // 000000002410: 7E5E0280 
	v_mov_b32_e32 v48, 0                                       // 000000002414: 7E600280 
	v_mov_b32_e32 v49, 0                                       // 000000002418: 7E620280 
	v_mov_b32_e32 v50, 0                                       // 00000000241C: 7E640280 
	v_mov_b32_e32 v51, 0                                       // 000000002420: 7E660280 
	v_mov_b32_e32 v52, 0                                       // 000000002424: 7E680280 
	v_mov_b32_e32 v53, 0                                       // 000000002428: 7E6A0280 
	v_mov_b32_e32 v54, 0                                       // 00000000242C: 7E6C0280 
	v_mov_b32_e32 v55, 0                                       // 000000002430: 7E6E0280 
	v_mov_b32_e32 v56, 0                                       // 000000002434: 7E700280 
	v_mov_b32_e32 v57, 0                                       // 000000002438: 7E720280 
	v_mov_b32_e32 v58, 0                                       // 00000000243C: 7E740280 
	v_mov_b32_e32 v59, 0                                       // 000000002440: 7E760280 
	v_mov_b32_e32 v60, 0                                       // 000000002444: 7E780280 
	v_mov_b32_e32 v61, 0                                       // 000000002448: 7E7A0280 
	v_mov_b32_e32 v62, 0                                       // 00000000244C: 7E7C0280 
	v_mov_b32_e32 v63, 0                                       // 000000002450: 7E7E0280 
	v_mov_b32_e32 v64, 0                                       // 000000002454: 7E800280 
	v_mov_b32_e32 v65, 0                                       // 000000002458: 7E820280 
	v_mov_b32_e32 v66, 0                                       // 00000000245C: 7E840280 
	v_mov_b32_e32 v67, 0                                       // 000000002460: 7E860280 
	s_waitcnt lgkmcnt(0)                                       // 000000002464: BF8CC07F 
	s_lshl_b32 s26, s26, 2                                     // 000000002468: 8E1A821A 
	s_mul_i32 s18, s22, s26                                    // 00000000246C: 92121A16 
	s_mul_hi_u32 s19, s22, s26                                 // 000000002470: 96131A16 
	s_add_u32 s12, s12, s18                                    // 000000002474: 800C120C 
	s_addc_u32 s13, s13, s19                                   // 000000002478: 820D130D 
	s_mov_b32 s22, 0                                           // 00000000247C: BE960080 
	s_mul_i32 s27, s27, 4                                      // 000000002480: 921B841B 
	s_mul_i32 s20, s24, s27                                    // 000000002484: 92141B18 
	s_mul_hi_u32 s21, s24, s27                                 // 000000002488: 96151B18 
	s_add_u32 s14, s14, s20                                    // 00000000248C: 800E140E 
	s_addc_u32 s15, s15, s21                                   // 000000002490: 820F150F 
	v_mul_i32_i24_e32 v2, s27, v2                              // 000000002494: 0C04041B 
	v_mul_hi_i32_i24_e32 v3, s27, v2                           // 000000002498: 0E06041B 
	s_mov_b32 s20, s14                                         // 00000000249C: BE94000E 
	s_mov_b32 s21, s15                                         // 0000000024A0: BE95000F 
	global_load_dwordx4 v[68:71], v[2:3], s[20:21]             // 0000000024A4: DC5C8000 44140002 
	s_add_u32 s20, s20, 16                                     // 0000000024AC: 80149014 
	s_addc_u32 s21, s21, 0                                     // 0000000024B0: 82158015 
	global_load_dwordx4 v[72:75], v[2:3], s[20:21]             // 0000000024B4: DC5C8000 48140002 
	s_add_u32 s20, s20, 16                                     // 0000000024BC: 80149014 
	s_addc_u32 s21, s21, 0                                     // 0000000024C0: 82158015 
	s_mov_b32 s18, s16                                         // 0000000024C4: BE920010 
	s_load_dwordx8 s[32:39], s[12:13], s18                     // 0000000024C8: C00C0806 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000024D0: 80121A12 
	s_load_dwordx8 s[40:47], s[12:13], s18                     // 0000000024D4: C00C0A06 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000024DC: 80121A12 
	s_load_dwordx8 s[48:55], s[12:13], s18                     // 0000000024E0: C00C0C06 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000024E8: 80121A12 
	s_load_dwordx8 s[56:63], s[12:13], s18                     // 0000000024EC: C00C0E06 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000024F4: 80121A12 
	s_load_dwordx8 s[64:71], s[12:13], s18                     // 0000000024F8: C00C1006 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002500: 80121A12 
	s_load_dwordx8 s[72:79], s[12:13], s18                     // 000000002504: C00C1206 00000012 
	s_add_u32 s18, s18, s26                                    // 00000000250C: 80121A12 
	s_load_dwordx8 s[80:87], s[12:13], s18                     // 000000002510: C00C1406 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002518: 80121A12 
	s_load_dwordx8 s[88:95], s[12:13], s18                     // 00000000251C: C00C1606 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002524: 80121A12 
	s_mov_b32 s28, 0                                           // 000000002528: BE9C0080 
    s_mov_b32 s28, 0 
    
 label_major_loop_begin:
	global_load_dwordx4 v[76:79], v[2:3], s[20:21]             // 00000000252C: DC5C8000 4C140002 
	s_add_u32 s20, s20, 16                                     // 000000002534: 80149014 
	s_addc_u32 s21, s21, 0                                     // 000000002538: 82158015 
	global_load_dwordx4 v[80:83], v[2:3], s[20:21]             // 00000000253C: DC5C8000 50140002 
	s_add_u32 s20, s20, 16                                     // 000000002544: 80149014 
	s_addc_u32 s21, s21, 0                                     // 000000002548: 82158015 
	s_waitcnt lgkmcnt(0)                                       // 00000000254C: BF8CC07F 
	s_waitcnt vmcnt(2)                                         // 000000002550: BF8C0F72 
	v_fma_f32 v4, v68, s32, v4                                 // 000000002554: D1CB0004 04104144 
	v_fma_f32 v5, v68, s40, v5                                 // 00000000255C: D1CB0005 04145144 
	v_fma_f32 v4, v69, s33, v4                                 // 000000002564: D1CB0004 04104345 
	v_fma_f32 v5, v69, s41, v5                                 // 00000000256C: D1CB0005 04145345 
	v_fma_f32 v4, v70, s34, v4                                 // 000000002574: D1CB0004 04104546 
	v_fma_f32 v5, v70, s42, v5                                 // 00000000257C: D1CB0005 04145546 
	v_fma_f32 v4, v71, s35, v4                                 // 000000002584: D1CB0004 04104747 
	v_fma_f32 v5, v71, s43, v5                                 // 00000000258C: D1CB0005 04145747 
	v_fma_f32 v4, v72, s36, v4                                 // 000000002594: D1CB0004 04104948 
	v_fma_f32 v5, v72, s44, v5                                 // 00000000259C: D1CB0005 04145948 
	v_fma_f32 v4, v73, s37, v4                                 // 0000000025A4: D1CB0004 04104B49 
	v_fma_f32 v5, v73, s45, v5                                 // 0000000025AC: D1CB0005 04145B49 
	v_fma_f32 v4, v74, s38, v4                                 // 0000000025B4: D1CB0004 04104D4A 
	v_fma_f32 v5, v74, s46, v5                                 // 0000000025BC: D1CB0005 04145D4A 
	v_fma_f32 v4, v75, s39, v4                                 // 0000000025C4: D1CB0004 04104F4B 
	v_fma_f32 v5, v75, s47, v5                                 // 0000000025CC: D1CB0005 04145F4B 
	s_load_dwordx8 s[32:39], s[12:13], s18                     // 0000000025D4: C00C0806 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000025DC: 80121A12 
	s_load_dwordx8 s[40:47], s[12:13], s18                     // 0000000025E0: C00C0A06 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000025E8: 80121A12 
	v_fma_f32 v6, v68, s48, v6                                 // 0000000025EC: D1CB0006 04186144 
	v_fma_f32 v7, v68, s56, v7                                 // 0000000025F4: D1CB0007 041C7144 
	v_fma_f32 v6, v69, s49, v6                                 // 0000000025FC: D1CB0006 04186345 
	v_fma_f32 v7, v69, s57, v7                                 // 000000002604: D1CB0007 041C7345 
	v_fma_f32 v6, v70, s50, v6                                 // 00000000260C: D1CB0006 04186546 
	v_fma_f32 v7, v70, s58, v7                                 // 000000002614: D1CB0007 041C7546 
	v_fma_f32 v6, v71, s51, v6                                 // 00000000261C: D1CB0006 04186747 
	v_fma_f32 v7, v71, s59, v7                                 // 000000002624: D1CB0007 041C7747 
	v_fma_f32 v6, v72, s52, v6                                 // 00000000262C: D1CB0006 04186948 
	v_fma_f32 v7, v72, s60, v7                                 // 000000002634: D1CB0007 041C7948 
	v_fma_f32 v6, v73, s53, v6                                 // 00000000263C: D1CB0006 04186B49 
	v_fma_f32 v7, v73, s61, v7                                 // 000000002644: D1CB0007 041C7B49 
	v_fma_f32 v6, v74, s54, v6                                 // 00000000264C: D1CB0006 04186D4A 
	v_fma_f32 v7, v74, s62, v7                                 // 000000002654: D1CB0007 041C7D4A 
	v_fma_f32 v6, v75, s55, v6                                 // 00000000265C: D1CB0006 04186F4B 
	v_fma_f32 v7, v75, s63, v7                                 // 000000002664: D1CB0007 041C7F4B 
	s_load_dwordx8 s[48:55], s[12:13], s18                     // 00000000266C: C00C0C06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002674: 80121A12 
	s_load_dwordx8 s[56:63], s[12:13], s18                     // 000000002678: C00C0E06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002680: 80121A12 
	v_fma_f32 v8, v68, s64, v8                                 // 000000002684: D1CB0008 04208144 
	v_fma_f32 v9, v68, s72, v9                                 // 00000000268C: D1CB0009 04249144 
	v_fma_f32 v8, v69, s65, v8                                 // 000000002694: D1CB0008 04208345 
	v_fma_f32 v9, v69, s73, v9                                 // 00000000269C: D1CB0009 04249345 
	v_fma_f32 v8, v70, s66, v8                                 // 0000000026A4: D1CB0008 04208546 
	v_fma_f32 v9, v70, s74, v9                                 // 0000000026AC: D1CB0009 04249546 
	v_fma_f32 v8, v71, s67, v8                                 // 0000000026B4: D1CB0008 04208747 
	v_fma_f32 v9, v71, s75, v9                                 // 0000000026BC: D1CB0009 04249747 
	v_fma_f32 v8, v72, s68, v8                                 // 0000000026C4: D1CB0008 04208948 
	v_fma_f32 v9, v72, s76, v9                                 // 0000000026CC: D1CB0009 04249948 
	v_fma_f32 v8, v73, s69, v8                                 // 0000000026D4: D1CB0008 04208B49 
	v_fma_f32 v9, v73, s77, v9                                 // 0000000026DC: D1CB0009 04249B49 
	v_fma_f32 v8, v74, s70, v8                                 // 0000000026E4: D1CB0008 04208D4A 
	v_fma_f32 v9, v74, s78, v9                                 // 0000000026EC: D1CB0009 04249D4A 
	v_fma_f32 v8, v75, s71, v8                                 // 0000000026F4: D1CB0008 04208F4B 
	v_fma_f32 v9, v75, s79, v9                                 // 0000000026FC: D1CB0009 04249F4B 
	s_load_dwordx8 s[64:71], s[12:13], s18                     // 000000002704: C00C1006 00000012 
	s_add_u32 s18, s18, s26                                    // 00000000270C: 80121A12 
	s_load_dwordx8 s[72:79], s[12:13], s18                     // 000000002710: C00C1206 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002718: 80121A12 
	v_fma_f32 v10, v68, s80, v10                               // 00000000271C: D1CB000A 0428A144 
	v_fma_f32 v11, v68, s88, v11                               // 000000002724: D1CB000B 042CB144 
	v_fma_f32 v10, v69, s81, v10                               // 00000000272C: D1CB000A 0428A345 
	v_fma_f32 v11, v69, s89, v11                               // 000000002734: D1CB000B 042CB345 
	v_fma_f32 v10, v70, s82, v10                               // 00000000273C: D1CB000A 0428A546 
	v_fma_f32 v11, v70, s90, v11                               // 000000002744: D1CB000B 042CB546 
	v_fma_f32 v10, v71, s83, v10                               // 00000000274C: D1CB000A 0428A747 
	v_fma_f32 v11, v71, s91, v11                               // 000000002754: D1CB000B 042CB747 
	v_fma_f32 v10, v72, s84, v10                               // 00000000275C: D1CB000A 0428A948 
	v_fma_f32 v11, v72, s92, v11                               // 000000002764: D1CB000B 042CB948 
	v_fma_f32 v10, v73, s85, v10                               // 00000000276C: D1CB000A 0428AB49 
	v_fma_f32 v11, v73, s93, v11                               // 000000002774: D1CB000B 042CBB49 
	v_fma_f32 v10, v74, s86, v10                               // 00000000277C: D1CB000A 0428AD4A 
	v_fma_f32 v11, v74, s94, v11                               // 000000002784: D1CB000B 042CBD4A 
	v_fma_f32 v10, v75, s87, v10                               // 00000000278C: D1CB000A 0428AF4B 
	v_fma_f32 v11, v75, s95, v11                               // 000000002794: D1CB000B 042CBF4B 
	s_load_dwordx8 s[80:87], s[12:13], s18                     // 00000000279C: C00C1406 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000027A4: 80121A12 
	s_load_dwordx8 s[88:95], s[12:13], s18                     // 0000000027A8: C00C1606 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000027B0: 80121A12 
	s_waitcnt lgkmcnt(0)                                       // 0000000027B4: BF8CC07F 
	v_fma_f32 v12, v68, s32, v12                               // 0000000027B8: D1CB000C 04304144 
	v_fma_f32 v13, v68, s40, v13                               // 0000000027C0: D1CB000D 04345144 
	v_fma_f32 v12, v69, s33, v12                               // 0000000027C8: D1CB000C 04304345 
	v_fma_f32 v13, v69, s41, v13                               // 0000000027D0: D1CB000D 04345345 
	v_fma_f32 v12, v70, s34, v12                               // 0000000027D8: D1CB000C 04304546 
	v_fma_f32 v13, v70, s42, v13                               // 0000000027E0: D1CB000D 04345546 
	v_fma_f32 v12, v71, s35, v12                               // 0000000027E8: D1CB000C 04304747 
	v_fma_f32 v13, v71, s43, v13                               // 0000000027F0: D1CB000D 04345747 
	v_fma_f32 v12, v72, s36, v12                               // 0000000027F8: D1CB000C 04304948 
	v_fma_f32 v13, v72, s44, v13                               // 000000002800: D1CB000D 04345948 
	v_fma_f32 v12, v73, s37, v12                               // 000000002808: D1CB000C 04304B49 
	v_fma_f32 v13, v73, s45, v13                               // 000000002810: D1CB000D 04345B49 
	v_fma_f32 v12, v74, s38, v12                               // 000000002818: D1CB000C 04304D4A 
	v_fma_f32 v13, v74, s46, v13                               // 000000002820: D1CB000D 04345D4A 
	v_fma_f32 v12, v75, s39, v12                               // 000000002828: D1CB000C 04304F4B 
	v_fma_f32 v13, v75, s47, v13                               // 000000002830: D1CB000D 04345F4B 
	s_load_dwordx8 s[32:39], s[12:13], s18                     // 000000002838: C00C0806 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002840: 80121A12 
	s_load_dwordx8 s[40:47], s[12:13], s18                     // 000000002844: C00C0A06 00000012 
	s_add_u32 s18, s18, s26                                    // 00000000284C: 80121A12 
	v_fma_f32 v14, v68, s48, v14                               // 000000002850: D1CB000E 04386144 
	v_fma_f32 v15, v68, s56, v15                               // 000000002858: D1CB000F 043C7144 
	v_fma_f32 v14, v69, s49, v14                               // 000000002860: D1CB000E 04386345 
	v_fma_f32 v15, v69, s57, v15                               // 000000002868: D1CB000F 043C7345 
	v_fma_f32 v14, v70, s50, v14                               // 000000002870: D1CB000E 04386546 
	v_fma_f32 v15, v70, s58, v15                               // 000000002878: D1CB000F 043C7546 
	v_fma_f32 v14, v71, s51, v14                               // 000000002880: D1CB000E 04386747 
	v_fma_f32 v15, v71, s59, v15                               // 000000002888: D1CB000F 043C7747 
	v_fma_f32 v14, v72, s52, v14                               // 000000002890: D1CB000E 04386948 
	v_fma_f32 v15, v72, s60, v15                               // 000000002898: D1CB000F 043C7948 
	v_fma_f32 v14, v73, s53, v14                               // 0000000028A0: D1CB000E 04386B49 
	v_fma_f32 v15, v73, s61, v15                               // 0000000028A8: D1CB000F 043C7B49 
	v_fma_f32 v14, v74, s54, v14                               // 0000000028B0: D1CB000E 04386D4A 
	v_fma_f32 v15, v74, s62, v15                               // 0000000028B8: D1CB000F 043C7D4A 
	v_fma_f32 v14, v75, s55, v14                               // 0000000028C0: D1CB000E 04386F4B 
	v_fma_f32 v15, v75, s63, v15                               // 0000000028C8: D1CB000F 043C7F4B 
	s_load_dwordx8 s[48:55], s[12:13], s18                     // 0000000028D0: C00C0C06 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000028D8: 80121A12 
	s_load_dwordx8 s[56:63], s[12:13], s18                     // 0000000028DC: C00C0E06 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000028E4: 80121A12 
	v_fma_f32 v16, v68, s64, v16                               // 0000000028E8: D1CB0010 04408144 
	v_fma_f32 v17, v68, s72, v17                               // 0000000028F0: D1CB0011 04449144 
	v_fma_f32 v16, v69, s65, v16                               // 0000000028F8: D1CB0010 04408345 
	v_fma_f32 v17, v69, s73, v17                               // 000000002900: D1CB0011 04449345 
	v_fma_f32 v16, v70, s66, v16                               // 000000002908: D1CB0010 04408546 
	v_fma_f32 v17, v70, s74, v17                               // 000000002910: D1CB0011 04449546 
	v_fma_f32 v16, v71, s67, v16                               // 000000002918: D1CB0010 04408747 
	v_fma_f32 v17, v71, s75, v17                               // 000000002920: D1CB0011 04449747 
	v_fma_f32 v16, v72, s68, v16                               // 000000002928: D1CB0010 04408948 
	v_fma_f32 v17, v72, s76, v17                               // 000000002930: D1CB0011 04449948 
	v_fma_f32 v16, v73, s69, v16                               // 000000002938: D1CB0010 04408B49 
	v_fma_f32 v17, v73, s77, v17                               // 000000002940: D1CB0011 04449B49 
	v_fma_f32 v16, v74, s70, v16                               // 000000002948: D1CB0010 04408D4A 
	v_fma_f32 v17, v74, s78, v17                               // 000000002950: D1CB0011 04449D4A 
	v_fma_f32 v16, v75, s71, v16                               // 000000002958: D1CB0010 04408F4B 
	v_fma_f32 v17, v75, s79, v17                               // 000000002960: D1CB0011 04449F4B 
	s_load_dwordx8 s[64:71], s[12:13], s18                     // 000000002968: C00C1006 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002970: 80121A12 
	s_load_dwordx8 s[72:79], s[12:13], s18                     // 000000002974: C00C1206 00000012 
	s_add_u32 s18, s18, s26                                    // 00000000297C: 80121A12 
	v_fma_f32 v18, v68, s80, v18                               // 000000002980: D1CB0012 0448A144 
	v_fma_f32 v19, v68, s88, v19                               // 000000002988: D1CB0013 044CB144 
	v_fma_f32 v18, v69, s81, v18                               // 000000002990: D1CB0012 0448A345 
	v_fma_f32 v19, v69, s89, v19                               // 000000002998: D1CB0013 044CB345 
	v_fma_f32 v18, v70, s82, v18                               // 0000000029A0: D1CB0012 0448A546 
	v_fma_f32 v19, v70, s90, v19                               // 0000000029A8: D1CB0013 044CB546 
	v_fma_f32 v18, v71, s83, v18                               // 0000000029B0: D1CB0012 0448A747 
	v_fma_f32 v19, v71, s91, v19                               // 0000000029B8: D1CB0013 044CB747 
	v_fma_f32 v18, v72, s84, v18                               // 0000000029C0: D1CB0012 0448A948 
	v_fma_f32 v19, v72, s92, v19                               // 0000000029C8: D1CB0013 044CB948 
	v_fma_f32 v18, v73, s85, v18                               // 0000000029D0: D1CB0012 0448AB49 
	v_fma_f32 v19, v73, s93, v19                               // 0000000029D8: D1CB0013 044CBB49 
	v_fma_f32 v18, v74, s86, v18                               // 0000000029E0: D1CB0012 0448AD4A 
	v_fma_f32 v19, v74, s94, v19                               // 0000000029E8: D1CB0013 044CBD4A 
	v_fma_f32 v18, v75, s87, v18                               // 0000000029F0: D1CB0012 0448AF4B 
	v_fma_f32 v19, v75, s95, v19                               // 0000000029F8: D1CB0013 044CBF4B 
	s_load_dwordx8 s[80:87], s[12:13], s18                     // 000000002A00: C00C1406 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002A08: 80121A12 
	s_load_dwordx8 s[88:95], s[12:13], s18                     // 000000002A0C: C00C1606 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002A14: 80121A12 
	s_waitcnt lgkmcnt(0)                                       // 000000002A18: BF8CC07F 
	v_fma_f32 v20, v68, s32, v20                               // 000000002A1C: D1CB0014 04504144 
	v_fma_f32 v21, v68, s40, v21                               // 000000002A24: D1CB0015 04545144 
	v_fma_f32 v20, v69, s33, v20                               // 000000002A2C: D1CB0014 04504345 
	v_fma_f32 v21, v69, s41, v21                               // 000000002A34: D1CB0015 04545345 
	v_fma_f32 v20, v70, s34, v20                               // 000000002A3C: D1CB0014 04504546 
	v_fma_f32 v21, v70, s42, v21                               // 000000002A44: D1CB0015 04545546 
	v_fma_f32 v20, v71, s35, v20                               // 000000002A4C: D1CB0014 04504747 
	v_fma_f32 v21, v71, s43, v21                               // 000000002A54: D1CB0015 04545747 
	v_fma_f32 v20, v72, s36, v20                               // 000000002A5C: D1CB0014 04504948 
	v_fma_f32 v21, v72, s44, v21                               // 000000002A64: D1CB0015 04545948 
	v_fma_f32 v20, v73, s37, v20                               // 000000002A6C: D1CB0014 04504B49 
	v_fma_f32 v21, v73, s45, v21                               // 000000002A74: D1CB0015 04545B49 
	v_fma_f32 v20, v74, s38, v20                               // 000000002A7C: D1CB0014 04504D4A 
	v_fma_f32 v21, v74, s46, v21                               // 000000002A84: D1CB0015 04545D4A 
	v_fma_f32 v20, v75, s39, v20                               // 000000002A8C: D1CB0014 04504F4B 
	v_fma_f32 v21, v75, s47, v21                               // 000000002A94: D1CB0015 04545F4B 
	s_load_dwordx8 s[32:39], s[12:13], s18                     // 000000002A9C: C00C0806 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002AA4: 80121A12 
	s_load_dwordx8 s[40:47], s[12:13], s18                     // 000000002AA8: C00C0A06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002AB0: 80121A12 
	v_fma_f32 v22, v68, s48, v22                               // 000000002AB4: D1CB0016 04586144 
	v_fma_f32 v23, v68, s56, v23                               // 000000002ABC: D1CB0017 045C7144 
	v_fma_f32 v22, v69, s49, v22                               // 000000002AC4: D1CB0016 04586345 
	v_fma_f32 v23, v69, s57, v23                               // 000000002ACC: D1CB0017 045C7345 
	v_fma_f32 v22, v70, s50, v22                               // 000000002AD4: D1CB0016 04586546 
	v_fma_f32 v23, v70, s58, v23                               // 000000002ADC: D1CB0017 045C7546 
	v_fma_f32 v22, v71, s51, v22                               // 000000002AE4: D1CB0016 04586747 
	v_fma_f32 v23, v71, s59, v23                               // 000000002AEC: D1CB0017 045C7747 
	v_fma_f32 v22, v72, s52, v22                               // 000000002AF4: D1CB0016 04586948 
	v_fma_f32 v23, v72, s60, v23                               // 000000002AFC: D1CB0017 045C7948 
	v_fma_f32 v22, v73, s53, v22                               // 000000002B04: D1CB0016 04586B49 
	v_fma_f32 v23, v73, s61, v23                               // 000000002B0C: D1CB0017 045C7B49 
	v_fma_f32 v22, v74, s54, v22                               // 000000002B14: D1CB0016 04586D4A 
	v_fma_f32 v23, v74, s62, v23                               // 000000002B1C: D1CB0017 045C7D4A 
	v_fma_f32 v22, v75, s55, v22                               // 000000002B24: D1CB0016 04586F4B 
	v_fma_f32 v23, v75, s63, v23                               // 000000002B2C: D1CB0017 045C7F4B 
	s_load_dwordx8 s[48:55], s[12:13], s18                     // 000000002B34: C00C0C06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002B3C: 80121A12 
	s_load_dwordx8 s[56:63], s[12:13], s18                     // 000000002B40: C00C0E06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002B48: 80121A12 
	v_fma_f32 v24, v68, s64, v24                               // 000000002B4C: D1CB0018 04608144 
	v_fma_f32 v25, v68, s72, v25                               // 000000002B54: D1CB0019 04649144 
	v_fma_f32 v24, v69, s65, v24                               // 000000002B5C: D1CB0018 04608345 
	v_fma_f32 v25, v69, s73, v25                               // 000000002B64: D1CB0019 04649345 
	v_fma_f32 v24, v70, s66, v24                               // 000000002B6C: D1CB0018 04608546 
	v_fma_f32 v25, v70, s74, v25                               // 000000002B74: D1CB0019 04649546 
	v_fma_f32 v24, v71, s67, v24                               // 000000002B7C: D1CB0018 04608747 
	v_fma_f32 v25, v71, s75, v25                               // 000000002B84: D1CB0019 04649747 
	v_fma_f32 v24, v72, s68, v24                               // 000000002B8C: D1CB0018 04608948 
	v_fma_f32 v25, v72, s76, v25                               // 000000002B94: D1CB0019 04649948 
	v_fma_f32 v24, v73, s69, v24                               // 000000002B9C: D1CB0018 04608B49 
	v_fma_f32 v25, v73, s77, v25                               // 000000002BA4: D1CB0019 04649B49 
	v_fma_f32 v24, v74, s70, v24                               // 000000002BAC: D1CB0018 04608D4A 
	v_fma_f32 v25, v74, s78, v25                               // 000000002BB4: D1CB0019 04649D4A 
	v_fma_f32 v24, v75, s71, v24                               // 000000002BBC: D1CB0018 04608F4B 
	v_fma_f32 v25, v75, s79, v25                               // 000000002BC4: D1CB0019 04649F4B 
	s_load_dwordx8 s[64:71], s[12:13], s18                     // 000000002BCC: C00C1006 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002BD4: 80121A12 
	s_load_dwordx8 s[72:79], s[12:13], s18                     // 000000002BD8: C00C1206 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002BE0: 80121A12 
	v_fma_f32 v26, v68, s80, v26                               // 000000002BE4: D1CB001A 0468A144 
	v_fma_f32 v27, v68, s88, v27                               // 000000002BEC: D1CB001B 046CB144 
	v_fma_f32 v26, v69, s81, v26                               // 000000002BF4: D1CB001A 0468A345 
	v_fma_f32 v27, v69, s89, v27                               // 000000002BFC: D1CB001B 046CB345 
	v_fma_f32 v26, v70, s82, v26                               // 000000002C04: D1CB001A 0468A546 
	v_fma_f32 v27, v70, s90, v27                               // 000000002C0C: D1CB001B 046CB546 
	v_fma_f32 v26, v71, s83, v26                               // 000000002C14: D1CB001A 0468A747 
	v_fma_f32 v27, v71, s91, v27                               // 000000002C1C: D1CB001B 046CB747 
	v_fma_f32 v26, v72, s84, v26                               // 000000002C24: D1CB001A 0468A948 
	v_fma_f32 v27, v72, s92, v27                               // 000000002C2C: D1CB001B 046CB948 
	v_fma_f32 v26, v73, s85, v26                               // 000000002C34: D1CB001A 0468AB49 
	v_fma_f32 v27, v73, s93, v27                               // 000000002C3C: D1CB001B 046CBB49 
	v_fma_f32 v26, v74, s86, v26                               // 000000002C44: D1CB001A 0468AD4A 
	v_fma_f32 v27, v74, s94, v27                               // 000000002C4C: D1CB001B 046CBD4A 
	v_fma_f32 v26, v75, s87, v26                               // 000000002C54: D1CB001A 0468AF4B 
	v_fma_f32 v27, v75, s95, v27                               // 000000002C5C: D1CB001B 046CBF4B 
	s_load_dwordx8 s[80:87], s[12:13], s18                     // 000000002C64: C00C1406 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002C6C: 80121A12 
	s_load_dwordx8 s[88:95], s[12:13], s18                     // 000000002C70: C00C1606 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002C78: 80121A12 
	s_waitcnt lgkmcnt(0)                                       // 000000002C7C: BF8CC07F 
	v_fma_f32 v28, v68, s32, v28                               // 000000002C80: D1CB001C 04704144 
	v_fma_f32 v29, v68, s40, v29                               // 000000002C88: D1CB001D 04745144 
	v_fma_f32 v28, v69, s33, v28                               // 000000002C90: D1CB001C 04704345 
	v_fma_f32 v29, v69, s41, v29                               // 000000002C98: D1CB001D 04745345 
	v_fma_f32 v28, v70, s34, v28                               // 000000002CA0: D1CB001C 04704546 
	v_fma_f32 v29, v70, s42, v29                               // 000000002CA8: D1CB001D 04745546 
	v_fma_f32 v28, v71, s35, v28                               // 000000002CB0: D1CB001C 04704747 
	v_fma_f32 v29, v71, s43, v29                               // 000000002CB8: D1CB001D 04745747 
	v_fma_f32 v28, v72, s36, v28                               // 000000002CC0: D1CB001C 04704948 
	v_fma_f32 v29, v72, s44, v29                               // 000000002CC8: D1CB001D 04745948 
	v_fma_f32 v28, v73, s37, v28                               // 000000002CD0: D1CB001C 04704B49 
	v_fma_f32 v29, v73, s45, v29                               // 000000002CD8: D1CB001D 04745B49 
	v_fma_f32 v28, v74, s38, v28                               // 000000002CE0: D1CB001C 04704D4A 
	v_fma_f32 v29, v74, s46, v29                               // 000000002CE8: D1CB001D 04745D4A 
	v_fma_f32 v28, v75, s39, v28                               // 000000002CF0: D1CB001C 04704F4B 
	v_fma_f32 v29, v75, s47, v29                               // 000000002CF8: D1CB001D 04745F4B 
	s_load_dwordx8 s[32:39], s[12:13], s18                     // 000000002D00: C00C0806 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002D08: 80121A12 
	s_load_dwordx8 s[40:47], s[12:13], s18                     // 000000002D0C: C00C0A06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002D14: 80121A12 
	v_fma_f32 v30, v68, s48, v30                               // 000000002D18: D1CB001E 04786144 
	v_fma_f32 v31, v68, s56, v31                               // 000000002D20: D1CB001F 047C7144 
	v_fma_f32 v30, v69, s49, v30                               // 000000002D28: D1CB001E 04786345 
	v_fma_f32 v31, v69, s57, v31                               // 000000002D30: D1CB001F 047C7345 
	v_fma_f32 v30, v70, s50, v30                               // 000000002D38: D1CB001E 04786546 
	v_fma_f32 v31, v70, s58, v31                               // 000000002D40: D1CB001F 047C7546 
	v_fma_f32 v30, v71, s51, v30                               // 000000002D48: D1CB001E 04786747 
	v_fma_f32 v31, v71, s59, v31                               // 000000002D50: D1CB001F 047C7747 
	v_fma_f32 v30, v72, s52, v30                               // 000000002D58: D1CB001E 04786948 
	v_fma_f32 v31, v72, s60, v31                               // 000000002D60: D1CB001F 047C7948 
	v_fma_f32 v30, v73, s53, v30                               // 000000002D68: D1CB001E 04786B49 
	v_fma_f32 v31, v73, s61, v31                               // 000000002D70: D1CB001F 047C7B49 
	v_fma_f32 v30, v74, s54, v30                               // 000000002D78: D1CB001E 04786D4A 
	v_fma_f32 v31, v74, s62, v31                               // 000000002D80: D1CB001F 047C7D4A 
	v_fma_f32 v30, v75, s55, v30                               // 000000002D88: D1CB001E 04786F4B 
	v_fma_f32 v31, v75, s63, v31                               // 000000002D90: D1CB001F 047C7F4B 
	s_load_dwordx8 s[48:55], s[12:13], s18                     // 000000002D98: C00C0C06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002DA0: 80121A12 
	s_load_dwordx8 s[56:63], s[12:13], s18                     // 000000002DA4: C00C0E06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002DAC: 80121A12 
	v_fma_f32 v32, v68, s64, v32                               // 000000002DB0: D1CB0020 04808144 
	v_fma_f32 v33, v68, s72, v33                               // 000000002DB8: D1CB0021 04849144 
	v_fma_f32 v32, v69, s65, v32                               // 000000002DC0: D1CB0020 04808345 
	v_fma_f32 v33, v69, s73, v33                               // 000000002DC8: D1CB0021 04849345 
	v_fma_f32 v32, v70, s66, v32                               // 000000002DD0: D1CB0020 04808546 
	v_fma_f32 v33, v70, s74, v33                               // 000000002DD8: D1CB0021 04849546 
	v_fma_f32 v32, v71, s67, v32                               // 000000002DE0: D1CB0020 04808747 
	v_fma_f32 v33, v71, s75, v33                               // 000000002DE8: D1CB0021 04849747 
	v_fma_f32 v32, v72, s68, v32                               // 000000002DF0: D1CB0020 04808948 
	v_fma_f32 v33, v72, s76, v33                               // 000000002DF8: D1CB0021 04849948 
	v_fma_f32 v32, v73, s69, v32                               // 000000002E00: D1CB0020 04808B49 
	v_fma_f32 v33, v73, s77, v33                               // 000000002E08: D1CB0021 04849B49 
	v_fma_f32 v32, v74, s70, v32                               // 000000002E10: D1CB0020 04808D4A 
	v_fma_f32 v33, v74, s78, v33                               // 000000002E18: D1CB0021 04849D4A 
	v_fma_f32 v32, v75, s71, v32                               // 000000002E20: D1CB0020 04808F4B 
	v_fma_f32 v33, v75, s79, v33                               // 000000002E28: D1CB0021 04849F4B 
	s_load_dwordx8 s[64:71], s[12:13], s18                     // 000000002E30: C00C1006 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002E38: 80121A12 
	s_load_dwordx8 s[72:79], s[12:13], s18                     // 000000002E3C: C00C1206 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002E44: 80121A12 
	v_fma_f32 v34, v68, s80, v34                               // 000000002E48: D1CB0022 0488A144 
	v_fma_f32 v35, v68, s88, v35                               // 000000002E50: D1CB0023 048CB144 
	v_fma_f32 v34, v69, s81, v34                               // 000000002E58: D1CB0022 0488A345 
	v_fma_f32 v35, v69, s89, v35                               // 000000002E60: D1CB0023 048CB345 
	v_fma_f32 v34, v70, s82, v34                               // 000000002E68: D1CB0022 0488A546 
	v_fma_f32 v35, v70, s90, v35                               // 000000002E70: D1CB0023 048CB546 
	v_fma_f32 v34, v71, s83, v34                               // 000000002E78: D1CB0022 0488A747 
	v_fma_f32 v35, v71, s91, v35                               // 000000002E80: D1CB0023 048CB747 
	v_fma_f32 v34, v72, s84, v34                               // 000000002E88: D1CB0022 0488A948 
	v_fma_f32 v35, v72, s92, v35                               // 000000002E90: D1CB0023 048CB948 
	v_fma_f32 v34, v73, s85, v34                               // 000000002E98: D1CB0022 0488AB49 
	v_fma_f32 v35, v73, s93, v35                               // 000000002EA0: D1CB0023 048CBB49 
	v_fma_f32 v34, v74, s86, v34                               // 000000002EA8: D1CB0022 0488AD4A 
	v_fma_f32 v35, v74, s94, v35                               // 000000002EB0: D1CB0023 048CBD4A 
	v_fma_f32 v34, v75, s87, v34                               // 000000002EB8: D1CB0022 0488AF4B 
	v_fma_f32 v35, v75, s95, v35                               // 000000002EC0: D1CB0023 048CBF4B 
	s_load_dwordx8 s[80:87], s[12:13], s18                     // 000000002EC8: C00C1406 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002ED0: 80121A12 
	s_load_dwordx8 s[88:95], s[12:13], s18                     // 000000002ED4: C00C1606 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002EDC: 80121A12 
	s_waitcnt lgkmcnt(0)                                       // 000000002EE0: BF8CC07F 
	v_fma_f32 v36, v68, s32, v36                               // 000000002EE4: D1CB0024 04904144 
	v_fma_f32 v37, v68, s40, v37                               // 000000002EEC: D1CB0025 04945144 
	v_fma_f32 v36, v69, s33, v36                               // 000000002EF4: D1CB0024 04904345 
	v_fma_f32 v37, v69, s41, v37                               // 000000002EFC: D1CB0025 04945345 
	v_fma_f32 v36, v70, s34, v36                               // 000000002F04: D1CB0024 04904546 
	v_fma_f32 v37, v70, s42, v37                               // 000000002F0C: D1CB0025 04945546 
	v_fma_f32 v36, v71, s35, v36                               // 000000002F14: D1CB0024 04904747 
	v_fma_f32 v37, v71, s43, v37                               // 000000002F1C: D1CB0025 04945747 
	v_fma_f32 v36, v72, s36, v36                               // 000000002F24: D1CB0024 04904948 
	v_fma_f32 v37, v72, s44, v37                               // 000000002F2C: D1CB0025 04945948 
	v_fma_f32 v36, v73, s37, v36                               // 000000002F34: D1CB0024 04904B49 
	v_fma_f32 v37, v73, s45, v37                               // 000000002F3C: D1CB0025 04945B49 
	v_fma_f32 v36, v74, s38, v36                               // 000000002F44: D1CB0024 04904D4A 
	v_fma_f32 v37, v74, s46, v37                               // 000000002F4C: D1CB0025 04945D4A 
	v_fma_f32 v36, v75, s39, v36                               // 000000002F54: D1CB0024 04904F4B 
	v_fma_f32 v37, v75, s47, v37                               // 000000002F5C: D1CB0025 04945F4B 
	s_load_dwordx8 s[32:39], s[12:13], s18                     // 000000002F64: C00C0806 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002F6C: 80121A12 
	s_load_dwordx8 s[40:47], s[12:13], s18                     // 000000002F70: C00C0A06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000002F78: 80121A12 
	v_fma_f32 v38, v68, s48, v38                               // 000000002F7C: D1CB0026 04986144 
	v_fma_f32 v39, v68, s56, v39                               // 000000002F84: D1CB0027 049C7144 
	v_fma_f32 v38, v69, s49, v38                               // 000000002F8C: D1CB0026 04986345 
	v_fma_f32 v39, v69, s57, v39                               // 000000002F94: D1CB0027 049C7345 
	v_fma_f32 v38, v70, s50, v38                               // 000000002F9C: D1CB0026 04986546 
	v_fma_f32 v39, v70, s58, v39                               // 000000002FA4: D1CB0027 049C7546 
	v_fma_f32 v38, v71, s51, v38                               // 000000002FAC: D1CB0026 04986747 
	v_fma_f32 v39, v71, s59, v39                               // 000000002FB4: D1CB0027 049C7747 
	v_fma_f32 v38, v72, s52, v38                               // 000000002FBC: D1CB0026 04986948 
	v_fma_f32 v39, v72, s60, v39                               // 000000002FC4: D1CB0027 049C7948 
	v_fma_f32 v38, v73, s53, v38                               // 000000002FCC: D1CB0026 04986B49 
	v_fma_f32 v39, v73, s61, v39                               // 000000002FD4: D1CB0027 049C7B49 
	v_fma_f32 v38, v74, s54, v38                               // 000000002FDC: D1CB0026 04986D4A 
	v_fma_f32 v39, v74, s62, v39                               // 000000002FE4: D1CB0027 049C7D4A 
	v_fma_f32 v38, v75, s55, v38                               // 000000002FEC: D1CB0026 04986F4B 
	v_fma_f32 v39, v75, s63, v39                               // 000000002FF4: D1CB0027 049C7F4B 
	s_load_dwordx8 s[48:55], s[12:13], s18                     // 000000002FFC: C00C0C06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003004: 80121A12 
	s_load_dwordx8 s[56:63], s[12:13], s18                     // 000000003008: C00C0E06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003010: 80121A12 
	v_fma_f32 v40, v68, s64, v40                               // 000000003014: D1CB0028 04A08144 
	v_fma_f32 v41, v68, s72, v41                               // 00000000301C: D1CB0029 04A49144 
	v_fma_f32 v40, v69, s65, v40                               // 000000003024: D1CB0028 04A08345 
	v_fma_f32 v41, v69, s73, v41                               // 00000000302C: D1CB0029 04A49345 
	v_fma_f32 v40, v70, s66, v40                               // 000000003034: D1CB0028 04A08546 
	v_fma_f32 v41, v70, s74, v41                               // 00000000303C: D1CB0029 04A49546 
	v_fma_f32 v40, v71, s67, v40                               // 000000003044: D1CB0028 04A08747 
	v_fma_f32 v41, v71, s75, v41                               // 00000000304C: D1CB0029 04A49747 
	v_fma_f32 v40, v72, s68, v40                               // 000000003054: D1CB0028 04A08948 
	v_fma_f32 v41, v72, s76, v41                               // 00000000305C: D1CB0029 04A49948 
	v_fma_f32 v40, v73, s69, v40                               // 000000003064: D1CB0028 04A08B49 
	v_fma_f32 v41, v73, s77, v41                               // 00000000306C: D1CB0029 04A49B49 
	v_fma_f32 v40, v74, s70, v40                               // 000000003074: D1CB0028 04A08D4A 
	v_fma_f32 v41, v74, s78, v41                               // 00000000307C: D1CB0029 04A49D4A 
	v_fma_f32 v40, v75, s71, v40                               // 000000003084: D1CB0028 04A08F4B 
	v_fma_f32 v41, v75, s79, v41                               // 00000000308C: D1CB0029 04A49F4B 
	s_load_dwordx8 s[64:71], s[12:13], s18                     // 000000003094: C00C1006 00000012 
	s_add_u32 s18, s18, s26                                    // 00000000309C: 80121A12 
	s_load_dwordx8 s[72:79], s[12:13], s18                     // 0000000030A0: C00C1206 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000030A8: 80121A12 
	v_fma_f32 v42, v68, s80, v42                               // 0000000030AC: D1CB002A 04A8A144 
	v_fma_f32 v43, v68, s88, v43                               // 0000000030B4: D1CB002B 04ACB144 
	v_fma_f32 v42, v69, s81, v42                               // 0000000030BC: D1CB002A 04A8A345 
	v_fma_f32 v43, v69, s89, v43                               // 0000000030C4: D1CB002B 04ACB345 
	v_fma_f32 v42, v70, s82, v42                               // 0000000030CC: D1CB002A 04A8A546 
	v_fma_f32 v43, v70, s90, v43                               // 0000000030D4: D1CB002B 04ACB546 
	v_fma_f32 v42, v71, s83, v42                               // 0000000030DC: D1CB002A 04A8A747 
	v_fma_f32 v43, v71, s91, v43                               // 0000000030E4: D1CB002B 04ACB747 
	v_fma_f32 v42, v72, s84, v42                               // 0000000030EC: D1CB002A 04A8A948 
	v_fma_f32 v43, v72, s92, v43                               // 0000000030F4: D1CB002B 04ACB948 
	v_fma_f32 v42, v73, s85, v42                               // 0000000030FC: D1CB002A 04A8AB49 
	v_fma_f32 v43, v73, s93, v43                               // 000000003104: D1CB002B 04ACBB49 
	v_fma_f32 v42, v74, s86, v42                               // 00000000310C: D1CB002A 04A8AD4A 
	v_fma_f32 v43, v74, s94, v43                               // 000000003114: D1CB002B 04ACBD4A 
	v_fma_f32 v42, v75, s87, v42                               // 00000000311C: D1CB002A 04A8AF4B 
	v_fma_f32 v43, v75, s95, v43                               // 000000003124: D1CB002B 04ACBF4B 
	s_load_dwordx8 s[80:87], s[12:13], s18                     // 00000000312C: C00C1406 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003134: 80121A12 
	s_load_dwordx8 s[88:95], s[12:13], s18                     // 000000003138: C00C1606 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003140: 80121A12 
	s_waitcnt lgkmcnt(0)                                       // 000000003144: BF8CC07F 
	v_fma_f32 v44, v68, s32, v44                               // 000000003148: D1CB002C 04B04144 
	v_fma_f32 v45, v68, s40, v45                               // 000000003150: D1CB002D 04B45144 
	v_fma_f32 v44, v69, s33, v44                               // 000000003158: D1CB002C 04B04345 
	v_fma_f32 v45, v69, s41, v45                               // 000000003160: D1CB002D 04B45345 
	v_fma_f32 v44, v70, s34, v44                               // 000000003168: D1CB002C 04B04546 
	v_fma_f32 v45, v70, s42, v45                               // 000000003170: D1CB002D 04B45546 
	v_fma_f32 v44, v71, s35, v44                               // 000000003178: D1CB002C 04B04747 
	v_fma_f32 v45, v71, s43, v45                               // 000000003180: D1CB002D 04B45747 
	v_fma_f32 v44, v72, s36, v44                               // 000000003188: D1CB002C 04B04948 
	v_fma_f32 v45, v72, s44, v45                               // 000000003190: D1CB002D 04B45948 
	v_fma_f32 v44, v73, s37, v44                               // 000000003198: D1CB002C 04B04B49 
	v_fma_f32 v45, v73, s45, v45                               // 0000000031A0: D1CB002D 04B45B49 
	v_fma_f32 v44, v74, s38, v44                               // 0000000031A8: D1CB002C 04B04D4A 
	v_fma_f32 v45, v74, s46, v45                               // 0000000031B0: D1CB002D 04B45D4A 
	v_fma_f32 v44, v75, s39, v44                               // 0000000031B8: D1CB002C 04B04F4B 
	v_fma_f32 v45, v75, s47, v45                               // 0000000031C0: D1CB002D 04B45F4B 
	s_load_dwordx8 s[32:39], s[12:13], s18                     // 0000000031C8: C00C0806 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000031D0: 80121A12 
	s_load_dwordx8 s[40:47], s[12:13], s18                     // 0000000031D4: C00C0A06 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000031DC: 80121A12 
	v_fma_f32 v46, v68, s48, v46                               // 0000000031E0: D1CB002E 04B86144 
	v_fma_f32 v47, v68, s56, v47                               // 0000000031E8: D1CB002F 04BC7144 
	v_fma_f32 v46, v69, s49, v46                               // 0000000031F0: D1CB002E 04B86345 
	v_fma_f32 v47, v69, s57, v47                               // 0000000031F8: D1CB002F 04BC7345 
	v_fma_f32 v46, v70, s50, v46                               // 000000003200: D1CB002E 04B86546 
	v_fma_f32 v47, v70, s58, v47                               // 000000003208: D1CB002F 04BC7546 
	v_fma_f32 v46, v71, s51, v46                               // 000000003210: D1CB002E 04B86747 
	v_fma_f32 v47, v71, s59, v47                               // 000000003218: D1CB002F 04BC7747 
	v_fma_f32 v46, v72, s52, v46                               // 000000003220: D1CB002E 04B86948 
	v_fma_f32 v47, v72, s60, v47                               // 000000003228: D1CB002F 04BC7948 
	v_fma_f32 v46, v73, s53, v46                               // 000000003230: D1CB002E 04B86B49 
	v_fma_f32 v47, v73, s61, v47                               // 000000003238: D1CB002F 04BC7B49 
	v_fma_f32 v46, v74, s54, v46                               // 000000003240: D1CB002E 04B86D4A 
	v_fma_f32 v47, v74, s62, v47                               // 000000003248: D1CB002F 04BC7D4A 
	v_fma_f32 v46, v75, s55, v46                               // 000000003250: D1CB002E 04B86F4B 
	v_fma_f32 v47, v75, s63, v47                               // 000000003258: D1CB002F 04BC7F4B 
	s_load_dwordx8 s[48:55], s[12:13], s18                     // 000000003260: C00C0C06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003268: 80121A12 
	s_load_dwordx8 s[56:63], s[12:13], s18                     // 00000000326C: C00C0E06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003274: 80121A12 
	v_fma_f32 v48, v68, s64, v48                               // 000000003278: D1CB0030 04C08144 
	v_fma_f32 v49, v68, s72, v49                               // 000000003280: D1CB0031 04C49144 
	v_fma_f32 v48, v69, s65, v48                               // 000000003288: D1CB0030 04C08345 
	v_fma_f32 v49, v69, s73, v49                               // 000000003290: D1CB0031 04C49345 
	v_fma_f32 v48, v70, s66, v48                               // 000000003298: D1CB0030 04C08546 
	v_fma_f32 v49, v70, s74, v49                               // 0000000032A0: D1CB0031 04C49546 
	v_fma_f32 v48, v71, s67, v48                               // 0000000032A8: D1CB0030 04C08747 
	v_fma_f32 v49, v71, s75, v49                               // 0000000032B0: D1CB0031 04C49747 
	v_fma_f32 v48, v72, s68, v48                               // 0000000032B8: D1CB0030 04C08948 
	v_fma_f32 v49, v72, s76, v49                               // 0000000032C0: D1CB0031 04C49948 
	v_fma_f32 v48, v73, s69, v48                               // 0000000032C8: D1CB0030 04C08B49 
	v_fma_f32 v49, v73, s77, v49                               // 0000000032D0: D1CB0031 04C49B49 
	v_fma_f32 v48, v74, s70, v48                               // 0000000032D8: D1CB0030 04C08D4A 
	v_fma_f32 v49, v74, s78, v49                               // 0000000032E0: D1CB0031 04C49D4A 
	v_fma_f32 v48, v75, s71, v48                               // 0000000032E8: D1CB0030 04C08F4B 
	v_fma_f32 v49, v75, s79, v49                               // 0000000032F0: D1CB0031 04C49F4B 
	s_load_dwordx8 s[64:71], s[12:13], s18                     // 0000000032F8: C00C1006 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003300: 80121A12 
	s_load_dwordx8 s[72:79], s[12:13], s18                     // 000000003304: C00C1206 00000012 
	s_add_u32 s18, s18, s26                                    // 00000000330C: 80121A12 
	v_fma_f32 v50, v68, s80, v50                               // 000000003310: D1CB0032 04C8A144 
	v_fma_f32 v51, v68, s88, v51                               // 000000003318: D1CB0033 04CCB144 
	v_fma_f32 v50, v69, s81, v50                               // 000000003320: D1CB0032 04C8A345 
	v_fma_f32 v51, v69, s89, v51                               // 000000003328: D1CB0033 04CCB345 
	v_fma_f32 v50, v70, s82, v50                               // 000000003330: D1CB0032 04C8A546 
	v_fma_f32 v51, v70, s90, v51                               // 000000003338: D1CB0033 04CCB546 
	v_fma_f32 v50, v71, s83, v50                               // 000000003340: D1CB0032 04C8A747 
	v_fma_f32 v51, v71, s91, v51                               // 000000003348: D1CB0033 04CCB747 
	v_fma_f32 v50, v72, s84, v50                               // 000000003350: D1CB0032 04C8A948 
	v_fma_f32 v51, v72, s92, v51                               // 000000003358: D1CB0033 04CCB948 
	v_fma_f32 v50, v73, s85, v50                               // 000000003360: D1CB0032 04C8AB49 
	v_fma_f32 v51, v73, s93, v51                               // 000000003368: D1CB0033 04CCBB49 
	v_fma_f32 v50, v74, s86, v50                               // 000000003370: D1CB0032 04C8AD4A 
	v_fma_f32 v51, v74, s94, v51                               // 000000003378: D1CB0033 04CCBD4A 
	v_fma_f32 v50, v75, s87, v50                               // 000000003380: D1CB0032 04C8AF4B 
	v_fma_f32 v51, v75, s95, v51                               // 000000003388: D1CB0033 04CCBF4B 
	s_load_dwordx8 s[80:87], s[12:13], s18                     // 000000003390: C00C1406 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003398: 80121A12 
	s_load_dwordx8 s[88:95], s[12:13], s18                     // 00000000339C: C00C1606 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000033A4: 80121A12 
	s_waitcnt lgkmcnt(0)                                       // 0000000033A8: BF8CC07F 
	v_fma_f32 v52, v68, s32, v52                               // 0000000033AC: D1CB0034 04D04144 
	v_fma_f32 v53, v68, s40, v53                               // 0000000033B4: D1CB0035 04D45144 
	v_fma_f32 v52, v69, s33, v52                               // 0000000033BC: D1CB0034 04D04345 
	v_fma_f32 v53, v69, s41, v53                               // 0000000033C4: D1CB0035 04D45345 
	v_fma_f32 v52, v70, s34, v52                               // 0000000033CC: D1CB0034 04D04546 
	v_fma_f32 v53, v70, s42, v53                               // 0000000033D4: D1CB0035 04D45546 
	v_fma_f32 v52, v71, s35, v52                               // 0000000033DC: D1CB0034 04D04747 
	v_fma_f32 v53, v71, s43, v53                               // 0000000033E4: D1CB0035 04D45747 
	v_fma_f32 v52, v72, s36, v52                               // 0000000033EC: D1CB0034 04D04948 
	v_fma_f32 v53, v72, s44, v53                               // 0000000033F4: D1CB0035 04D45948 
	v_fma_f32 v52, v73, s37, v52                               // 0000000033FC: D1CB0034 04D04B49 
	v_fma_f32 v53, v73, s45, v53                               // 000000003404: D1CB0035 04D45B49 
	v_fma_f32 v52, v74, s38, v52                               // 00000000340C: D1CB0034 04D04D4A 
	v_fma_f32 v53, v74, s46, v53                               // 000000003414: D1CB0035 04D45D4A 
	v_fma_f32 v52, v75, s39, v52                               // 00000000341C: D1CB0034 04D04F4B 
	v_fma_f32 v53, v75, s47, v53                               // 000000003424: D1CB0035 04D45F4B 
	s_load_dwordx8 s[32:39], s[12:13], s18                     // 00000000342C: C00C0806 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003434: 80121A12 
	s_load_dwordx8 s[40:47], s[12:13], s18                     // 000000003438: C00C0A06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003440: 80121A12 
	v_fma_f32 v54, v68, s48, v54                               // 000000003444: D1CB0036 04D86144 
	v_fma_f32 v55, v68, s56, v55                               // 00000000344C: D1CB0037 04DC7144 
	v_fma_f32 v54, v69, s49, v54                               // 000000003454: D1CB0036 04D86345 
	v_fma_f32 v55, v69, s57, v55                               // 00000000345C: D1CB0037 04DC7345 
	v_fma_f32 v54, v70, s50, v54                               // 000000003464: D1CB0036 04D86546 
	v_fma_f32 v55, v70, s58, v55                               // 00000000346C: D1CB0037 04DC7546 
	v_fma_f32 v54, v71, s51, v54                               // 000000003474: D1CB0036 04D86747 
	v_fma_f32 v55, v71, s59, v55                               // 00000000347C: D1CB0037 04DC7747 
	v_fma_f32 v54, v72, s52, v54                               // 000000003484: D1CB0036 04D86948 
	v_fma_f32 v55, v72, s60, v55                               // 00000000348C: D1CB0037 04DC7948 
	v_fma_f32 v54, v73, s53, v54                               // 000000003494: D1CB0036 04D86B49 
	v_fma_f32 v55, v73, s61, v55                               // 00000000349C: D1CB0037 04DC7B49 
	v_fma_f32 v54, v74, s54, v54                               // 0000000034A4: D1CB0036 04D86D4A 
	v_fma_f32 v55, v74, s62, v55                               // 0000000034AC: D1CB0037 04DC7D4A 
	v_fma_f32 v54, v75, s55, v54                               // 0000000034B4: D1CB0036 04D86F4B 
	v_fma_f32 v55, v75, s63, v55                               // 0000000034BC: D1CB0037 04DC7F4B 
	s_load_dwordx8 s[48:55], s[12:13], s18                     // 0000000034C4: C00C0C06 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000034CC: 80121A12 
	s_load_dwordx8 s[56:63], s[12:13], s18                     // 0000000034D0: C00C0E06 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000034D8: 80121A12 
	v_fma_f32 v56, v68, s64, v56                               // 0000000034DC: D1CB0038 04E08144 
	v_fma_f32 v57, v68, s72, v57                               // 0000000034E4: D1CB0039 04E49144 
	v_fma_f32 v56, v69, s65, v56                               // 0000000034EC: D1CB0038 04E08345 
	v_fma_f32 v57, v69, s73, v57                               // 0000000034F4: D1CB0039 04E49345 
	v_fma_f32 v56, v70, s66, v56                               // 0000000034FC: D1CB0038 04E08546 
	v_fma_f32 v57, v70, s74, v57                               // 000000003504: D1CB0039 04E49546 
	v_fma_f32 v56, v71, s67, v56                               // 00000000350C: D1CB0038 04E08747 
	v_fma_f32 v57, v71, s75, v57                               // 000000003514: D1CB0039 04E49747 
	v_fma_f32 v56, v72, s68, v56                               // 00000000351C: D1CB0038 04E08948 
	v_fma_f32 v57, v72, s76, v57                               // 000000003524: D1CB0039 04E49948 
	v_fma_f32 v56, v73, s69, v56                               // 00000000352C: D1CB0038 04E08B49 
	v_fma_f32 v57, v73, s77, v57                               // 000000003534: D1CB0039 04E49B49 
	v_fma_f32 v56, v74, s70, v56                               // 00000000353C: D1CB0038 04E08D4A 
	v_fma_f32 v57, v74, s78, v57                               // 000000003544: D1CB0039 04E49D4A 
	v_fma_f32 v56, v75, s71, v56                               // 00000000354C: D1CB0038 04E08F4B 
	v_fma_f32 v57, v75, s79, v57                               // 000000003554: D1CB0039 04E49F4B 
	s_load_dwordx8 s[64:71], s[12:13], s18                     // 00000000355C: C00C1006 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003564: 80121A12 
	s_load_dwordx8 s[72:79], s[12:13], s18                     // 000000003568: C00C1206 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003570: 80121A12 
	v_fma_f32 v58, v68, s80, v58                               // 000000003574: D1CB003A 04E8A144 
	v_fma_f32 v59, v68, s88, v59                               // 00000000357C: D1CB003B 04ECB144 
	v_fma_f32 v58, v69, s81, v58                               // 000000003584: D1CB003A 04E8A345 
	v_fma_f32 v59, v69, s89, v59                               // 00000000358C: D1CB003B 04ECB345 
	v_fma_f32 v58, v70, s82, v58                               // 000000003594: D1CB003A 04E8A546 
	v_fma_f32 v59, v70, s90, v59                               // 00000000359C: D1CB003B 04ECB546 
	v_fma_f32 v58, v71, s83, v58                               // 0000000035A4: D1CB003A 04E8A747 
	v_fma_f32 v59, v71, s91, v59                               // 0000000035AC: D1CB003B 04ECB747 
	v_fma_f32 v58, v72, s84, v58                               // 0000000035B4: D1CB003A 04E8A948 
	v_fma_f32 v59, v72, s92, v59                               // 0000000035BC: D1CB003B 04ECB948 
	v_fma_f32 v58, v73, s85, v58                               // 0000000035C4: D1CB003A 04E8AB49 
	v_fma_f32 v59, v73, s93, v59                               // 0000000035CC: D1CB003B 04ECBB49 
	v_fma_f32 v58, v74, s86, v58                               // 0000000035D4: D1CB003A 04E8AD4A 
	v_fma_f32 v59, v74, s94, v59                               // 0000000035DC: D1CB003B 04ECBD4A 
	v_fma_f32 v58, v75, s87, v58                               // 0000000035E4: D1CB003A 04E8AF4B 
	v_fma_f32 v59, v75, s95, v59                               // 0000000035EC: D1CB003B 04ECBF4B 
	s_load_dwordx8 s[80:87], s[12:13], s18                     // 0000000035F4: C00C1406 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000035FC: 80121A12 
	s_load_dwordx8 s[88:95], s[12:13], s18                     // 000000003600: C00C1606 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003608: 80121A12 
	s_add_u32 s16, s16, 32                                     // 00000000360C: 8010A010 
	s_mov_b32 s18, s16                                         // 000000003610: BE920010 
	s_waitcnt lgkmcnt(0)                                       // 000000003614: BF8CC07F 
	v_fma_f32 v60, v68, s32, v60                               // 000000003618: D1CB003C 04F04144 
	v_fma_f32 v61, v68, s40, v61                               // 000000003620: D1CB003D 04F45144 
	v_fma_f32 v60, v69, s33, v60                               // 000000003628: D1CB003C 04F04345 
	v_fma_f32 v61, v69, s41, v61                               // 000000003630: D1CB003D 04F45345 
	v_fma_f32 v60, v70, s34, v60                               // 000000003638: D1CB003C 04F04546 
	v_fma_f32 v61, v70, s42, v61                               // 000000003640: D1CB003D 04F45546 
	v_fma_f32 v60, v71, s35, v60                               // 000000003648: D1CB003C 04F04747 
	v_fma_f32 v61, v71, s43, v61                               // 000000003650: D1CB003D 04F45747 
	v_fma_f32 v60, v72, s36, v60                               // 000000003658: D1CB003C 04F04948 
	v_fma_f32 v61, v72, s44, v61                               // 000000003660: D1CB003D 04F45948 
	v_fma_f32 v60, v73, s37, v60                               // 000000003668: D1CB003C 04F04B49 
	v_fma_f32 v61, v73, s45, v61                               // 000000003670: D1CB003D 04F45B49 
	v_fma_f32 v60, v74, s38, v60                               // 000000003678: D1CB003C 04F04D4A 
	v_fma_f32 v61, v74, s46, v61                               // 000000003680: D1CB003D 04F45D4A 
	v_fma_f32 v60, v75, s39, v60                               // 000000003688: D1CB003C 04F04F4B 
	v_fma_f32 v61, v75, s47, v61                               // 000000003690: D1CB003D 04F45F4B 
	s_load_dwordx8 s[32:39], s[12:13], s18                     // 000000003698: C00C0806 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000036A0: 80121A12 
	s_load_dwordx8 s[40:47], s[12:13], s18                     // 0000000036A4: C00C0A06 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000036AC: 80121A12 
	v_fma_f32 v62, v68, s48, v62                               // 0000000036B0: D1CB003E 04F86144 
	v_fma_f32 v63, v68, s56, v63                               // 0000000036B8: D1CB003F 04FC7144 
	v_fma_f32 v62, v69, s49, v62                               // 0000000036C0: D1CB003E 04F86345 
	v_fma_f32 v63, v69, s57, v63                               // 0000000036C8: D1CB003F 04FC7345 
	v_fma_f32 v62, v70, s50, v62                               // 0000000036D0: D1CB003E 04F86546 
	v_fma_f32 v63, v70, s58, v63                               // 0000000036D8: D1CB003F 04FC7546 
	v_fma_f32 v62, v71, s51, v62                               // 0000000036E0: D1CB003E 04F86747 
	v_fma_f32 v63, v71, s59, v63                               // 0000000036E8: D1CB003F 04FC7747 
	v_fma_f32 v62, v72, s52, v62                               // 0000000036F0: D1CB003E 04F86948 
	v_fma_f32 v63, v72, s60, v63                               // 0000000036F8: D1CB003F 04FC7948 
	v_fma_f32 v62, v73, s53, v62                               // 000000003700: D1CB003E 04F86B49 
	v_fma_f32 v63, v73, s61, v63                               // 000000003708: D1CB003F 04FC7B49 
	v_fma_f32 v62, v74, s54, v62                               // 000000003710: D1CB003E 04F86D4A 
	v_fma_f32 v63, v74, s62, v63                               // 000000003718: D1CB003F 04FC7D4A 
	v_fma_f32 v62, v75, s55, v62                               // 000000003720: D1CB003E 04F86F4B 
	v_fma_f32 v63, v75, s63, v63                               // 000000003728: D1CB003F 04FC7F4B 
	s_load_dwordx8 s[48:55], s[12:13], s18                     // 000000003730: C00C0C06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003738: 80121A12 
	s_load_dwordx8 s[56:63], s[12:13], s18                     // 00000000373C: C00C0E06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003744: 80121A12 
	v_fma_f32 v64, v68, s64, v64                               // 000000003748: D1CB0040 05008144 
	v_fma_f32 v65, v68, s72, v65                               // 000000003750: D1CB0041 05049144 
	v_fma_f32 v64, v69, s65, v64                               // 000000003758: D1CB0040 05008345 
	v_fma_f32 v65, v69, s73, v65                               // 000000003760: D1CB0041 05049345 
	v_fma_f32 v64, v70, s66, v64                               // 000000003768: D1CB0040 05008546 
	v_fma_f32 v65, v70, s74, v65                               // 000000003770: D1CB0041 05049546 
	v_fma_f32 v64, v71, s67, v64                               // 000000003778: D1CB0040 05008747 
	v_fma_f32 v65, v71, s75, v65                               // 000000003780: D1CB0041 05049747 
	v_fma_f32 v64, v72, s68, v64                               // 000000003788: D1CB0040 05008948 
	v_fma_f32 v65, v72, s76, v65                               // 000000003790: D1CB0041 05049948 
	v_fma_f32 v64, v73, s69, v64                               // 000000003798: D1CB0040 05008B49 
	v_fma_f32 v65, v73, s77, v65                               // 0000000037A0: D1CB0041 05049B49 
	v_fma_f32 v64, v74, s70, v64                               // 0000000037A8: D1CB0040 05008D4A 
	v_fma_f32 v65, v74, s78, v65                               // 0000000037B0: D1CB0041 05049D4A 
	v_fma_f32 v64, v75, s71, v64                               // 0000000037B8: D1CB0040 05008F4B 
	v_fma_f32 v65, v75, s79, v65                               // 0000000037C0: D1CB0041 05049F4B 
	s_load_dwordx8 s[64:71], s[12:13], s18                     // 0000000037C8: C00C1006 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000037D0: 80121A12 
	s_load_dwordx8 s[72:79], s[12:13], s18                     // 0000000037D4: C00C1206 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000037DC: 80121A12 
	v_fma_f32 v66, v68, s80, v66                               // 0000000037E0: D1CB0042 0508A144 
	v_fma_f32 v67, v68, s88, v67                               // 0000000037E8: D1CB0043 050CB144 
	v_fma_f32 v66, v69, s81, v66                               // 0000000037F0: D1CB0042 0508A345 
	v_fma_f32 v67, v69, s89, v67                               // 0000000037F8: D1CB0043 050CB345 
	v_fma_f32 v66, v70, s82, v66                               // 000000003800: D1CB0042 0508A546 
	v_fma_f32 v67, v70, s90, v67                               // 000000003808: D1CB0043 050CB546 
	v_fma_f32 v66, v71, s83, v66                               // 000000003810: D1CB0042 0508A747 
	v_fma_f32 v67, v71, s91, v67                               // 000000003818: D1CB0043 050CB747 
	v_fma_f32 v66, v72, s84, v66                               // 000000003820: D1CB0042 0508A948 
	v_fma_f32 v67, v72, s92, v67                               // 000000003828: D1CB0043 050CB948 
	v_fma_f32 v66, v73, s85, v66                               // 000000003830: D1CB0042 0508AB49 
	v_fma_f32 v67, v73, s93, v67                               // 000000003838: D1CB0043 050CBB49 
	v_fma_f32 v66, v74, s86, v66                               // 000000003840: D1CB0042 0508AD4A 
	v_fma_f32 v67, v74, s94, v67                               // 000000003848: D1CB0043 050CBD4A 
	v_fma_f32 v66, v75, s87, v66                               // 000000003850: D1CB0042 0508AF4B 
	v_fma_f32 v67, v75, s95, v67                               // 000000003858: D1CB0043 050CBF4B 
	s_load_dwordx8 s[80:87], s[12:13], s18                     // 000000003860: C00C1406 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003868: 80121A12 
	s_load_dwordx8 s[88:95], s[12:13], s18                     // 00000000386C: C00C1606 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003874: 80121A12 
	global_load_dwordx4 v[68:71], v[2:3], s[20:21]             // 000000003878: DC5C8000 44140002 
	s_add_u32 s20, s20, 16                                     // 000000003880: 80149014 
	s_addc_u32 s21, s21, 0                                     // 000000003884: 82158015 
	global_load_dwordx4 v[72:75], v[2:3], s[20:21]             // 000000003888: DC5C8000 48140002 
	s_add_u32 s20, s20, 16                                     // 000000003890: 80149014 
	s_addc_u32 s21, s21, 0                                     // 000000003894: 82158015 
	s_waitcnt vmcnt(2)                                         // 000000003898: BF8C0F72 
	s_waitcnt lgkmcnt(0)                                       // 00000000389C: BF8CC07F 
	v_fma_f32 v4, v76, s32, v4                                 // 0000000038A0: D1CB0004 0410414C 
	v_fma_f32 v5, v76, s40, v5                                 // 0000000038A8: D1CB0005 0414514C 
	v_fma_f32 v4, v77, s33, v4                                 // 0000000038B0: D1CB0004 0410434D 
	v_fma_f32 v5, v77, s41, v5                                 // 0000000038B8: D1CB0005 0414534D 
	v_fma_f32 v4, v78, s34, v4                                 // 0000000038C0: D1CB0004 0410454E 
	v_fma_f32 v5, v78, s42, v5                                 // 0000000038C8: D1CB0005 0414554E 
	v_fma_f32 v4, v79, s35, v4                                 // 0000000038D0: D1CB0004 0410474F 
	v_fma_f32 v5, v79, s43, v5                                 // 0000000038D8: D1CB0005 0414574F 
	v_fma_f32 v4, v80, s36, v4                                 // 0000000038E0: D1CB0004 04104950 
	v_fma_f32 v5, v80, s44, v5                                 // 0000000038E8: D1CB0005 04145950 
	v_fma_f32 v4, v81, s37, v4                                 // 0000000038F0: D1CB0004 04104B51 
	v_fma_f32 v5, v81, s45, v5                                 // 0000000038F8: D1CB0005 04145B51 
	v_fma_f32 v4, v82, s38, v4                                 // 000000003900: D1CB0004 04104D52 
	v_fma_f32 v5, v82, s46, v5                                 // 000000003908: D1CB0005 04145D52 
	v_fma_f32 v4, v83, s39, v4                                 // 000000003910: D1CB0004 04104F53 
	v_fma_f32 v5, v83, s47, v5                                 // 000000003918: D1CB0005 04145F53 
	s_load_dwordx8 s[32:39], s[12:13], s18                     // 000000003920: C00C0806 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003928: 80121A12 
	s_load_dwordx8 s[40:47], s[12:13], s18                     // 00000000392C: C00C0A06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003934: 80121A12 
	v_fma_f32 v6, v76, s48, v6                                 // 000000003938: D1CB0006 0418614C 
	v_fma_f32 v7, v76, s56, v7                                 // 000000003940: D1CB0007 041C714C 
	v_fma_f32 v6, v77, s49, v6                                 // 000000003948: D1CB0006 0418634D 
	v_fma_f32 v7, v77, s57, v7                                 // 000000003950: D1CB0007 041C734D 
	v_fma_f32 v6, v78, s50, v6                                 // 000000003958: D1CB0006 0418654E 
	v_fma_f32 v7, v78, s58, v7                                 // 000000003960: D1CB0007 041C754E 
	v_fma_f32 v6, v79, s51, v6                                 // 000000003968: D1CB0006 0418674F 
	v_fma_f32 v7, v79, s59, v7                                 // 000000003970: D1CB0007 041C774F 
	v_fma_f32 v6, v80, s52, v6                                 // 000000003978: D1CB0006 04186950 
	v_fma_f32 v7, v80, s60, v7                                 // 000000003980: D1CB0007 041C7950 
	v_fma_f32 v6, v81, s53, v6                                 // 000000003988: D1CB0006 04186B51 
	v_fma_f32 v7, v81, s61, v7                                 // 000000003990: D1CB0007 041C7B51 
	v_fma_f32 v6, v82, s54, v6                                 // 000000003998: D1CB0006 04186D52 
	v_fma_f32 v7, v82, s62, v7                                 // 0000000039A0: D1CB0007 041C7D52 
	v_fma_f32 v6, v83, s55, v6                                 // 0000000039A8: D1CB0006 04186F53 
	v_fma_f32 v7, v83, s63, v7                                 // 0000000039B0: D1CB0007 041C7F53 
	s_load_dwordx8 s[48:55], s[12:13], s18                     // 0000000039B8: C00C0C06 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000039C0: 80121A12 
	s_load_dwordx8 s[56:63], s[12:13], s18                     // 0000000039C4: C00C0E06 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000039CC: 80121A12 
	v_fma_f32 v8, v76, s64, v8                                 // 0000000039D0: D1CB0008 0420814C 
	v_fma_f32 v9, v76, s72, v9                                 // 0000000039D8: D1CB0009 0424914C 
	v_fma_f32 v8, v77, s65, v8                                 // 0000000039E0: D1CB0008 0420834D 
	v_fma_f32 v9, v77, s73, v9                                 // 0000000039E8: D1CB0009 0424934D 
	v_fma_f32 v8, v78, s66, v8                                 // 0000000039F0: D1CB0008 0420854E 
	v_fma_f32 v9, v78, s74, v9                                 // 0000000039F8: D1CB0009 0424954E 
	v_fma_f32 v8, v79, s67, v8                                 // 000000003A00: D1CB0008 0420874F 
	v_fma_f32 v9, v79, s75, v9                                 // 000000003A08: D1CB0009 0424974F 
	v_fma_f32 v8, v80, s68, v8                                 // 000000003A10: D1CB0008 04208950 
	v_fma_f32 v9, v80, s76, v9                                 // 000000003A18: D1CB0009 04249950 
	v_fma_f32 v8, v81, s69, v8                                 // 000000003A20: D1CB0008 04208B51 
	v_fma_f32 v9, v81, s77, v9                                 // 000000003A28: D1CB0009 04249B51 
	v_fma_f32 v8, v82, s70, v8                                 // 000000003A30: D1CB0008 04208D52 
	v_fma_f32 v9, v82, s78, v9                                 // 000000003A38: D1CB0009 04249D52 
	v_fma_f32 v8, v83, s71, v8                                 // 000000003A40: D1CB0008 04208F53 
	v_fma_f32 v9, v83, s79, v9                                 // 000000003A48: D1CB0009 04249F53 
	s_load_dwordx8 s[64:71], s[12:13], s18                     // 000000003A50: C00C1006 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003A58: 80121A12 
	s_load_dwordx8 s[72:79], s[12:13], s18                     // 000000003A5C: C00C1206 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003A64: 80121A12 
	v_fma_f32 v10, v76, s80, v10                               // 000000003A68: D1CB000A 0428A14C 
	v_fma_f32 v11, v76, s88, v11                               // 000000003A70: D1CB000B 042CB14C 
	v_fma_f32 v10, v77, s81, v10                               // 000000003A78: D1CB000A 0428A34D 
	v_fma_f32 v11, v77, s89, v11                               // 000000003A80: D1CB000B 042CB34D 
	v_fma_f32 v10, v78, s82, v10                               // 000000003A88: D1CB000A 0428A54E 
	v_fma_f32 v11, v78, s90, v11                               // 000000003A90: D1CB000B 042CB54E 
	v_fma_f32 v10, v79, s83, v10                               // 000000003A98: D1CB000A 0428A74F 
	v_fma_f32 v11, v79, s91, v11                               // 000000003AA0: D1CB000B 042CB74F 
	v_fma_f32 v10, v80, s84, v10                               // 000000003AA8: D1CB000A 0428A950 
	v_fma_f32 v11, v80, s92, v11                               // 000000003AB0: D1CB000B 042CB950 
	v_fma_f32 v10, v81, s85, v10                               // 000000003AB8: D1CB000A 0428AB51 
	v_fma_f32 v11, v81, s93, v11                               // 000000003AC0: D1CB000B 042CBB51 
	v_fma_f32 v10, v82, s86, v10                               // 000000003AC8: D1CB000A 0428AD52 
	v_fma_f32 v11, v82, s94, v11                               // 000000003AD0: D1CB000B 042CBD52 
	v_fma_f32 v10, v83, s87, v10                               // 000000003AD8: D1CB000A 0428AF53 
	v_fma_f32 v11, v83, s95, v11                               // 000000003AE0: D1CB000B 042CBF53 
	s_load_dwordx8 s[80:87], s[12:13], s18                     // 000000003AE8: C00C1406 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003AF0: 80121A12 
	s_load_dwordx8 s[88:95], s[12:13], s18                     // 000000003AF4: C00C1606 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003AFC: 80121A12 
	s_waitcnt lgkmcnt(0)                                       // 000000003B00: BF8CC07F 
	v_fma_f32 v12, v76, s32, v12                               // 000000003B04: D1CB000C 0430414C 
	v_fma_f32 v13, v76, s40, v13                               // 000000003B0C: D1CB000D 0434514C 
	v_fma_f32 v12, v77, s33, v12                               // 000000003B14: D1CB000C 0430434D 
	v_fma_f32 v13, v77, s41, v13                               // 000000003B1C: D1CB000D 0434534D 
	v_fma_f32 v12, v78, s34, v12                               // 000000003B24: D1CB000C 0430454E 
	v_fma_f32 v13, v78, s42, v13                               // 000000003B2C: D1CB000D 0434554E 
	v_fma_f32 v12, v79, s35, v12                               // 000000003B34: D1CB000C 0430474F 
	v_fma_f32 v13, v79, s43, v13                               // 000000003B3C: D1CB000D 0434574F 
	v_fma_f32 v12, v80, s36, v12                               // 000000003B44: D1CB000C 04304950 
	v_fma_f32 v13, v80, s44, v13                               // 000000003B4C: D1CB000D 04345950 
	v_fma_f32 v12, v81, s37, v12                               // 000000003B54: D1CB000C 04304B51 
	v_fma_f32 v13, v81, s45, v13                               // 000000003B5C: D1CB000D 04345B51 
	v_fma_f32 v12, v82, s38, v12                               // 000000003B64: D1CB000C 04304D52 
	v_fma_f32 v13, v82, s46, v13                               // 000000003B6C: D1CB000D 04345D52 
	v_fma_f32 v12, v83, s39, v12                               // 000000003B74: D1CB000C 04304F53 
	v_fma_f32 v13, v83, s47, v13                               // 000000003B7C: D1CB000D 04345F53 
	s_load_dwordx8 s[32:39], s[12:13], s18                     // 000000003B84: C00C0806 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003B8C: 80121A12 
	s_load_dwordx8 s[40:47], s[12:13], s18                     // 000000003B90: C00C0A06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003B98: 80121A12 
	v_fma_f32 v14, v76, s48, v14                               // 000000003B9C: D1CB000E 0438614C 
	v_fma_f32 v15, v76, s56, v15                               // 000000003BA4: D1CB000F 043C714C 
	v_fma_f32 v14, v77, s49, v14                               // 000000003BAC: D1CB000E 0438634D 
	v_fma_f32 v15, v77, s57, v15                               // 000000003BB4: D1CB000F 043C734D 
	v_fma_f32 v14, v78, s50, v14                               // 000000003BBC: D1CB000E 0438654E 
	v_fma_f32 v15, v78, s58, v15                               // 000000003BC4: D1CB000F 043C754E 
	v_fma_f32 v14, v79, s51, v14                               // 000000003BCC: D1CB000E 0438674F 
	v_fma_f32 v15, v79, s59, v15                               // 000000003BD4: D1CB000F 043C774F 
	v_fma_f32 v14, v80, s52, v14                               // 000000003BDC: D1CB000E 04386950 
	v_fma_f32 v15, v80, s60, v15                               // 000000003BE4: D1CB000F 043C7950 
	v_fma_f32 v14, v81, s53, v14                               // 000000003BEC: D1CB000E 04386B51 
	v_fma_f32 v15, v81, s61, v15                               // 000000003BF4: D1CB000F 043C7B51 
	v_fma_f32 v14, v82, s54, v14                               // 000000003BFC: D1CB000E 04386D52 
	v_fma_f32 v15, v82, s62, v15                               // 000000003C04: D1CB000F 043C7D52 
	v_fma_f32 v14, v83, s55, v14                               // 000000003C0C: D1CB000E 04386F53 
	v_fma_f32 v15, v83, s63, v15                               // 000000003C14: D1CB000F 043C7F53 
	s_load_dwordx8 s[48:55], s[12:13], s18                     // 000000003C1C: C00C0C06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003C24: 80121A12 
	s_load_dwordx8 s[56:63], s[12:13], s18                     // 000000003C28: C00C0E06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003C30: 80121A12 
	v_fma_f32 v16, v76, s64, v16                               // 000000003C34: D1CB0010 0440814C 
	v_fma_f32 v17, v76, s72, v17                               // 000000003C3C: D1CB0011 0444914C 
	v_fma_f32 v16, v77, s65, v16                               // 000000003C44: D1CB0010 0440834D 
	v_fma_f32 v17, v77, s73, v17                               // 000000003C4C: D1CB0011 0444934D 
	v_fma_f32 v16, v78, s66, v16                               // 000000003C54: D1CB0010 0440854E 
	v_fma_f32 v17, v78, s74, v17                               // 000000003C5C: D1CB0011 0444954E 
	v_fma_f32 v16, v79, s67, v16                               // 000000003C64: D1CB0010 0440874F 
	v_fma_f32 v17, v79, s75, v17                               // 000000003C6C: D1CB0011 0444974F 
	v_fma_f32 v16, v80, s68, v16                               // 000000003C74: D1CB0010 04408950 
	v_fma_f32 v17, v80, s76, v17                               // 000000003C7C: D1CB0011 04449950 
	v_fma_f32 v16, v81, s69, v16                               // 000000003C84: D1CB0010 04408B51 
	v_fma_f32 v17, v81, s77, v17                               // 000000003C8C: D1CB0011 04449B51 
	v_fma_f32 v16, v82, s70, v16                               // 000000003C94: D1CB0010 04408D52 
	v_fma_f32 v17, v82, s78, v17                               // 000000003C9C: D1CB0011 04449D52 
	v_fma_f32 v16, v83, s71, v16                               // 000000003CA4: D1CB0010 04408F53 
	v_fma_f32 v17, v83, s79, v17                               // 000000003CAC: D1CB0011 04449F53 
	s_load_dwordx8 s[64:71], s[12:13], s18                     // 000000003CB4: C00C1006 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003CBC: 80121A12 
	s_load_dwordx8 s[72:79], s[12:13], s18                     // 000000003CC0: C00C1206 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003CC8: 80121A12 
	v_fma_f32 v18, v76, s80, v18                               // 000000003CCC: D1CB0012 0448A14C 
	v_fma_f32 v19, v76, s88, v19                               // 000000003CD4: D1CB0013 044CB14C 
	v_fma_f32 v18, v77, s81, v18                               // 000000003CDC: D1CB0012 0448A34D 
	v_fma_f32 v19, v77, s89, v19                               // 000000003CE4: D1CB0013 044CB34D 
	v_fma_f32 v18, v78, s82, v18                               // 000000003CEC: D1CB0012 0448A54E 
	v_fma_f32 v19, v78, s90, v19                               // 000000003CF4: D1CB0013 044CB54E 
	v_fma_f32 v18, v79, s83, v18                               // 000000003CFC: D1CB0012 0448A74F 
	v_fma_f32 v19, v79, s91, v19                               // 000000003D04: D1CB0013 044CB74F 
	v_fma_f32 v18, v80, s84, v18                               // 000000003D0C: D1CB0012 0448A950 
	v_fma_f32 v19, v80, s92, v19                               // 000000003D14: D1CB0013 044CB950 
	v_fma_f32 v18, v81, s85, v18                               // 000000003D1C: D1CB0012 0448AB51 
	v_fma_f32 v19, v81, s93, v19                               // 000000003D24: D1CB0013 044CBB51 
	v_fma_f32 v18, v82, s86, v18                               // 000000003D2C: D1CB0012 0448AD52 
	v_fma_f32 v19, v82, s94, v19                               // 000000003D34: D1CB0013 044CBD52 
	v_fma_f32 v18, v83, s87, v18                               // 000000003D3C: D1CB0012 0448AF53 
	v_fma_f32 v19, v83, s95, v19                               // 000000003D44: D1CB0013 044CBF53 
	s_load_dwordx8 s[80:87], s[12:13], s18                     // 000000003D4C: C00C1406 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003D54: 80121A12 
	s_load_dwordx8 s[88:95], s[12:13], s18                     // 000000003D58: C00C1606 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003D60: 80121A12 
	s_waitcnt lgkmcnt(0)                                       // 000000003D64: BF8CC07F 
	v_fma_f32 v20, v76, s32, v20                               // 000000003D68: D1CB0014 0450414C 
	v_fma_f32 v21, v76, s40, v21                               // 000000003D70: D1CB0015 0454514C 
	v_fma_f32 v20, v77, s33, v20                               // 000000003D78: D1CB0014 0450434D 
	v_fma_f32 v21, v77, s41, v21                               // 000000003D80: D1CB0015 0454534D 
	v_fma_f32 v20, v78, s34, v20                               // 000000003D88: D1CB0014 0450454E 
	v_fma_f32 v21, v78, s42, v21                               // 000000003D90: D1CB0015 0454554E 
	v_fma_f32 v20, v79, s35, v20                               // 000000003D98: D1CB0014 0450474F 
	v_fma_f32 v21, v79, s43, v21                               // 000000003DA0: D1CB0015 0454574F 
	v_fma_f32 v20, v80, s36, v20                               // 000000003DA8: D1CB0014 04504950 
	v_fma_f32 v21, v80, s44, v21                               // 000000003DB0: D1CB0015 04545950 
	v_fma_f32 v20, v81, s37, v20                               // 000000003DB8: D1CB0014 04504B51 
	v_fma_f32 v21, v81, s45, v21                               // 000000003DC0: D1CB0015 04545B51 
	v_fma_f32 v20, v82, s38, v20                               // 000000003DC8: D1CB0014 04504D52 
	v_fma_f32 v21, v82, s46, v21                               // 000000003DD0: D1CB0015 04545D52 
	v_fma_f32 v20, v83, s39, v20                               // 000000003DD8: D1CB0014 04504F53 
	v_fma_f32 v21, v83, s47, v21                               // 000000003DE0: D1CB0015 04545F53 
	s_load_dwordx8 s[32:39], s[12:13], s18                     // 000000003DE8: C00C0806 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003DF0: 80121A12 
	s_load_dwordx8 s[40:47], s[12:13], s18                     // 000000003DF4: C00C0A06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003DFC: 80121A12 
	v_fma_f32 v22, v76, s48, v22                               // 000000003E00: D1CB0016 0458614C 
	v_fma_f32 v23, v76, s56, v23                               // 000000003E08: D1CB0017 045C714C 
	v_fma_f32 v22, v77, s49, v22                               // 000000003E10: D1CB0016 0458634D 
	v_fma_f32 v23, v77, s57, v23                               // 000000003E18: D1CB0017 045C734D 
	v_fma_f32 v22, v78, s50, v22                               // 000000003E20: D1CB0016 0458654E 
	v_fma_f32 v23, v78, s58, v23                               // 000000003E28: D1CB0017 045C754E 
	v_fma_f32 v22, v79, s51, v22                               // 000000003E30: D1CB0016 0458674F 
	v_fma_f32 v23, v79, s59, v23                               // 000000003E38: D1CB0017 045C774F 
	v_fma_f32 v22, v80, s52, v22                               // 000000003E40: D1CB0016 04586950 
	v_fma_f32 v23, v80, s60, v23                               // 000000003E48: D1CB0017 045C7950 
	v_fma_f32 v22, v81, s53, v22                               // 000000003E50: D1CB0016 04586B51 
	v_fma_f32 v23, v81, s61, v23                               // 000000003E58: D1CB0017 045C7B51 
	v_fma_f32 v22, v82, s54, v22                               // 000000003E60: D1CB0016 04586D52 
	v_fma_f32 v23, v82, s62, v23                               // 000000003E68: D1CB0017 045C7D52 
	v_fma_f32 v22, v83, s55, v22                               // 000000003E70: D1CB0016 04586F53 
	v_fma_f32 v23, v83, s63, v23                               // 000000003E78: D1CB0017 045C7F53 
	s_load_dwordx8 s[48:55], s[12:13], s18                     // 000000003E80: C00C0C06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003E88: 80121A12 
	s_load_dwordx8 s[56:63], s[12:13], s18                     // 000000003E8C: C00C0E06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003E94: 80121A12 
	v_fma_f32 v24, v76, s64, v24                               // 000000003E98: D1CB0018 0460814C 
	v_fma_f32 v25, v76, s72, v25                               // 000000003EA0: D1CB0019 0464914C 
	v_fma_f32 v24, v77, s65, v24                               // 000000003EA8: D1CB0018 0460834D 
	v_fma_f32 v25, v77, s73, v25                               // 000000003EB0: D1CB0019 0464934D 
	v_fma_f32 v24, v78, s66, v24                               // 000000003EB8: D1CB0018 0460854E 
	v_fma_f32 v25, v78, s74, v25                               // 000000003EC0: D1CB0019 0464954E 
	v_fma_f32 v24, v79, s67, v24                               // 000000003EC8: D1CB0018 0460874F 
	v_fma_f32 v25, v79, s75, v25                               // 000000003ED0: D1CB0019 0464974F 
	v_fma_f32 v24, v80, s68, v24                               // 000000003ED8: D1CB0018 04608950 
	v_fma_f32 v25, v80, s76, v25                               // 000000003EE0: D1CB0019 04649950 
	v_fma_f32 v24, v81, s69, v24                               // 000000003EE8: D1CB0018 04608B51 
	v_fma_f32 v25, v81, s77, v25                               // 000000003EF0: D1CB0019 04649B51 
	v_fma_f32 v24, v82, s70, v24                               // 000000003EF8: D1CB0018 04608D52 
	v_fma_f32 v25, v82, s78, v25                               // 000000003F00: D1CB0019 04649D52 
	v_fma_f32 v24, v83, s71, v24                               // 000000003F08: D1CB0018 04608F53 
	v_fma_f32 v25, v83, s79, v25                               // 000000003F10: D1CB0019 04649F53 
	s_load_dwordx8 s[64:71], s[12:13], s18                     // 000000003F18: C00C1006 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003F20: 80121A12 
	s_load_dwordx8 s[72:79], s[12:13], s18                     // 000000003F24: C00C1206 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003F2C: 80121A12 
	v_fma_f32 v26, v76, s80, v26                               // 000000003F30: D1CB001A 0468A14C 
	v_fma_f32 v27, v76, s88, v27                               // 000000003F38: D1CB001B 046CB14C 
	v_fma_f32 v26, v77, s81, v26                               // 000000003F40: D1CB001A 0468A34D 
	v_fma_f32 v27, v77, s89, v27                               // 000000003F48: D1CB001B 046CB34D 
	v_fma_f32 v26, v78, s82, v26                               // 000000003F50: D1CB001A 0468A54E 
	v_fma_f32 v27, v78, s90, v27                               // 000000003F58: D1CB001B 046CB54E 
	v_fma_f32 v26, v79, s83, v26                               // 000000003F60: D1CB001A 0468A74F 
	v_fma_f32 v27, v79, s91, v27                               // 000000003F68: D1CB001B 046CB74F 
	v_fma_f32 v26, v80, s84, v26                               // 000000003F70: D1CB001A 0468A950 
	v_fma_f32 v27, v80, s92, v27                               // 000000003F78: D1CB001B 046CB950 
	v_fma_f32 v26, v81, s85, v26                               // 000000003F80: D1CB001A 0468AB51 
	v_fma_f32 v27, v81, s93, v27                               // 000000003F88: D1CB001B 046CBB51 
	v_fma_f32 v26, v82, s86, v26                               // 000000003F90: D1CB001A 0468AD52 
	v_fma_f32 v27, v82, s94, v27                               // 000000003F98: D1CB001B 046CBD52 
	v_fma_f32 v26, v83, s87, v26                               // 000000003FA0: D1CB001A 0468AF53 
	v_fma_f32 v27, v83, s95, v27                               // 000000003FA8: D1CB001B 046CBF53 
	s_load_dwordx8 s[80:87], s[12:13], s18                     // 000000003FB0: C00C1406 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003FB8: 80121A12 
	s_load_dwordx8 s[88:95], s[12:13], s18                     // 000000003FBC: C00C1606 00000012 
	s_add_u32 s18, s18, s26                                    // 000000003FC4: 80121A12 
	s_waitcnt lgkmcnt(0)                                       // 000000003FC8: BF8CC07F 
	v_fma_f32 v28, v76, s32, v28                               // 000000003FCC: D1CB001C 0470414C 
	v_fma_f32 v29, v76, s40, v29                               // 000000003FD4: D1CB001D 0474514C 
	v_fma_f32 v28, v77, s33, v28                               // 000000003FDC: D1CB001C 0470434D 
	v_fma_f32 v29, v77, s41, v29                               // 000000003FE4: D1CB001D 0474534D 
	v_fma_f32 v28, v78, s34, v28                               // 000000003FEC: D1CB001C 0470454E 
	v_fma_f32 v29, v78, s42, v29                               // 000000003FF4: D1CB001D 0474554E 
	v_fma_f32 v28, v79, s35, v28                               // 000000003FFC: D1CB001C 0470474F 
	v_fma_f32 v29, v79, s43, v29                               // 000000004004: D1CB001D 0474574F 
	v_fma_f32 v28, v80, s36, v28                               // 00000000400C: D1CB001C 04704950 
	v_fma_f32 v29, v80, s44, v29                               // 000000004014: D1CB001D 04745950 
	v_fma_f32 v28, v81, s37, v28                               // 00000000401C: D1CB001C 04704B51 
	v_fma_f32 v29, v81, s45, v29                               // 000000004024: D1CB001D 04745B51 
	v_fma_f32 v28, v82, s38, v28                               // 00000000402C: D1CB001C 04704D52 
	v_fma_f32 v29, v82, s46, v29                               // 000000004034: D1CB001D 04745D52 
	v_fma_f32 v28, v83, s39, v28                               // 00000000403C: D1CB001C 04704F53 
	v_fma_f32 v29, v83, s47, v29                               // 000000004044: D1CB001D 04745F53 
	s_load_dwordx8 s[32:39], s[12:13], s18                     // 00000000404C: C00C0806 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004054: 80121A12 
	s_load_dwordx8 s[40:47], s[12:13], s18                     // 000000004058: C00C0A06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004060: 80121A12 
	v_fma_f32 v30, v76, s48, v30                               // 000000004064: D1CB001E 0478614C 
	v_fma_f32 v31, v76, s56, v31                               // 00000000406C: D1CB001F 047C714C 
	v_fma_f32 v30, v77, s49, v30                               // 000000004074: D1CB001E 0478634D 
	v_fma_f32 v31, v77, s57, v31                               // 00000000407C: D1CB001F 047C734D 
	v_fma_f32 v30, v78, s50, v30                               // 000000004084: D1CB001E 0478654E 
	v_fma_f32 v31, v78, s58, v31                               // 00000000408C: D1CB001F 047C754E 
	v_fma_f32 v30, v79, s51, v30                               // 000000004094: D1CB001E 0478674F 
	v_fma_f32 v31, v79, s59, v31                               // 00000000409C: D1CB001F 047C774F 
	v_fma_f32 v30, v80, s52, v30                               // 0000000040A4: D1CB001E 04786950 
	v_fma_f32 v31, v80, s60, v31                               // 0000000040AC: D1CB001F 047C7950 
	v_fma_f32 v30, v81, s53, v30                               // 0000000040B4: D1CB001E 04786B51 
	v_fma_f32 v31, v81, s61, v31                               // 0000000040BC: D1CB001F 047C7B51 
	v_fma_f32 v30, v82, s54, v30                               // 0000000040C4: D1CB001E 04786D52 
	v_fma_f32 v31, v82, s62, v31                               // 0000000040CC: D1CB001F 047C7D52 
	v_fma_f32 v30, v83, s55, v30                               // 0000000040D4: D1CB001E 04786F53 
	v_fma_f32 v31, v83, s63, v31                               // 0000000040DC: D1CB001F 047C7F53 
	s_load_dwordx8 s[48:55], s[12:13], s18                     // 0000000040E4: C00C0C06 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000040EC: 80121A12 
	s_load_dwordx8 s[56:63], s[12:13], s18                     // 0000000040F0: C00C0E06 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000040F8: 80121A12 
	v_fma_f32 v32, v76, s64, v32                               // 0000000040FC: D1CB0020 0480814C 
	v_fma_f32 v33, v76, s72, v33                               // 000000004104: D1CB0021 0484914C 
	v_fma_f32 v32, v77, s65, v32                               // 00000000410C: D1CB0020 0480834D 
	v_fma_f32 v33, v77, s73, v33                               // 000000004114: D1CB0021 0484934D 
	v_fma_f32 v32, v78, s66, v32                               // 00000000411C: D1CB0020 0480854E 
	v_fma_f32 v33, v78, s74, v33                               // 000000004124: D1CB0021 0484954E 
	v_fma_f32 v32, v79, s67, v32                               // 00000000412C: D1CB0020 0480874F 
	v_fma_f32 v33, v79, s75, v33                               // 000000004134: D1CB0021 0484974F 
	v_fma_f32 v32, v80, s68, v32                               // 00000000413C: D1CB0020 04808950 
	v_fma_f32 v33, v80, s76, v33                               // 000000004144: D1CB0021 04849950 
	v_fma_f32 v32, v81, s69, v32                               // 00000000414C: D1CB0020 04808B51 
	v_fma_f32 v33, v81, s77, v33                               // 000000004154: D1CB0021 04849B51 
	v_fma_f32 v32, v82, s70, v32                               // 00000000415C: D1CB0020 04808D52 
	v_fma_f32 v33, v82, s78, v33                               // 000000004164: D1CB0021 04849D52 
	v_fma_f32 v32, v83, s71, v32                               // 00000000416C: D1CB0020 04808F53 
	v_fma_f32 v33, v83, s79, v33                               // 000000004174: D1CB0021 04849F53 
	s_load_dwordx8 s[64:71], s[12:13], s18                     // 00000000417C: C00C1006 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004184: 80121A12 
	s_load_dwordx8 s[72:79], s[12:13], s18                     // 000000004188: C00C1206 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004190: 80121A12 
	v_fma_f32 v34, v76, s80, v34                               // 000000004194: D1CB0022 0488A14C 
	v_fma_f32 v35, v76, s88, v35                               // 00000000419C: D1CB0023 048CB14C 
	v_fma_f32 v34, v77, s81, v34                               // 0000000041A4: D1CB0022 0488A34D 
	v_fma_f32 v35, v77, s89, v35                               // 0000000041AC: D1CB0023 048CB34D 
	v_fma_f32 v34, v78, s82, v34                               // 0000000041B4: D1CB0022 0488A54E 
	v_fma_f32 v35, v78, s90, v35                               // 0000000041BC: D1CB0023 048CB54E 
	v_fma_f32 v34, v79, s83, v34                               // 0000000041C4: D1CB0022 0488A74F 
	v_fma_f32 v35, v79, s91, v35                               // 0000000041CC: D1CB0023 048CB74F 
	v_fma_f32 v34, v80, s84, v34                               // 0000000041D4: D1CB0022 0488A950 
	v_fma_f32 v35, v80, s92, v35                               // 0000000041DC: D1CB0023 048CB950 
	v_fma_f32 v34, v81, s85, v34                               // 0000000041E4: D1CB0022 0488AB51 
	v_fma_f32 v35, v81, s93, v35                               // 0000000041EC: D1CB0023 048CBB51 
	v_fma_f32 v34, v82, s86, v34                               // 0000000041F4: D1CB0022 0488AD52 
	v_fma_f32 v35, v82, s94, v35                               // 0000000041FC: D1CB0023 048CBD52 
	v_fma_f32 v34, v83, s87, v34                               // 000000004204: D1CB0022 0488AF53 
	v_fma_f32 v35, v83, s95, v35                               // 00000000420C: D1CB0023 048CBF53 
	s_load_dwordx8 s[80:87], s[12:13], s18                     // 000000004214: C00C1406 00000012 
	s_add_u32 s18, s18, s26                                    // 00000000421C: 80121A12 
	s_load_dwordx8 s[88:95], s[12:13], s18                     // 000000004220: C00C1606 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004228: 80121A12 
	s_waitcnt lgkmcnt(0)                                       // 00000000422C: BF8CC07F 
	v_fma_f32 v36, v76, s32, v36                               // 000000004230: D1CB0024 0490414C 
	v_fma_f32 v37, v76, s40, v37                               // 000000004238: D1CB0025 0494514C 
	v_fma_f32 v36, v77, s33, v36                               // 000000004240: D1CB0024 0490434D 
	v_fma_f32 v37, v77, s41, v37                               // 000000004248: D1CB0025 0494534D 
	v_fma_f32 v36, v78, s34, v36                               // 000000004250: D1CB0024 0490454E 
	v_fma_f32 v37, v78, s42, v37                               // 000000004258: D1CB0025 0494554E 
	v_fma_f32 v36, v79, s35, v36                               // 000000004260: D1CB0024 0490474F 
	v_fma_f32 v37, v79, s43, v37                               // 000000004268: D1CB0025 0494574F 
	v_fma_f32 v36, v80, s36, v36                               // 000000004270: D1CB0024 04904950 
	v_fma_f32 v37, v80, s44, v37                               // 000000004278: D1CB0025 04945950 
	v_fma_f32 v36, v81, s37, v36                               // 000000004280: D1CB0024 04904B51 
	v_fma_f32 v37, v81, s45, v37                               // 000000004288: D1CB0025 04945B51 
	v_fma_f32 v36, v82, s38, v36                               // 000000004290: D1CB0024 04904D52 
	v_fma_f32 v37, v82, s46, v37                               // 000000004298: D1CB0025 04945D52 
	v_fma_f32 v36, v83, s39, v36                               // 0000000042A0: D1CB0024 04904F53 
	v_fma_f32 v37, v83, s47, v37                               // 0000000042A8: D1CB0025 04945F53 
	s_load_dwordx8 s[32:39], s[12:13], s18                     // 0000000042B0: C00C0806 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000042B8: 80121A12 
	s_load_dwordx8 s[40:47], s[12:13], s18                     // 0000000042BC: C00C0A06 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000042C4: 80121A12 
	v_fma_f32 v38, v76, s48, v38                               // 0000000042C8: D1CB0026 0498614C 
	v_fma_f32 v39, v76, s56, v39                               // 0000000042D0: D1CB0027 049C714C 
	v_fma_f32 v38, v77, s49, v38                               // 0000000042D8: D1CB0026 0498634D 
	v_fma_f32 v39, v77, s57, v39                               // 0000000042E0: D1CB0027 049C734D 
	v_fma_f32 v38, v78, s50, v38                               // 0000000042E8: D1CB0026 0498654E 
	v_fma_f32 v39, v78, s58, v39                               // 0000000042F0: D1CB0027 049C754E 
	v_fma_f32 v38, v79, s51, v38                               // 0000000042F8: D1CB0026 0498674F 
	v_fma_f32 v39, v79, s59, v39                               // 000000004300: D1CB0027 049C774F 
	v_fma_f32 v38, v80, s52, v38                               // 000000004308: D1CB0026 04986950 
	v_fma_f32 v39, v80, s60, v39                               // 000000004310: D1CB0027 049C7950 
	v_fma_f32 v38, v81, s53, v38                               // 000000004318: D1CB0026 04986B51 
	v_fma_f32 v39, v81, s61, v39                               // 000000004320: D1CB0027 049C7B51 
	v_fma_f32 v38, v82, s54, v38                               // 000000004328: D1CB0026 04986D52 
	v_fma_f32 v39, v82, s62, v39                               // 000000004330: D1CB0027 049C7D52 
	v_fma_f32 v38, v83, s55, v38                               // 000000004338: D1CB0026 04986F53 
	v_fma_f32 v39, v83, s63, v39                               // 000000004340: D1CB0027 049C7F53 
	s_load_dwordx8 s[48:55], s[12:13], s18                     // 000000004348: C00C0C06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004350: 80121A12 
	s_load_dwordx8 s[56:63], s[12:13], s18                     // 000000004354: C00C0E06 00000012 
	s_add_u32 s18, s18, s26                                    // 00000000435C: 80121A12 
	v_fma_f32 v40, v76, s64, v40                               // 000000004360: D1CB0028 04A0814C 
	v_fma_f32 v41, v76, s72, v41                               // 000000004368: D1CB0029 04A4914C 
	v_fma_f32 v40, v77, s65, v40                               // 000000004370: D1CB0028 04A0834D 
	v_fma_f32 v41, v77, s73, v41                               // 000000004378: D1CB0029 04A4934D 
	v_fma_f32 v40, v78, s66, v40                               // 000000004380: D1CB0028 04A0854E 
	v_fma_f32 v41, v78, s74, v41                               // 000000004388: D1CB0029 04A4954E 
	v_fma_f32 v40, v79, s67, v40                               // 000000004390: D1CB0028 04A0874F 
	v_fma_f32 v41, v79, s75, v41                               // 000000004398: D1CB0029 04A4974F 
	v_fma_f32 v40, v80, s68, v40                               // 0000000043A0: D1CB0028 04A08950 
	v_fma_f32 v41, v80, s76, v41                               // 0000000043A8: D1CB0029 04A49950 
	v_fma_f32 v40, v81, s69, v40                               // 0000000043B0: D1CB0028 04A08B51 
	v_fma_f32 v41, v81, s77, v41                               // 0000000043B8: D1CB0029 04A49B51 
	v_fma_f32 v40, v82, s70, v40                               // 0000000043C0: D1CB0028 04A08D52 
	v_fma_f32 v41, v82, s78, v41                               // 0000000043C8: D1CB0029 04A49D52 
	v_fma_f32 v40, v83, s71, v40                               // 0000000043D0: D1CB0028 04A08F53 
	v_fma_f32 v41, v83, s79, v41                               // 0000000043D8: D1CB0029 04A49F53 
	s_load_dwordx8 s[64:71], s[12:13], s18                     // 0000000043E0: C00C1006 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000043E8: 80121A12 
	s_load_dwordx8 s[72:79], s[12:13], s18                     // 0000000043EC: C00C1206 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000043F4: 80121A12 
	v_fma_f32 v42, v76, s80, v42                               // 0000000043F8: D1CB002A 04A8A14C 
	v_fma_f32 v43, v76, s88, v43                               // 000000004400: D1CB002B 04ACB14C 
	v_fma_f32 v42, v77, s81, v42                               // 000000004408: D1CB002A 04A8A34D 
	v_fma_f32 v43, v77, s89, v43                               // 000000004410: D1CB002B 04ACB34D 
	v_fma_f32 v42, v78, s82, v42                               // 000000004418: D1CB002A 04A8A54E 
	v_fma_f32 v43, v78, s90, v43                               // 000000004420: D1CB002B 04ACB54E 
	v_fma_f32 v42, v79, s83, v42                               // 000000004428: D1CB002A 04A8A74F 
	v_fma_f32 v43, v79, s91, v43                               // 000000004430: D1CB002B 04ACB74F 
	v_fma_f32 v42, v80, s84, v42                               // 000000004438: D1CB002A 04A8A950 
	v_fma_f32 v43, v80, s92, v43                               // 000000004440: D1CB002B 04ACB950 
	v_fma_f32 v42, v81, s85, v42                               // 000000004448: D1CB002A 04A8AB51 
	v_fma_f32 v43, v81, s93, v43                               // 000000004450: D1CB002B 04ACBB51 
	v_fma_f32 v42, v82, s86, v42                               // 000000004458: D1CB002A 04A8AD52 
	v_fma_f32 v43, v82, s94, v43                               // 000000004460: D1CB002B 04ACBD52 
	v_fma_f32 v42, v83, s87, v42                               // 000000004468: D1CB002A 04A8AF53 
	v_fma_f32 v43, v83, s95, v43                               // 000000004470: D1CB002B 04ACBF53 
	s_load_dwordx8 s[80:87], s[12:13], s18                     // 000000004478: C00C1406 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004480: 80121A12 
	s_load_dwordx8 s[88:95], s[12:13], s18                     // 000000004484: C00C1606 00000012 
	s_add_u32 s18, s18, s26                                    // 00000000448C: 80121A12 
	s_waitcnt lgkmcnt(0)                                       // 000000004490: BF8CC07F 
	v_fma_f32 v44, v76, s32, v44                               // 000000004494: D1CB002C 04B0414C 
	v_fma_f32 v45, v76, s40, v45                               // 00000000449C: D1CB002D 04B4514C 
	v_fma_f32 v44, v77, s33, v44                               // 0000000044A4: D1CB002C 04B0434D 
	v_fma_f32 v45, v77, s41, v45                               // 0000000044AC: D1CB002D 04B4534D 
	v_fma_f32 v44, v78, s34, v44                               // 0000000044B4: D1CB002C 04B0454E 
	v_fma_f32 v45, v78, s42, v45                               // 0000000044BC: D1CB002D 04B4554E 
	v_fma_f32 v44, v79, s35, v44                               // 0000000044C4: D1CB002C 04B0474F 
	v_fma_f32 v45, v79, s43, v45                               // 0000000044CC: D1CB002D 04B4574F 
	v_fma_f32 v44, v80, s36, v44                               // 0000000044D4: D1CB002C 04B04950 
	v_fma_f32 v45, v80, s44, v45                               // 0000000044DC: D1CB002D 04B45950 
	v_fma_f32 v44, v81, s37, v44                               // 0000000044E4: D1CB002C 04B04B51 
	v_fma_f32 v45, v81, s45, v45                               // 0000000044EC: D1CB002D 04B45B51 
	v_fma_f32 v44, v82, s38, v44                               // 0000000044F4: D1CB002C 04B04D52 
	v_fma_f32 v45, v82, s46, v45                               // 0000000044FC: D1CB002D 04B45D52 
	v_fma_f32 v44, v83, s39, v44                               // 000000004504: D1CB002C 04B04F53 
	v_fma_f32 v45, v83, s47, v45                               // 00000000450C: D1CB002D 04B45F53 
	s_load_dwordx8 s[32:39], s[12:13], s18                     // 000000004514: C00C0806 00000012 
	s_add_u32 s18, s18, s26                                    // 00000000451C: 80121A12 
	s_load_dwordx8 s[40:47], s[12:13], s18                     // 000000004520: C00C0A06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004528: 80121A12 
	v_fma_f32 v46, v76, s48, v46                               // 00000000452C: D1CB002E 04B8614C 
	v_fma_f32 v47, v76, s56, v47                               // 000000004534: D1CB002F 04BC714C 
	v_fma_f32 v46, v77, s49, v46                               // 00000000453C: D1CB002E 04B8634D 
	v_fma_f32 v47, v77, s57, v47                               // 000000004544: D1CB002F 04BC734D 
	v_fma_f32 v46, v78, s50, v46                               // 00000000454C: D1CB002E 04B8654E 
	v_fma_f32 v47, v78, s58, v47                               // 000000004554: D1CB002F 04BC754E 
	v_fma_f32 v46, v79, s51, v46                               // 00000000455C: D1CB002E 04B8674F 
	v_fma_f32 v47, v79, s59, v47                               // 000000004564: D1CB002F 04BC774F 
	v_fma_f32 v46, v80, s52, v46                               // 00000000456C: D1CB002E 04B86950 
	v_fma_f32 v47, v80, s60, v47                               // 000000004574: D1CB002F 04BC7950 
	v_fma_f32 v46, v81, s53, v46                               // 00000000457C: D1CB002E 04B86B51 
	v_fma_f32 v47, v81, s61, v47                               // 000000004584: D1CB002F 04BC7B51 
	v_fma_f32 v46, v82, s54, v46                               // 00000000458C: D1CB002E 04B86D52 
	v_fma_f32 v47, v82, s62, v47                               // 000000004594: D1CB002F 04BC7D52 
	v_fma_f32 v46, v83, s55, v46                               // 00000000459C: D1CB002E 04B86F53 
	v_fma_f32 v47, v83, s63, v47                               // 0000000045A4: D1CB002F 04BC7F53 
	s_load_dwordx8 s[48:55], s[12:13], s18                     // 0000000045AC: C00C0C06 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000045B4: 80121A12 
	s_load_dwordx8 s[56:63], s[12:13], s18                     // 0000000045B8: C00C0E06 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000045C0: 80121A12 
	v_fma_f32 v48, v76, s64, v48                               // 0000000045C4: D1CB0030 04C0814C 
	v_fma_f32 v49, v76, s72, v49                               // 0000000045CC: D1CB0031 04C4914C 
	v_fma_f32 v48, v77, s65, v48                               // 0000000045D4: D1CB0030 04C0834D 
	v_fma_f32 v49, v77, s73, v49                               // 0000000045DC: D1CB0031 04C4934D 
	v_fma_f32 v48, v78, s66, v48                               // 0000000045E4: D1CB0030 04C0854E 
	v_fma_f32 v49, v78, s74, v49                               // 0000000045EC: D1CB0031 04C4954E 
	v_fma_f32 v48, v79, s67, v48                               // 0000000045F4: D1CB0030 04C0874F 
	v_fma_f32 v49, v79, s75, v49                               // 0000000045FC: D1CB0031 04C4974F 
	v_fma_f32 v48, v80, s68, v48                               // 000000004604: D1CB0030 04C08950 
	v_fma_f32 v49, v80, s76, v49                               // 00000000460C: D1CB0031 04C49950 
	v_fma_f32 v48, v81, s69, v48                               // 000000004614: D1CB0030 04C08B51 
	v_fma_f32 v49, v81, s77, v49                               // 00000000461C: D1CB0031 04C49B51 
	v_fma_f32 v48, v82, s70, v48                               // 000000004624: D1CB0030 04C08D52 
	v_fma_f32 v49, v82, s78, v49                               // 00000000462C: D1CB0031 04C49D52 
	v_fma_f32 v48, v83, s71, v48                               // 000000004634: D1CB0030 04C08F53 
	v_fma_f32 v49, v83, s79, v49                               // 00000000463C: D1CB0031 04C49F53 
	s_load_dwordx8 s[64:71], s[12:13], s18                     // 000000004644: C00C1006 00000012 
	s_add_u32 s18, s18, s26                                    // 00000000464C: 80121A12 
	s_load_dwordx8 s[72:79], s[12:13], s18                     // 000000004650: C00C1206 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004658: 80121A12 
	v_fma_f32 v50, v76, s80, v50                               // 00000000465C: D1CB0032 04C8A14C 
	v_fma_f32 v51, v76, s88, v51                               // 000000004664: D1CB0033 04CCB14C 
	v_fma_f32 v50, v77, s81, v50                               // 00000000466C: D1CB0032 04C8A34D 
	v_fma_f32 v51, v77, s89, v51                               // 000000004674: D1CB0033 04CCB34D 
	v_fma_f32 v50, v78, s82, v50                               // 00000000467C: D1CB0032 04C8A54E 
	v_fma_f32 v51, v78, s90, v51                               // 000000004684: D1CB0033 04CCB54E 
	v_fma_f32 v50, v79, s83, v50                               // 00000000468C: D1CB0032 04C8A74F 
	v_fma_f32 v51, v79, s91, v51                               // 000000004694: D1CB0033 04CCB74F 
	v_fma_f32 v50, v80, s84, v50                               // 00000000469C: D1CB0032 04C8A950 
	v_fma_f32 v51, v80, s92, v51                               // 0000000046A4: D1CB0033 04CCB950 
	v_fma_f32 v50, v81, s85, v50                               // 0000000046AC: D1CB0032 04C8AB51 
	v_fma_f32 v51, v81, s93, v51                               // 0000000046B4: D1CB0033 04CCBB51 
	v_fma_f32 v50, v82, s86, v50                               // 0000000046BC: D1CB0032 04C8AD52 
	v_fma_f32 v51, v82, s94, v51                               // 0000000046C4: D1CB0033 04CCBD52 
	v_fma_f32 v50, v83, s87, v50                               // 0000000046CC: D1CB0032 04C8AF53 
	v_fma_f32 v51, v83, s95, v51                               // 0000000046D4: D1CB0033 04CCBF53 
	s_load_dwordx8 s[80:87], s[12:13], s18                     // 0000000046DC: C00C1406 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000046E4: 80121A12 
	s_load_dwordx8 s[88:95], s[12:13], s18                     // 0000000046E8: C00C1606 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000046F0: 80121A12 
	s_waitcnt lgkmcnt(0)                                       // 0000000046F4: BF8CC07F 
	v_fma_f32 v52, v76, s32, v52                               // 0000000046F8: D1CB0034 04D0414C 
	v_fma_f32 v53, v76, s40, v53                               // 000000004700: D1CB0035 04D4514C 
	v_fma_f32 v52, v77, s33, v52                               // 000000004708: D1CB0034 04D0434D 
	v_fma_f32 v53, v77, s41, v53                               // 000000004710: D1CB0035 04D4534D 
	v_fma_f32 v52, v78, s34, v52                               // 000000004718: D1CB0034 04D0454E 
	v_fma_f32 v53, v78, s42, v53                               // 000000004720: D1CB0035 04D4554E 
	v_fma_f32 v52, v79, s35, v52                               // 000000004728: D1CB0034 04D0474F 
	v_fma_f32 v53, v79, s43, v53                               // 000000004730: D1CB0035 04D4574F 
	v_fma_f32 v52, v80, s36, v52                               // 000000004738: D1CB0034 04D04950 
	v_fma_f32 v53, v80, s44, v53                               // 000000004740: D1CB0035 04D45950 
	v_fma_f32 v52, v81, s37, v52                               // 000000004748: D1CB0034 04D04B51 
	v_fma_f32 v53, v81, s45, v53                               // 000000004750: D1CB0035 04D45B51 
	v_fma_f32 v52, v82, s38, v52                               // 000000004758: D1CB0034 04D04D52 
	v_fma_f32 v53, v82, s46, v53                               // 000000004760: D1CB0035 04D45D52 
	v_fma_f32 v52, v83, s39, v52                               // 000000004768: D1CB0034 04D04F53 
	v_fma_f32 v53, v83, s47, v53                               // 000000004770: D1CB0035 04D45F53 
	s_load_dwordx8 s[32:39], s[12:13], s18                     // 000000004778: C00C0806 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004780: 80121A12 
	s_load_dwordx8 s[40:47], s[12:13], s18                     // 000000004784: C00C0A06 00000012 
	s_add_u32 s18, s18, s26                                    // 00000000478C: 80121A12 
	v_fma_f32 v54, v76, s48, v54                               // 000000004790: D1CB0036 04D8614C 
	v_fma_f32 v55, v76, s56, v55                               // 000000004798: D1CB0037 04DC714C 
	v_fma_f32 v54, v77, s49, v54                               // 0000000047A0: D1CB0036 04D8634D 
	v_fma_f32 v55, v77, s57, v55                               // 0000000047A8: D1CB0037 04DC734D 
	v_fma_f32 v54, v78, s50, v54                               // 0000000047B0: D1CB0036 04D8654E 
	v_fma_f32 v55, v78, s58, v55                               // 0000000047B8: D1CB0037 04DC754E 
	v_fma_f32 v54, v79, s51, v54                               // 0000000047C0: D1CB0036 04D8674F 
	v_fma_f32 v55, v79, s59, v55                               // 0000000047C8: D1CB0037 04DC774F 
	v_fma_f32 v54, v80, s52, v54                               // 0000000047D0: D1CB0036 04D86950 
	v_fma_f32 v55, v80, s60, v55                               // 0000000047D8: D1CB0037 04DC7950 
	v_fma_f32 v54, v81, s53, v54                               // 0000000047E0: D1CB0036 04D86B51 
	v_fma_f32 v55, v81, s61, v55                               // 0000000047E8: D1CB0037 04DC7B51 
	v_fma_f32 v54, v82, s54, v54                               // 0000000047F0: D1CB0036 04D86D52 
	v_fma_f32 v55, v82, s62, v55                               // 0000000047F8: D1CB0037 04DC7D52 
	v_fma_f32 v54, v83, s55, v54                               // 000000004800: D1CB0036 04D86F53 
	v_fma_f32 v55, v83, s63, v55                               // 000000004808: D1CB0037 04DC7F53 
	s_load_dwordx8 s[48:55], s[12:13], s18                     // 000000004810: C00C0C06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004818: 80121A12 
	s_load_dwordx8 s[56:63], s[12:13], s18                     // 00000000481C: C00C0E06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004824: 80121A12 
	v_fma_f32 v56, v76, s64, v56                               // 000000004828: D1CB0038 04E0814C 
	v_fma_f32 v57, v76, s72, v57                               // 000000004830: D1CB0039 04E4914C 
	v_fma_f32 v56, v77, s65, v56                               // 000000004838: D1CB0038 04E0834D 
	v_fma_f32 v57, v77, s73, v57                               // 000000004840: D1CB0039 04E4934D 
	v_fma_f32 v56, v78, s66, v56                               // 000000004848: D1CB0038 04E0854E 
	v_fma_f32 v57, v78, s74, v57                               // 000000004850: D1CB0039 04E4954E 
	v_fma_f32 v56, v79, s67, v56                               // 000000004858: D1CB0038 04E0874F 
	v_fma_f32 v57, v79, s75, v57                               // 000000004860: D1CB0039 04E4974F 
	v_fma_f32 v56, v80, s68, v56                               // 000000004868: D1CB0038 04E08950 
	v_fma_f32 v57, v80, s76, v57                               // 000000004870: D1CB0039 04E49950 
	v_fma_f32 v56, v81, s69, v56                               // 000000004878: D1CB0038 04E08B51 
	v_fma_f32 v57, v81, s77, v57                               // 000000004880: D1CB0039 04E49B51 
	v_fma_f32 v56, v82, s70, v56                               // 000000004888: D1CB0038 04E08D52 
	v_fma_f32 v57, v82, s78, v57                               // 000000004890: D1CB0039 04E49D52 
	v_fma_f32 v56, v83, s71, v56                               // 000000004898: D1CB0038 04E08F53 
	v_fma_f32 v57, v83, s79, v57                               // 0000000048A0: D1CB0039 04E49F53 
	s_load_dwordx8 s[64:71], s[12:13], s18                     // 0000000048A8: C00C1006 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000048B0: 80121A12 
	s_load_dwordx8 s[72:79], s[12:13], s18                     // 0000000048B4: C00C1206 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000048BC: 80121A12 
	v_fma_f32 v58, v76, s80, v58                               // 0000000048C0: D1CB003A 04E8A14C 
	v_fma_f32 v59, v76, s88, v59                               // 0000000048C8: D1CB003B 04ECB14C 
	v_fma_f32 v58, v77, s81, v58                               // 0000000048D0: D1CB003A 04E8A34D 
	v_fma_f32 v59, v77, s89, v59                               // 0000000048D8: D1CB003B 04ECB34D 
	v_fma_f32 v58, v78, s82, v58                               // 0000000048E0: D1CB003A 04E8A54E 
	v_fma_f32 v59, v78, s90, v59                               // 0000000048E8: D1CB003B 04ECB54E 
	v_fma_f32 v58, v79, s83, v58                               // 0000000048F0: D1CB003A 04E8A74F 
	v_fma_f32 v59, v79, s91, v59                               // 0000000048F8: D1CB003B 04ECB74F 
	v_fma_f32 v58, v80, s84, v58                               // 000000004900: D1CB003A 04E8A950 
	v_fma_f32 v59, v80, s92, v59                               // 000000004908: D1CB003B 04ECB950 
	v_fma_f32 v58, v81, s85, v58                               // 000000004910: D1CB003A 04E8AB51 
	v_fma_f32 v59, v81, s93, v59                               // 000000004918: D1CB003B 04ECBB51 
	v_fma_f32 v58, v82, s86, v58                               // 000000004920: D1CB003A 04E8AD52 
	v_fma_f32 v59, v82, s94, v59                               // 000000004928: D1CB003B 04ECBD52 
	v_fma_f32 v58, v83, s87, v58                               // 000000004930: D1CB003A 04E8AF53 
	v_fma_f32 v59, v83, s95, v59                               // 000000004938: D1CB003B 04ECBF53 
	s_load_dwordx8 s[80:87], s[12:13], s18                     // 000000004940: C00C1406 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004948: 80121A12 
	s_load_dwordx8 s[88:95], s[12:13], s18                     // 00000000494C: C00C1606 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004954: 80121A12 
	s_add_u32 s16, s16, 32                                     // 000000004958: 8010A010 
	s_mov_b32 s18, s16                                         // 00000000495C: BE920010 
	s_waitcnt lgkmcnt(0)                                       // 000000004960: BF8CC07F 
	v_fma_f32 v60, v76, s32, v60                               // 000000004964: D1CB003C 04F0414C 
	v_fma_f32 v61, v76, s40, v61                               // 00000000496C: D1CB003D 04F4514C 
	v_fma_f32 v60, v77, s33, v60                               // 000000004974: D1CB003C 04F0434D 
	v_fma_f32 v61, v77, s41, v61                               // 00000000497C: D1CB003D 04F4534D 
	v_fma_f32 v60, v78, s34, v60                               // 000000004984: D1CB003C 04F0454E 
	v_fma_f32 v61, v78, s42, v61                               // 00000000498C: D1CB003D 04F4554E 
	v_fma_f32 v60, v79, s35, v60                               // 000000004994: D1CB003C 04F0474F 
	v_fma_f32 v61, v79, s43, v61                               // 00000000499C: D1CB003D 04F4574F 
	v_fma_f32 v60, v80, s36, v60                               // 0000000049A4: D1CB003C 04F04950 
	v_fma_f32 v61, v80, s44, v61                               // 0000000049AC: D1CB003D 04F45950 
	v_fma_f32 v60, v81, s37, v60                               // 0000000049B4: D1CB003C 04F04B51 
	v_fma_f32 v61, v81, s45, v61                               // 0000000049BC: D1CB003D 04F45B51 
	v_fma_f32 v60, v82, s38, v60                               // 0000000049C4: D1CB003C 04F04D52 
	v_fma_f32 v61, v82, s46, v61                               // 0000000049CC: D1CB003D 04F45D52 
	v_fma_f32 v60, v83, s39, v60                               // 0000000049D4: D1CB003C 04F04F53 
	v_fma_f32 v61, v83, s47, v61                               // 0000000049DC: D1CB003D 04F45F53 
	s_load_dwordx8 s[32:39], s[12:13], s18                     // 0000000049E4: C00C0806 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000049EC: 80121A12 
	s_load_dwordx8 s[40:47], s[12:13], s18                     // 0000000049F0: C00C0A06 00000012 
	s_add_u32 s18, s18, s26                                    // 0000000049F8: 80121A12 
	v_fma_f32 v62, v76, s48, v62                               // 0000000049FC: D1CB003E 04F8614C 
	v_fma_f32 v63, v76, s56, v63                               // 000000004A04: D1CB003F 04FC714C 
	v_fma_f32 v62, v77, s49, v62                               // 000000004A0C: D1CB003E 04F8634D 
	v_fma_f32 v63, v77, s57, v63                               // 000000004A14: D1CB003F 04FC734D 
	v_fma_f32 v62, v78, s50, v62                               // 000000004A1C: D1CB003E 04F8654E 
	v_fma_f32 v63, v78, s58, v63                               // 000000004A24: D1CB003F 04FC754E 
	v_fma_f32 v62, v79, s51, v62                               // 000000004A2C: D1CB003E 04F8674F 
	v_fma_f32 v63, v79, s59, v63                               // 000000004A34: D1CB003F 04FC774F 
	v_fma_f32 v62, v80, s52, v62                               // 000000004A3C: D1CB003E 04F86950 
	v_fma_f32 v63, v80, s60, v63                               // 000000004A44: D1CB003F 04FC7950 
	v_fma_f32 v62, v81, s53, v62                               // 000000004A4C: D1CB003E 04F86B51 
	v_fma_f32 v63, v81, s61, v63                               // 000000004A54: D1CB003F 04FC7B51 
	v_fma_f32 v62, v82, s54, v62                               // 000000004A5C: D1CB003E 04F86D52 
	v_fma_f32 v63, v82, s62, v63                               // 000000004A64: D1CB003F 04FC7D52 
	v_fma_f32 v62, v83, s55, v62                               // 000000004A6C: D1CB003E 04F86F53 
	v_fma_f32 v63, v83, s63, v63                               // 000000004A74: D1CB003F 04FC7F53 
	s_load_dwordx8 s[48:55], s[12:13], s18                     // 000000004A7C: C00C0C06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004A84: 80121A12 
	s_load_dwordx8 s[56:63], s[12:13], s18                     // 000000004A88: C00C0E06 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004A90: 80121A12 
	v_fma_f32 v64, v76, s64, v64                               // 000000004A94: D1CB0040 0500814C 
	v_fma_f32 v65, v76, s72, v65                               // 000000004A9C: D1CB0041 0504914C 
	v_fma_f32 v64, v77, s65, v64                               // 000000004AA4: D1CB0040 0500834D 
	v_fma_f32 v65, v77, s73, v65                               // 000000004AAC: D1CB0041 0504934D 
	v_fma_f32 v64, v78, s66, v64                               // 000000004AB4: D1CB0040 0500854E 
	v_fma_f32 v65, v78, s74, v65                               // 000000004ABC: D1CB0041 0504954E 
	v_fma_f32 v64, v79, s67, v64                               // 000000004AC4: D1CB0040 0500874F 
	v_fma_f32 v65, v79, s75, v65                               // 000000004ACC: D1CB0041 0504974F 
	v_fma_f32 v64, v80, s68, v64                               // 000000004AD4: D1CB0040 05008950 
	v_fma_f32 v65, v80, s76, v65                               // 000000004ADC: D1CB0041 05049950 
	v_fma_f32 v64, v81, s69, v64                               // 000000004AE4: D1CB0040 05008B51 
	v_fma_f32 v65, v81, s77, v65                               // 000000004AEC: D1CB0041 05049B51 
	v_fma_f32 v64, v82, s70, v64                               // 000000004AF4: D1CB0040 05008D52 
	v_fma_f32 v65, v82, s78, v65                               // 000000004AFC: D1CB0041 05049D52 
	v_fma_f32 v64, v83, s71, v64                               // 000000004B04: D1CB0040 05008F53 
	v_fma_f32 v65, v83, s79, v65                               // 000000004B0C: D1CB0041 05049F53 
	s_load_dwordx8 s[64:71], s[12:13], s18                     // 000000004B14: C00C1006 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004B1C: 80121A12 
	s_load_dwordx8 s[72:79], s[12:13], s18                     // 000000004B20: C00C1206 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004B28: 80121A12 
	v_fma_f32 v66, v76, s80, v66                               // 000000004B2C: D1CB0042 0508A14C 
	v_fma_f32 v67, v76, s88, v67                               // 000000004B34: D1CB0043 050CB14C 
	v_fma_f32 v66, v77, s81, v66                               // 000000004B3C: D1CB0042 0508A34D 
	v_fma_f32 v67, v77, s89, v67                               // 000000004B44: D1CB0043 050CB34D 
	v_fma_f32 v66, v78, s82, v66                               // 000000004B4C: D1CB0042 0508A54E 
	v_fma_f32 v67, v78, s90, v67                               // 000000004B54: D1CB0043 050CB54E 
	v_fma_f32 v66, v79, s83, v66                               // 000000004B5C: D1CB0042 0508A74F 
	v_fma_f32 v67, v79, s91, v67                               // 000000004B64: D1CB0043 050CB74F 
	v_fma_f32 v66, v80, s84, v66                               // 000000004B6C: D1CB0042 0508A950 
	v_fma_f32 v67, v80, s92, v67                               // 000000004B74: D1CB0043 050CB950 
	v_fma_f32 v66, v81, s85, v66                               // 000000004B7C: D1CB0042 0508AB51 
	v_fma_f32 v67, v81, s93, v67                               // 000000004B84: D1CB0043 050CBB51 
	v_fma_f32 v66, v82, s86, v66                               // 000000004B8C: D1CB0042 0508AD52 
	v_fma_f32 v67, v82, s94, v67                               // 000000004B94: D1CB0043 050CBD52 
	v_fma_f32 v66, v83, s87, v66                               // 000000004B9C: D1CB0042 0508AF53 
	v_fma_f32 v67, v83, s95, v67                               // 000000004BA4: D1CB0043 050CBF53 
	s_load_dwordx8 s[80:87], s[12:13], s18                     // 000000004BAC: C00C1406 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004BB4: 80121A12 
	s_load_dwordx8 s[88:95], s[12:13], s18                     // 000000004BB8: C00C1606 00000012 
	s_add_u32 s18, s18, s26                                    // 000000004BC0: 80121A12 
	s_add_u32 s28, s28, 16                                     // 000000004BC4: 801C901C 
	s_cmp_ge_u32 s28, s10                                      // 000000004BC8: BF090A1C 
	s_cbranch_scc0 label_major_loop_begin                      // 000000004BCC: BF84F657 

	s_waitcnt lgkmcnt(0)                                       // 000000004BD0: BF8CC07F 
	s_load_dwordx2 s[20:21], s[4:5], 0x18                      // 000000004BD4: C0060502 00000018 
	s_load_dword s24, s[4:5], 0x34                             // 000000004BDC: C0020602 00000034 
	s_load_dwordx2 s[26:27], s[4:5], 0x38                      // 000000004BE4: C0060682 00000038 
	s_lshl_b32 s32, s7, 6                                      // 000000004BEC: 8E208607 
	s_lshl_b32 s34, s6, 8                                      // 000000004BF0: 8E228806 
	v_mov_b32_e32 v2, v0                                       // 000000004BF4: 7E040300 
	v_add_i32 v2, s34, v2                                      // 000000004BF8: D29C0002 00020422 
	v_lshlrev_b32_e32 v2, 2, v2                                // 000000004C00: 24040482 
	v_mov_b32_e32 v3, 0                                        // 000000004C04: 7E060280 
	s_waitcnt lgkmcnt(0)                                       // 000000004C08: BF8CC07F 
	s_mul_i32 s24, s24, 4                                      // 000000004C0C: 92188418 
	s_mul_i32 s22, s32, s24                                    // 000000004C10: 92161820 
	s_mul_hi_u32 s23, s32, s24                                 // 000000004C14: 96171820 
	s_add_u32 s22, s22, s20                                    // 000000004C18: 80161416 
	s_addc_u32 s23, s23, s21                                   // 000000004C1C: 82171517 
	s_mov_b32 s20, s22                                         // 000000004C20: BE940016 
	s_mov_b32 s21, s23                                         // 000000004C24: BE950017 
	global_load_dword v68, v[2:3], s[22:23]                    // 000000004C28: DC508000 44160002 
	s_add_u32 s22, s22, s24                                    // 000000004C30: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004C34: 82178017 
	global_load_dword v69, v[2:3], s[22:23]                    // 000000004C38: DC508000 45160002 
	s_add_u32 s22, s22, s24                                    // 000000004C40: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004C44: 82178017 
	global_load_dword v70, v[2:3], s[22:23]                    // 000000004C48: DC508000 46160002 
	s_add_u32 s22, s22, s24                                    // 000000004C50: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004C54: 82178017 
	global_load_dword v71, v[2:3], s[22:23]                    // 000000004C58: DC508000 47160002 
	s_add_u32 s22, s22, s24                                    // 000000004C60: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004C64: 82178017 
	global_load_dword v72, v[2:3], s[22:23]                    // 000000004C68: DC508000 48160002 
	s_add_u32 s22, s22, s24                                    // 000000004C70: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004C74: 82178017 
	global_load_dword v73, v[2:3], s[22:23]                    // 000000004C78: DC508000 49160002 
	s_add_u32 s22, s22, s24                                    // 000000004C80: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004C84: 82178017 
	global_load_dword v74, v[2:3], s[22:23]                    // 000000004C88: DC508000 4A160002 
	s_add_u32 s22, s22, s24                                    // 000000004C90: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004C94: 82178017 
	global_load_dword v75, v[2:3], s[22:23]                    // 000000004C98: DC508000 4B160002 
	s_add_u32 s22, s22, s24                                    // 000000004CA0: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004CA4: 82178017 
	global_load_dword v76, v[2:3], s[22:23]                    // 000000004CA8: DC508000 4C160002 
	s_add_u32 s22, s22, s24                                    // 000000004CB0: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004CB4: 82178017 
	global_load_dword v77, v[2:3], s[22:23]                    // 000000004CB8: DC508000 4D160002 
	s_add_u32 s22, s22, s24                                    // 000000004CC0: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004CC4: 82178017 
	global_load_dword v78, v[2:3], s[22:23]                    // 000000004CC8: DC508000 4E160002 
	s_add_u32 s22, s22, s24                                    // 000000004CD0: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004CD4: 82178017 
	global_load_dword v79, v[2:3], s[22:23]                    // 000000004CD8: DC508000 4F160002 
	s_add_u32 s22, s22, s24                                    // 000000004CE0: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004CE4: 82178017 
	global_load_dword v80, v[2:3], s[22:23]                    // 000000004CE8: DC508000 50160002 
	s_add_u32 s22, s22, s24                                    // 000000004CF0: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004CF4: 82178017 
	global_load_dword v81, v[2:3], s[22:23]                    // 000000004CF8: DC508000 51160002 
	s_add_u32 s22, s22, s24                                    // 000000004D00: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004D04: 82178017 
	global_load_dword v82, v[2:3], s[22:23]                    // 000000004D08: DC508000 52160002 
	s_add_u32 s22, s22, s24                                    // 000000004D10: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004D14: 82178017 
	global_load_dword v83, v[2:3], s[22:23]                    // 000000004D18: DC508000 53160002 
	s_add_u32 s22, s22, s24                                    // 000000004D20: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004D24: 82178017 
	s_waitcnt vmcnt(15)                                        // 000000004D28: BF8C0F7F 
	v_fma_f32 v4, s27, v68, v4                                 // 000000004D2C: D1CB0004 0412881B 
	global_load_dword v68, v[2:3], s[22:23]                    // 000000004D34: DC508000 44160002 
	global_store_dword v[2:3], v4, s[20:21]                    // 000000004D3C: DC708000 00140402 
	s_add_u32 s22, s22, s24                                    // 000000004D44: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004D48: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000004D4C: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000004D50: 82158015 
	s_waitcnt vmcnt(16)                                        // 000000004D54: BF8C4F70 
	v_fma_f32 v5, s27, v69, v5                                 // 000000004D58: D1CB0005 04168A1B 
	global_load_dword v69, v[2:3], s[22:23]                    // 000000004D60: DC508000 45160002 
	global_store_dword v[2:3], v5, s[20:21]                    // 000000004D68: DC708000 00140502 
	s_add_u32 s22, s22, s24                                    // 000000004D70: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004D74: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000004D78: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000004D7C: 82158015 
	s_waitcnt vmcnt(17)                                        // 000000004D80: BF8C4F71 
	v_fma_f32 v6, s27, v70, v6                                 // 000000004D84: D1CB0006 041A8C1B 
	global_load_dword v70, v[2:3], s[22:23]                    // 000000004D8C: DC508000 46160002 
	global_store_dword v[2:3], v6, s[20:21]                    // 000000004D94: DC708000 00140602 
	s_add_u32 s22, s22, s24                                    // 000000004D9C: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004DA0: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000004DA4: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000004DA8: 82158015 
	s_waitcnt vmcnt(18)                                        // 000000004DAC: BF8C4F72 
	v_fma_f32 v7, s27, v71, v7                                 // 000000004DB0: D1CB0007 041E8E1B 
	global_load_dword v71, v[2:3], s[22:23]                    // 000000004DB8: DC508000 47160002 
	global_store_dword v[2:3], v7, s[20:21]                    // 000000004DC0: DC708000 00140702 
	s_add_u32 s22, s22, s24                                    // 000000004DC8: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004DCC: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000004DD0: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000004DD4: 82158015 
	s_waitcnt vmcnt(19)                                        // 000000004DD8: BF8C4F73 
	v_fma_f32 v8, s27, v72, v8                                 // 000000004DDC: D1CB0008 0422901B 
	global_load_dword v72, v[2:3], s[22:23]                    // 000000004DE4: DC508000 48160002 
	global_store_dword v[2:3], v8, s[20:21]                    // 000000004DEC: DC708000 00140802 
	s_add_u32 s22, s22, s24                                    // 000000004DF4: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004DF8: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000004DFC: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000004E00: 82158015 
	s_waitcnt vmcnt(20)                                        // 000000004E04: BF8C4F74 
	v_fma_f32 v9, s27, v73, v9                                 // 000000004E08: D1CB0009 0426921B 
	global_load_dword v73, v[2:3], s[22:23]                    // 000000004E10: DC508000 49160002 
	global_store_dword v[2:3], v9, s[20:21]                    // 000000004E18: DC708000 00140902 
	s_add_u32 s22, s22, s24                                    // 000000004E20: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004E24: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000004E28: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000004E2C: 82158015 
	s_waitcnt vmcnt(21)                                        // 000000004E30: BF8C4F75 
	v_fma_f32 v10, s27, v74, v10                               // 000000004E34: D1CB000A 042A941B 
	global_load_dword v74, v[2:3], s[22:23]                    // 000000004E3C: DC508000 4A160002 
	global_store_dword v[2:3], v10, s[20:21]                   // 000000004E44: DC708000 00140A02 
	s_add_u32 s22, s22, s24                                    // 000000004E4C: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004E50: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000004E54: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000004E58: 82158015 
	s_waitcnt vmcnt(22)                                        // 000000004E5C: BF8C4F76 
	v_fma_f32 v11, s27, v75, v11                               // 000000004E60: D1CB000B 042E961B 
	global_load_dword v75, v[2:3], s[22:23]                    // 000000004E68: DC508000 4B160002 
	global_store_dword v[2:3], v11, s[20:21]                   // 000000004E70: DC708000 00140B02 
	s_add_u32 s22, s22, s24                                    // 000000004E78: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004E7C: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000004E80: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000004E84: 82158015 
	s_waitcnt vmcnt(23)                                        // 000000004E88: BF8C4F77 
	v_fma_f32 v12, s27, v76, v12                               // 000000004E8C: D1CB000C 0432981B 
	global_load_dword v76, v[2:3], s[22:23]                    // 000000004E94: DC508000 4C160002 
	global_store_dword v[2:3], v12, s[20:21]                   // 000000004E9C: DC708000 00140C02 
	s_add_u32 s22, s22, s24                                    // 000000004EA4: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004EA8: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000004EAC: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000004EB0: 82158015 
	s_waitcnt vmcnt(24)                                        // 000000004EB4: BF8C4F78 
	v_fma_f32 v13, s27, v77, v13                               // 000000004EB8: D1CB000D 04369A1B 
	global_load_dword v77, v[2:3], s[22:23]                    // 000000004EC0: DC508000 4D160002 
	global_store_dword v[2:3], v13, s[20:21]                   // 000000004EC8: DC708000 00140D02 
	s_add_u32 s22, s22, s24                                    // 000000004ED0: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004ED4: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000004ED8: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000004EDC: 82158015 
	s_waitcnt vmcnt(25)                                        // 000000004EE0: BF8C4F79 
	v_fma_f32 v14, s27, v78, v14                               // 000000004EE4: D1CB000E 043A9C1B 
	global_load_dword v78, v[2:3], s[22:23]                    // 000000004EEC: DC508000 4E160002 
	global_store_dword v[2:3], v14, s[20:21]                   // 000000004EF4: DC708000 00140E02 
	s_add_u32 s22, s22, s24                                    // 000000004EFC: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004F00: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000004F04: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000004F08: 82158015 
	s_waitcnt vmcnt(26)                                        // 000000004F0C: BF8C4F7A 
	v_fma_f32 v15, s27, v79, v15                               // 000000004F10: D1CB000F 043E9E1B 
	global_load_dword v79, v[2:3], s[22:23]                    // 000000004F18: DC508000 4F160002 
	global_store_dword v[2:3], v15, s[20:21]                   // 000000004F20: DC708000 00140F02 
	s_add_u32 s22, s22, s24                                    // 000000004F28: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004F2C: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000004F30: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000004F34: 82158015 
	s_waitcnt vmcnt(27)                                        // 000000004F38: BF8C4F7B 
	v_fma_f32 v16, s27, v80, v16                               // 000000004F3C: D1CB0010 0442A01B 
	global_load_dword v80, v[2:3], s[22:23]                    // 000000004F44: DC508000 50160002 
	global_store_dword v[2:3], v16, s[20:21]                   // 000000004F4C: DC708000 00141002 
	s_add_u32 s22, s22, s24                                    // 000000004F54: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004F58: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000004F5C: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000004F60: 82158015 
	s_waitcnt vmcnt(28)                                        // 000000004F64: BF8C4F7C 
	v_fma_f32 v17, s27, v81, v17                               // 000000004F68: D1CB0011 0446A21B 
	global_load_dword v81, v[2:3], s[22:23]                    // 000000004F70: DC508000 51160002 
	global_store_dword v[2:3], v17, s[20:21]                   // 000000004F78: DC708000 00141102 
	s_add_u32 s22, s22, s24                                    // 000000004F80: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004F84: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000004F88: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000004F8C: 82158015 
	s_waitcnt vmcnt(29)                                        // 000000004F90: BF8C4F7D 
	v_fma_f32 v18, s27, v82, v18                               // 000000004F94: D1CB0012 044AA41B 
	global_load_dword v82, v[2:3], s[22:23]                    // 000000004F9C: DC508000 52160002 
	global_store_dword v[2:3], v18, s[20:21]                   // 000000004FA4: DC708000 00141202 
	s_add_u32 s22, s22, s24                                    // 000000004FAC: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004FB0: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000004FB4: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000004FB8: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000004FBC: BF8C4F7E 
	v_fma_f32 v19, s27, v83, v19                               // 000000004FC0: D1CB0013 044EA61B 
	global_load_dword v83, v[2:3], s[22:23]                    // 000000004FC8: DC508000 53160002 
	global_store_dword v[2:3], v19, s[20:21]                   // 000000004FD0: DC708000 00141302 
	s_add_u32 s22, s22, s24                                    // 000000004FD8: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000004FDC: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000004FE0: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000004FE4: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000004FE8: BF8C4F7E 
	v_fma_f32 v20, s27, v68, v20                               // 000000004FEC: D1CB0014 0452881B 
	global_load_dword v68, v[2:3], s[22:23]                    // 000000004FF4: DC508000 44160002 
	global_store_dword v[2:3], v20, s[20:21]                   // 000000004FFC: DC708000 00141402 
	s_add_u32 s22, s22, s24                                    // 000000005004: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000005008: 82178017 
	s_add_u32 s20, s20, s24                                    // 00000000500C: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005010: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005014: BF8C4F7E 
	v_fma_f32 v21, s27, v69, v21                               // 000000005018: D1CB0015 04568A1B 
	global_load_dword v69, v[2:3], s[22:23]                    // 000000005020: DC508000 45160002 
	global_store_dword v[2:3], v21, s[20:21]                   // 000000005028: DC708000 00141502 
	s_add_u32 s22, s22, s24                                    // 000000005030: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000005034: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000005038: 80141814 
	s_addc_u32 s21, s21, 0                                     // 00000000503C: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005040: BF8C4F7E 
	v_fma_f32 v22, s27, v70, v22                               // 000000005044: D1CB0016 045A8C1B 
	global_load_dword v70, v[2:3], s[22:23]                    // 00000000504C: DC508000 46160002 
	global_store_dword v[2:3], v22, s[20:21]                   // 000000005054: DC708000 00141602 
	s_add_u32 s22, s22, s24                                    // 00000000505C: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000005060: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000005064: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005068: 82158015 
	s_waitcnt vmcnt(30)                                        // 00000000506C: BF8C4F7E 
	v_fma_f32 v23, s27, v71, v23                               // 000000005070: D1CB0017 045E8E1B 
	global_load_dword v71, v[2:3], s[22:23]                    // 000000005078: DC508000 47160002 
	global_store_dword v[2:3], v23, s[20:21]                   // 000000005080: DC708000 00141702 
	s_add_u32 s22, s22, s24                                    // 000000005088: 80161816 
	s_addc_u32 s23, s23, 0                                     // 00000000508C: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000005090: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005094: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005098: BF8C4F7E 
	v_fma_f32 v24, s27, v72, v24                               // 00000000509C: D1CB0018 0462901B 
	global_load_dword v72, v[2:3], s[22:23]                    // 0000000050A4: DC508000 48160002 
	global_store_dword v[2:3], v24, s[20:21]                   // 0000000050AC: DC708000 00141802 
	s_add_u32 s22, s22, s24                                    // 0000000050B4: 80161816 
	s_addc_u32 s23, s23, 0                                     // 0000000050B8: 82178017 
	s_add_u32 s20, s20, s24                                    // 0000000050BC: 80141814 
	s_addc_u32 s21, s21, 0                                     // 0000000050C0: 82158015 
	s_waitcnt vmcnt(30)                                        // 0000000050C4: BF8C4F7E 
	v_fma_f32 v25, s27, v73, v25                               // 0000000050C8: D1CB0019 0466921B 
	global_load_dword v73, v[2:3], s[22:23]                    // 0000000050D0: DC508000 49160002 
	global_store_dword v[2:3], v25, s[20:21]                   // 0000000050D8: DC708000 00141902 
	s_add_u32 s22, s22, s24                                    // 0000000050E0: 80161816 
	s_addc_u32 s23, s23, 0                                     // 0000000050E4: 82178017 
	s_add_u32 s20, s20, s24                                    // 0000000050E8: 80141814 
	s_addc_u32 s21, s21, 0                                     // 0000000050EC: 82158015 
	s_waitcnt vmcnt(30)                                        // 0000000050F0: BF8C4F7E 
	v_fma_f32 v26, s27, v74, v26                               // 0000000050F4: D1CB001A 046A941B 
	global_load_dword v74, v[2:3], s[22:23]                    // 0000000050FC: DC508000 4A160002 
	global_store_dword v[2:3], v26, s[20:21]                   // 000000005104: DC708000 00141A02 
	s_add_u32 s22, s22, s24                                    // 00000000510C: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000005110: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000005114: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005118: 82158015 
	s_waitcnt vmcnt(30)                                        // 00000000511C: BF8C4F7E 
	v_fma_f32 v27, s27, v75, v27                               // 000000005120: D1CB001B 046E961B 
	global_load_dword v75, v[2:3], s[22:23]                    // 000000005128: DC508000 4B160002 
	global_store_dword v[2:3], v27, s[20:21]                   // 000000005130: DC708000 00141B02 
	s_add_u32 s22, s22, s24                                    // 000000005138: 80161816 
	s_addc_u32 s23, s23, 0                                     // 00000000513C: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000005140: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005144: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005148: BF8C4F7E 
	v_fma_f32 v28, s27, v76, v28                               // 00000000514C: D1CB001C 0472981B 
	global_load_dword v76, v[2:3], s[22:23]                    // 000000005154: DC508000 4C160002 
	global_store_dword v[2:3], v28, s[20:21]                   // 00000000515C: DC708000 00141C02 
	s_add_u32 s22, s22, s24                                    // 000000005164: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000005168: 82178017 
	s_add_u32 s20, s20, s24                                    // 00000000516C: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005170: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005174: BF8C4F7E 
	v_fma_f32 v29, s27, v77, v29                               // 000000005178: D1CB001D 04769A1B 
	global_load_dword v77, v[2:3], s[22:23]                    // 000000005180: DC508000 4D160002 
	global_store_dword v[2:3], v29, s[20:21]                   // 000000005188: DC708000 00141D02 
	s_add_u32 s22, s22, s24                                    // 000000005190: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000005194: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000005198: 80141814 
	s_addc_u32 s21, s21, 0                                     // 00000000519C: 82158015 
	s_waitcnt vmcnt(30)                                        // 0000000051A0: BF8C4F7E 
	v_fma_f32 v30, s27, v78, v30                               // 0000000051A4: D1CB001E 047A9C1B 
	global_load_dword v78, v[2:3], s[22:23]                    // 0000000051AC: DC508000 4E160002 
	global_store_dword v[2:3], v30, s[20:21]                   // 0000000051B4: DC708000 00141E02 
	s_add_u32 s22, s22, s24                                    // 0000000051BC: 80161816 
	s_addc_u32 s23, s23, 0                                     // 0000000051C0: 82178017 
	s_add_u32 s20, s20, s24                                    // 0000000051C4: 80141814 
	s_addc_u32 s21, s21, 0                                     // 0000000051C8: 82158015 
	s_waitcnt vmcnt(30)                                        // 0000000051CC: BF8C4F7E 
	v_fma_f32 v31, s27, v79, v31                               // 0000000051D0: D1CB001F 047E9E1B 
	global_load_dword v79, v[2:3], s[22:23]                    // 0000000051D8: DC508000 4F160002 
	global_store_dword v[2:3], v31, s[20:21]                   // 0000000051E0: DC708000 00141F02 
	s_add_u32 s22, s22, s24                                    // 0000000051E8: 80161816 
	s_addc_u32 s23, s23, 0                                     // 0000000051EC: 82178017 
	s_add_u32 s20, s20, s24                                    // 0000000051F0: 80141814 
	s_addc_u32 s21, s21, 0                                     // 0000000051F4: 82158015 
	s_waitcnt vmcnt(30)                                        // 0000000051F8: BF8C4F7E 
	v_fma_f32 v32, s27, v80, v32                               // 0000000051FC: D1CB0020 0482A01B 
	global_load_dword v80, v[2:3], s[22:23]                    // 000000005204: DC508000 50160002 
	global_store_dword v[2:3], v32, s[20:21]                   // 00000000520C: DC708000 00142002 
	s_add_u32 s22, s22, s24                                    // 000000005214: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000005218: 82178017 
	s_add_u32 s20, s20, s24                                    // 00000000521C: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005220: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005224: BF8C4F7E 
	v_fma_f32 v33, s27, v81, v33                               // 000000005228: D1CB0021 0486A21B 
	global_load_dword v81, v[2:3], s[22:23]                    // 000000005230: DC508000 51160002 
	global_store_dword v[2:3], v33, s[20:21]                   // 000000005238: DC708000 00142102 
	s_add_u32 s22, s22, s24                                    // 000000005240: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000005244: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000005248: 80141814 
	s_addc_u32 s21, s21, 0                                     // 00000000524C: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005250: BF8C4F7E 
	v_fma_f32 v34, s27, v82, v34                               // 000000005254: D1CB0022 048AA41B 
	global_load_dword v82, v[2:3], s[22:23]                    // 00000000525C: DC508000 52160002 
	global_store_dword v[2:3], v34, s[20:21]                   // 000000005264: DC708000 00142202 
	s_add_u32 s22, s22, s24                                    // 00000000526C: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000005270: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000005274: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005278: 82158015 
	s_waitcnt vmcnt(30)                                        // 00000000527C: BF8C4F7E 
	v_fma_f32 v35, s27, v83, v35                               // 000000005280: D1CB0023 048EA61B 
	global_load_dword v83, v[2:3], s[22:23]                    // 000000005288: DC508000 53160002 
	global_store_dword v[2:3], v35, s[20:21]                   // 000000005290: DC708000 00142302 
	s_add_u32 s22, s22, s24                                    // 000000005298: 80161816 
	s_addc_u32 s23, s23, 0                                     // 00000000529C: 82178017 
	s_add_u32 s20, s20, s24                                    // 0000000052A0: 80141814 
	s_addc_u32 s21, s21, 0                                     // 0000000052A4: 82158015 
	s_waitcnt vmcnt(30)                                        // 0000000052A8: BF8C4F7E 
	v_fma_f32 v36, s27, v68, v36                               // 0000000052AC: D1CB0024 0492881B 
	global_load_dword v68, v[2:3], s[22:23]                    // 0000000052B4: DC508000 44160002 
	global_store_dword v[2:3], v36, s[20:21]                   // 0000000052BC: DC708000 00142402 
	s_add_u32 s22, s22, s24                                    // 0000000052C4: 80161816 
	s_addc_u32 s23, s23, 0                                     // 0000000052C8: 82178017 
	s_add_u32 s20, s20, s24                                    // 0000000052CC: 80141814 
	s_addc_u32 s21, s21, 0                                     // 0000000052D0: 82158015 
	s_waitcnt vmcnt(30)                                        // 0000000052D4: BF8C4F7E 
	v_fma_f32 v37, s27, v69, v37                               // 0000000052D8: D1CB0025 04968A1B 
	global_load_dword v69, v[2:3], s[22:23]                    // 0000000052E0: DC508000 45160002 
	global_store_dword v[2:3], v37, s[20:21]                   // 0000000052E8: DC708000 00142502 
	s_add_u32 s22, s22, s24                                    // 0000000052F0: 80161816 
	s_addc_u32 s23, s23, 0                                     // 0000000052F4: 82178017 
	s_add_u32 s20, s20, s24                                    // 0000000052F8: 80141814 
	s_addc_u32 s21, s21, 0                                     // 0000000052FC: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005300: BF8C4F7E 
	v_fma_f32 v38, s27, v70, v38                               // 000000005304: D1CB0026 049A8C1B 
	global_load_dword v70, v[2:3], s[22:23]                    // 00000000530C: DC508000 46160002 
	global_store_dword v[2:3], v38, s[20:21]                   // 000000005314: DC708000 00142602 
	s_add_u32 s22, s22, s24                                    // 00000000531C: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000005320: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000005324: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005328: 82158015 
	s_waitcnt vmcnt(30)                                        // 00000000532C: BF8C4F7E 
	v_fma_f32 v39, s27, v71, v39                               // 000000005330: D1CB0027 049E8E1B 
	global_load_dword v71, v[2:3], s[22:23]                    // 000000005338: DC508000 47160002 
	global_store_dword v[2:3], v39, s[20:21]                   // 000000005340: DC708000 00142702 
	s_add_u32 s22, s22, s24                                    // 000000005348: 80161816 
	s_addc_u32 s23, s23, 0                                     // 00000000534C: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000005350: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005354: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005358: BF8C4F7E 
	v_fma_f32 v40, s27, v72, v40                               // 00000000535C: D1CB0028 04A2901B 
	global_load_dword v72, v[2:3], s[22:23]                    // 000000005364: DC508000 48160002 
	global_store_dword v[2:3], v40, s[20:21]                   // 00000000536C: DC708000 00142802 
	s_add_u32 s22, s22, s24                                    // 000000005374: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000005378: 82178017 
	s_add_u32 s20, s20, s24                                    // 00000000537C: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005380: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005384: BF8C4F7E 
	v_fma_f32 v41, s27, v73, v41                               // 000000005388: D1CB0029 04A6921B 
	global_load_dword v73, v[2:3], s[22:23]                    // 000000005390: DC508000 49160002 
	global_store_dword v[2:3], v41, s[20:21]                   // 000000005398: DC708000 00142902 
	s_add_u32 s22, s22, s24                                    // 0000000053A0: 80161816 
	s_addc_u32 s23, s23, 0                                     // 0000000053A4: 82178017 
	s_add_u32 s20, s20, s24                                    // 0000000053A8: 80141814 
	s_addc_u32 s21, s21, 0                                     // 0000000053AC: 82158015 
	s_waitcnt vmcnt(30)                                        // 0000000053B0: BF8C4F7E 
	v_fma_f32 v42, s27, v74, v42                               // 0000000053B4: D1CB002A 04AA941B 
	global_load_dword v74, v[2:3], s[22:23]                    // 0000000053BC: DC508000 4A160002 
	global_store_dword v[2:3], v42, s[20:21]                   // 0000000053C4: DC708000 00142A02 
	s_add_u32 s22, s22, s24                                    // 0000000053CC: 80161816 
	s_addc_u32 s23, s23, 0                                     // 0000000053D0: 82178017 
	s_add_u32 s20, s20, s24                                    // 0000000053D4: 80141814 
	s_addc_u32 s21, s21, 0                                     // 0000000053D8: 82158015 
	s_waitcnt vmcnt(30)                                        // 0000000053DC: BF8C4F7E 
	v_fma_f32 v43, s27, v75, v43                               // 0000000053E0: D1CB002B 04AE961B 
	global_load_dword v75, v[2:3], s[22:23]                    // 0000000053E8: DC508000 4B160002 
	global_store_dword v[2:3], v43, s[20:21]                   // 0000000053F0: DC708000 00142B02 
	s_add_u32 s22, s22, s24                                    // 0000000053F8: 80161816 
	s_addc_u32 s23, s23, 0                                     // 0000000053FC: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000005400: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005404: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005408: BF8C4F7E 
	v_fma_f32 v44, s27, v76, v44                               // 00000000540C: D1CB002C 04B2981B 
	global_load_dword v76, v[2:3], s[22:23]                    // 000000005414: DC508000 4C160002 
	global_store_dword v[2:3], v44, s[20:21]                   // 00000000541C: DC708000 00142C02 
	s_add_u32 s22, s22, s24                                    // 000000005424: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000005428: 82178017 
	s_add_u32 s20, s20, s24                                    // 00000000542C: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005430: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005434: BF8C4F7E 
	v_fma_f32 v45, s27, v77, v45                               // 000000005438: D1CB002D 04B69A1B 
	global_load_dword v77, v[2:3], s[22:23]                    // 000000005440: DC508000 4D160002 
	global_store_dword v[2:3], v45, s[20:21]                   // 000000005448: DC708000 00142D02 
	s_add_u32 s22, s22, s24                                    // 000000005450: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000005454: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000005458: 80141814 
	s_addc_u32 s21, s21, 0                                     // 00000000545C: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005460: BF8C4F7E 
	v_fma_f32 v46, s27, v78, v46                               // 000000005464: D1CB002E 04BA9C1B 
	global_load_dword v78, v[2:3], s[22:23]                    // 00000000546C: DC508000 4E160002 
	global_store_dword v[2:3], v46, s[20:21]                   // 000000005474: DC708000 00142E02 
	s_add_u32 s22, s22, s24                                    // 00000000547C: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000005480: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000005484: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005488: 82158015 
	s_waitcnt vmcnt(30)                                        // 00000000548C: BF8C4F7E 
	v_fma_f32 v47, s27, v79, v47                               // 000000005490: D1CB002F 04BE9E1B 
	global_load_dword v79, v[2:3], s[22:23]                    // 000000005498: DC508000 4F160002 
	global_store_dword v[2:3], v47, s[20:21]                   // 0000000054A0: DC708000 00142F02 
	s_add_u32 s22, s22, s24                                    // 0000000054A8: 80161816 
	s_addc_u32 s23, s23, 0                                     // 0000000054AC: 82178017 
	s_add_u32 s20, s20, s24                                    // 0000000054B0: 80141814 
	s_addc_u32 s21, s21, 0                                     // 0000000054B4: 82158015 
	s_waitcnt vmcnt(30)                                        // 0000000054B8: BF8C4F7E 
	v_fma_f32 v48, s27, v80, v48                               // 0000000054BC: D1CB0030 04C2A01B 
	global_load_dword v80, v[2:3], s[22:23]                    // 0000000054C4: DC508000 50160002 
	global_store_dword v[2:3], v48, s[20:21]                   // 0000000054CC: DC708000 00143002 
	s_add_u32 s22, s22, s24                                    // 0000000054D4: 80161816 
	s_addc_u32 s23, s23, 0                                     // 0000000054D8: 82178017 
	s_add_u32 s20, s20, s24                                    // 0000000054DC: 80141814 
	s_addc_u32 s21, s21, 0                                     // 0000000054E0: 82158015 
	s_waitcnt vmcnt(30)                                        // 0000000054E4: BF8C4F7E 
	v_fma_f32 v49, s27, v81, v49                               // 0000000054E8: D1CB0031 04C6A21B 
	global_load_dword v81, v[2:3], s[22:23]                    // 0000000054F0: DC508000 51160002 
	global_store_dword v[2:3], v49, s[20:21]                   // 0000000054F8: DC708000 00143102 
	s_add_u32 s22, s22, s24                                    // 000000005500: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000005504: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000005508: 80141814 
	s_addc_u32 s21, s21, 0                                     // 00000000550C: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005510: BF8C4F7E 
	v_fma_f32 v50, s27, v82, v50                               // 000000005514: D1CB0032 04CAA41B 
	global_load_dword v82, v[2:3], s[22:23]                    // 00000000551C: DC508000 52160002 
	global_store_dword v[2:3], v50, s[20:21]                   // 000000005524: DC708000 00143202 
	s_add_u32 s22, s22, s24                                    // 00000000552C: 80161816 
	s_addc_u32 s23, s23, 0                                     // 000000005530: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000005534: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005538: 82158015 
	s_waitcnt vmcnt(30)                                        // 00000000553C: BF8C4F7E 
	v_fma_f32 v51, s27, v83, v51                               // 000000005540: D1CB0033 04CEA61B 
	global_load_dword v83, v[2:3], s[22:23]                    // 000000005548: DC508000 53160002 
	global_store_dword v[2:3], v51, s[20:21]                   // 000000005550: DC708000 00143302 
	s_add_u32 s22, s22, s24                                    // 000000005558: 80161816 
	s_addc_u32 s23, s23, 0                                     // 00000000555C: 82178017 
	s_add_u32 s20, s20, s24                                    // 000000005560: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005564: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005568: BF8C4F7E 
	v_fma_f32 v52, s27, v68, v52                               // 00000000556C: D1CB0034 04D2881B 
	global_store_dword v[2:3], v52, s[20:21]                   // 000000005574: DC708000 00143402 
	s_add_u32 s20, s20, s24                                    // 00000000557C: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005580: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005584: BF8C4F7E 
	v_fma_f32 v53, s27, v69, v53                               // 000000005588: D1CB0035 04D68A1B 
	global_store_dword v[2:3], v53, s[20:21]                   // 000000005590: DC708000 00143502 
	s_add_u32 s20, s20, s24                                    // 000000005598: 80141814 
	s_addc_u32 s21, s21, 0                                     // 00000000559C: 82158015 
	s_waitcnt vmcnt(30)                                        // 0000000055A0: BF8C4F7E 
	v_fma_f32 v54, s27, v70, v54                               // 0000000055A4: D1CB0036 04DA8C1B 
	global_store_dword v[2:3], v54, s[20:21]                   // 0000000055AC: DC708000 00143602 
	s_add_u32 s20, s20, s24                                    // 0000000055B4: 80141814 
	s_addc_u32 s21, s21, 0                                     // 0000000055B8: 82158015 
	s_waitcnt vmcnt(30)                                        // 0000000055BC: BF8C4F7E 
	v_fma_f32 v55, s27, v71, v55                               // 0000000055C0: D1CB0037 04DE8E1B 
	global_store_dword v[2:3], v55, s[20:21]                   // 0000000055C8: DC708000 00143702 
	s_add_u32 s20, s20, s24                                    // 0000000055D0: 80141814 
	s_addc_u32 s21, s21, 0                                     // 0000000055D4: 82158015 
	s_waitcnt vmcnt(30)                                        // 0000000055D8: BF8C4F7E 
	v_fma_f32 v56, s27, v72, v56                               // 0000000055DC: D1CB0038 04E2901B 
	global_store_dword v[2:3], v56, s[20:21]                   // 0000000055E4: DC708000 00143802 
	s_add_u32 s20, s20, s24                                    // 0000000055EC: 80141814 
	s_addc_u32 s21, s21, 0                                     // 0000000055F0: 82158015 
	s_waitcnt vmcnt(30)                                        // 0000000055F4: BF8C4F7E 
	v_fma_f32 v57, s27, v73, v57                               // 0000000055F8: D1CB0039 04E6921B 
	global_store_dword v[2:3], v57, s[20:21]                   // 000000005600: DC708000 00143902 
	s_add_u32 s20, s20, s24                                    // 000000005608: 80141814 
	s_addc_u32 s21, s21, 0                                     // 00000000560C: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005610: BF8C4F7E 
	v_fma_f32 v58, s27, v74, v58                               // 000000005614: D1CB003A 04EA941B 
	global_store_dword v[2:3], v58, s[20:21]                   // 00000000561C: DC708000 00143A02 
	s_add_u32 s20, s20, s24                                    // 000000005624: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005628: 82158015 
	s_waitcnt vmcnt(30)                                        // 00000000562C: BF8C4F7E 
	v_fma_f32 v59, s27, v75, v59                               // 000000005630: D1CB003B 04EE961B 
	global_store_dword v[2:3], v59, s[20:21]                   // 000000005638: DC708000 00143B02 
	s_add_u32 s20, s20, s24                                    // 000000005640: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005644: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005648: BF8C4F7E 
	v_fma_f32 v60, s27, v76, v60                               // 00000000564C: D1CB003C 04F2981B 
	global_store_dword v[2:3], v60, s[20:21]                   // 000000005654: DC708000 00143C02 
	s_add_u32 s20, s20, s24                                    // 00000000565C: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005660: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005664: BF8C4F7E 
	v_fma_f32 v61, s27, v77, v61                               // 000000005668: D1CB003D 04F69A1B 
	global_store_dword v[2:3], v61, s[20:21]                   // 000000005670: DC708000 00143D02 
	s_add_u32 s20, s20, s24                                    // 000000005678: 80141814 
	s_addc_u32 s21, s21, 0                                     // 00000000567C: 82158015 
	s_waitcnt vmcnt(30)                                        // 000000005680: BF8C4F7E 
	v_fma_f32 v62, s27, v78, v62                               // 000000005684: D1CB003E 04FA9C1B 
	global_store_dword v[2:3], v62, s[20:21]                   // 00000000568C: DC708000 00143E02 
	s_add_u32 s20, s20, s24                                    // 000000005694: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005698: 82158015 
	s_waitcnt vmcnt(30)                                        // 00000000569C: BF8C4F7E 
	v_fma_f32 v63, s27, v79, v63                               // 0000000056A0: D1CB003F 04FE9E1B 
	global_store_dword v[2:3], v63, s[20:21]                   // 0000000056A8: DC708000 00143F02 
	s_add_u32 s20, s20, s24                                    // 0000000056B0: 80141814 
	s_addc_u32 s21, s21, 0                                     // 0000000056B4: 82158015 
	s_waitcnt vmcnt(30)                                        // 0000000056B8: BF8C4F7E 
	v_fma_f32 v64, s27, v80, v64                               // 0000000056BC: D1CB0040 0502A01B 
	global_store_dword v[2:3], v64, s[20:21]                   // 0000000056C4: DC708000 00144002 
	s_add_u32 s20, s20, s24                                    // 0000000056CC: 80141814 
	s_addc_u32 s21, s21, 0                                     // 0000000056D0: 82158015 
	s_waitcnt vmcnt(30)                                        // 0000000056D4: BF8C4F7E 
	v_fma_f32 v65, s27, v81, v65                               // 0000000056D8: D1CB0041 0506A21B 
	global_store_dword v[2:3], v65, s[20:21]                   // 0000000056E0: DC708000 00144102 
	s_add_u32 s20, s20, s24                                    // 0000000056E8: 80141814 
	s_addc_u32 s21, s21, 0                                     // 0000000056EC: 82158015 
	s_waitcnt vmcnt(30)                                        // 0000000056F0: BF8C4F7E 
	v_fma_f32 v66, s27, v82, v66                               // 0000000056F4: D1CB0042 050AA41B 
	global_store_dword v[2:3], v66, s[20:21]                   // 0000000056FC: DC708000 00144202 
	s_add_u32 s20, s20, s24                                    // 000000005704: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005708: 82158015 
	s_waitcnt vmcnt(30)                                        // 00000000570C: BF8C4F7E 
	v_fma_f32 v67, s27, v83, v67                               // 000000005710: D1CB0043 050EA61B 
	global_store_dword v[2:3], v67, s[20:21]                   // 000000005718: DC708000 00144302 
	s_add_u32 s20, s20, s24                                    // 000000005720: 80141814 
	s_addc_u32 s21, s21, 0                                     // 000000005724: 82158015 

label_end:
	s_endpgm                                                   // 000000005728: BF810000 
