result_to_str:
        addi    sp,sp,-32       #,,
        sw      s0,28(sp)   #,
        addi    s0,sp,32        #,,
        sw      a0,-20(s0)  # res, res
        lui     a5,%hi(result_str)        # tmp74,
        addi    a4,a5,%lo(result_str)   # tmp75, tmp74,
        lw      a5,-20(s0)      # tmp76, res
        slli    a5,a5,2 #, tmp77, tmp76
        add     a5,a4,a5  # tmp77, tmp78, tmp75
        lw      a5,0(a5)            # _3, result_str[res_2(D)]
        mv      a0,a5       #, <retval>
        lw      s0,28(sp)         #,
        addi    sp,sp,32        #,,
        jr      ra      #
table_index:
        addi    sp,sp,-32       #,,
        sw      s0,28(sp)   #,
        addi    s0,sp,32        #,,
        sw      a0,-20(s0)  # baro_alt, baro_alt
        sw      a1,-24(s0)  # radio_alt, radio_alt
        lw      a4,-24(s0)      # tmp76, radio_alt
        li      a5,4096       # tmp78,
        addi    a5,a5,-1497     #, tmp77, tmp78
        bgt     a4,a5,.L4 #, tmp76, tmp77,
        lw      a4,-24(s0)      # tmp79, radio_alt
        li      a5,999          # tmp80,
        bgt     a4,a5,.L5 #, tmp79, tmp80,
        li      a5,0                # _1,
        j       .L6         #
.L5:
        lw      a4,-24(s0)      # tmp83, radio_alt
        li      a5,4096       # tmp85,
        addi    a5,a5,-1747     #, tmp84, tmp85
        bgt     a4,a5,.L7 #, tmp83, tmp84,
        li      a5,1                # _1,
        j       .L6         #
.L7:
        li      a5,2                # _1,
        j       .L6         #
.L4:
        lw      a4,-20(s0)      # tmp88, baro_alt
        li      a5,4096       # tmp90,
        addi    a5,a5,903       #, tmp89, tmp90
        bgt     a4,a5,.L8 #, tmp88, tmp89,
        li      a5,2                # _1,
        j       .L6         #
.L8:
        lw      a4,-20(s0)      # tmp93, baro_alt
        li      a5,8192       # tmp95,
        addi    a5,a5,1807      #, tmp94, tmp95
        bgt     a4,a5,.L9 #, tmp93, tmp94,
        li      a5,3                # _1,
        j       .L6         #
.L9:
        lw      a4,-20(s0)      # tmp98, baro_alt
        li      a5,20480            # tmp100,
        addi    a5,a5,-481      #, tmp99, tmp100
        bgt     a4,a5,.L10        #, tmp98, tmp99,
        li      a5,4                # _1,
        j       .L6         #
.L10:
        lw      a4,-20(s0)      # tmp103, baro_alt
        li      a5,40960            # tmp105,
        addi    a5,a5,1039      #, tmp104, tmp105
        bgt     a4,a5,.L11        #, tmp103, tmp104,
        li      a5,5                # _1,
        j       .L6         #
.L11:
        li      a5,6                # _1,
.L6:
        mv      a0,a5       #, <retval>
        lw      s0,28(sp)         #,
        addi    sp,sp,32        #,,
        jr      ra      #
quantize_altitude:
        addi    sp,sp,-48       #,,
        sw      s0,44(sp)   #,
        addi    s0,sp,48        #,,
        sw      a0,-36(s0)  # altitude, altitude
        lw      a4,-36(s0)      # tmp75, altitude
        li      a5,25             # tmp77,
        rem     a5,a4,a5  # tmp77, tmp76, tmp75
        sw      a5,-20(s0)  # tmp76, remainder
        lw      a4,-36(s0)      # tmp79, altitude
        lw      a5,-20(s0)      # tmp80, remainder
        sub     a5,a4,a5  # tmp78, tmp79, tmp80
        sw      a5,-36(s0)  # tmp78, altitude
        lw      a4,-20(s0)      # tmp81, remainder
        li      a5,12             # tmp82,
        ble     a4,a5,.L13        #, tmp81, tmp82,
        lw      a5,-36(s0)      # tmp84, altitude
        addi    a5,a5,25        #, tmp83, tmp84
        sw      a5,-36(s0)  # tmp83, altitude
.L13:
        lw      a5,-36(s0)      # _6, altitude
        mv      a0,a5       #, <retval>
        lw      s0,44(sp)         #,
        addi    sp,sp,48        #,,
        jr      ra      #
estimate_intruder_alt:
        addi    sp,sp,-32       #,,
        sw      s0,28(sp)   #,
        addi    s0,sp,32        #,,
        sw      a0,-20(s0)  # own_aircraft, own_aircraft
        sw      a1,-24(s0)  # intruder, intruder
        lw      a5,-24(s0)      # tmp78, intruder
        lw      a4,4(a5)            # _1, intruder_6(D)->baroalt
        lw      a5,-20(s0)      # tmp79, own_aircraft
        lw      a3,4(a5)            # _2, own_aircraft_7(D)->baroalt
        lw      a5,-20(s0)      # tmp80, own_aircraft
        lw      a5,8(a5)            # _3, own_aircraft_7(D)->radioalt
        sub     a5,a3,a5  # _4, _2, _3
        sub     a5,a4,a5  # _8, _1, _4
        mv      a0,a5       #, <retval>
        lw      s0,28(sp)         #,
        addi    sp,sp,32        #,,
        jr      ra      #
time_to_go_CPA:
        addi    sp,sp,-48       #,,
        sw      s0,44(sp)   #,
        addi    s0,sp,48        #,,
        sw      a0,-36(s0)  # own_aircraft, own_aircraft
        sw      a1,-40(s0)  # intruder, intruder
        fsw     fa0,-44(s0)       # dmod, dmod
        lw      a5,-40(s0)      # tmp82, intruder
        flw     fa5,16(a5)        # tmp83, intruder_12(D)->slant_range
        fsw     fa5,-20(s0)       # tmp83, slant_range
        sw      zero,-24(s0)        #, closure_speed
        lw      a5,-40(s0)      # tmp84, intruder
        flw     fa5,36(a5)        # _1, intruder_12(D)->_closure_prev
        fmv.w.x fa4,zero  # tmp85,
        flt.s   a5,fa5,fa4    #, tmp86, _1, tmp85
        beq     a5,zero,.L18      #, tmp86,,
        lw      a5,-40(s0)      # tmp87, intruder
        flw     fa5,-20(s0)       # tmp88, slant_range
        fsw     fa5,36(a5)        # tmp88, intruder_12(D)->_closure_prev
.L18:
        lw      a5,-40(s0)      # tmp89, intruder
        flw     fa4,36(a5)        # _2, intruder_12(D)->_closure_prev
        flw     fa5,-20(s0)       # tmp90, slant_range
        fsub.s  fa4,fa4,fa5 # _3, _2, tmp90
        lw      a5,-40(s0)      # tmp91, intruder
        flw     fa5,28(a5)        # _4, intruder_12(D)->delta_update_time
        fdiv.s  fa5,fa4,fa5 # tmp92, _3, _4
        fsw     fa5,-24(s0)       # tmp92, closure_speed
        flw     fa5,-24(s0)       # tmp93, closure_speed
        fmv.w.x fa4,zero  # tmp94,
        fle.s   a5,fa5,fa4    #, tmp95, tmp93, tmp94
        beq     a5,zero,.L27      #, tmp95,,
        lui     a5,%hi(.LC17)     # tmp96,
        flw     fa5,%lo(.LC17)(a5)        # _8,
        j       .L22      #
.L27:
        flw     fa4,-20(s0)       # tmp97, slant_range
        flw     fa5,-44(s0)       # tmp98, dmod
        fsub.s  fa5,fa4,fa5 # _5, tmp97, tmp98
        fcvt.d.s        fa4,fa5 # _6, _5
        flw     fa5,-24(s0)       # tmp99, closure_speed
        fmv.w.x fa3,zero  # tmp100,
        feq.s   a5,fa5,fa3    #, tmp101, tmp99, tmp100
        bne     a5,zero,.L23      #, tmp101,,
        flw     fa5,-24(s0)       # tmp102, closure_speed
        fcvt.d.s        fa5,fa5 # iftmp.0_9, tmp102
        j       .L24      #
.L23:
        lui     a5,%hi(.LC18)     # tmp103,
        fld     fa5,%lo(.LC18)(a5)        # iftmp.0_9,
.L24:
        fdiv.d  fa5,fa4,fa5 # _7, _6, iftmp.0_9
        fcvt.s.d        fa5,fa5 # _8, _7
.L22:
        fmv.s   fa0,fa5       #, <retval>
        lw      s0,44(sp)         #,
        addi    sp,sp,48        #,,
        jr      ra      #
altitude_test:
        addi    sp,sp,-64       #,,
        sw      s0,60(sp)   #,
        addi    s0,sp,64        #,,
        sw      a0,-52(s0)  # own_aircraft, own_aircraft
        sw      a1,-56(s0)  # intruder, intruder
        sw      a2,-60(s0)  # type, type
        sw      a3,-64(s0)  # idx_table, idx_table
        lw      a5,-52(s0)      # tmp87, own_aircraft
        lw      a5,12(a5)         # tmp88, own_aircraft_18(D)->vert_spd
        sw      a5,-20(s0)  # tmp88, own_vs
        lw      a5,-56(s0)      # tmp89, intruder
        lw      a5,12(a5)         # tmp90, intruder_20(D)->vert_spd
        sw      a5,-24(s0)  # tmp90, int_vs
        lw      a5,-52(s0)      # tmp91, own_aircraft
        lw      a4,4(a5)            # _1, own_aircraft_18(D)->baroalt
        lw      a5,-56(s0)      # tmp92, intruder
        lw      a5,4(a5)            # _2, intruder_20(D)->baroalt
        sub     a4,a4,a5  # _3, _1, _2
        srai    a5,a4,31        #, tmp93, _3
        xor     a4,a5,a4  # _3, tmp94, tmp93
        sub     a5,a4,a5  # tmp95, tmp94, tmp93
        sw      a5,-28(s0)  # tmp95, alt_diff
        lui     a5,%hi(ZTHR)      # tmp96,
        addi    a3,a5,%lo(ZTHR) # tmp97, tmp96,
        lw      a4,-60(s0)      # tmp98, type
        mv      a5,a4       # tmp99, tmp98
        slli    a5,a5,3 #, tmp100, tmp99
        sub     a5,a5,a4  # tmp99, tmp99, tmp98
        lw      a4,-64(s0)      # tmp102, idx_table
        add     a5,a5,a4  # tmp102, tmp101, tmp99
        slli    a5,a5,2 #, tmp103, tmp101
        add     a5,a3,a5  # tmp103, tmp104, tmp97
        lw      a5,0(a5)            # _4, ZTHR[type_23(D)][idx_table_24(D)]
        lw      a4,-28(s0)      # tmp105, alt_diff
        bgt     a4,a5,.L29        #, tmp105, _4,
        li      a5,1                # _11,
        j       .L30      #
.L29:
        lw      a4,-20(s0)      # tmp106, own_vs
        lw      a5,-24(s0)      # tmp107, int_vs
        sub     a4,a4,a5  # _5, tmp106, tmp107
        srai    a5,a4,31        #, tmp108, _5
        xor     a4,a5,a4  # _5, _6, tmp108
        sub     a4,a4,a5  # _6, _6, tmp108
        mv      a5,a4       # tmp109, _6
        slli    a5,a5,4 #, tmp110, tmp109
        sub     a5,a5,a4  # tmp109, tmp109, _6
        slli    a5,a5,2 #, tmp111, tmp109
        sw      a5,-32(s0)  # tmp109, closure_rate
        lw      a5,-32(s0)      # tmp112, closure_rate
        beq     a5,zero,.L31      #, tmp112,,
        lw      a5,-32(s0)      # iftmp.1_12, closure_rate
        j       .L32      #
.L31:
        li      a5,1                # iftmp.1_12,
.L32:
        lw      a4,-28(s0)      # tmp114, alt_diff
        div     a5,a4,a5  # iftmp.1_12, tmp113, tmp114
        sw      a5,-36(s0)  # tmp113, projected_alt_time
        lw      a4,-20(s0)      # tmp115, own_vs
        li      a5,599          # tmp116,
        ble     a4,a5,.L33        #, tmp115, tmp116,
        lw      a5,-20(s0)      # tmp117, own_vs
        beq     a5,zero,.L34      #, tmp117,,
        lw      a5,-20(s0)      # tmp118, own_vs
        ble     a5,zero,.L35      #, tmp118,,
        li      a4,1                # iftmp.3_14,
        j       .L37      #
.L35:
        li      a4,-1             # iftmp.3_14,
        j       .L37      #
.L34:
        li      a4,0                # iftmp.3_14,
.L37:
        lw      a5,-24(s0)      # tmp119, int_vs
        beq     a5,zero,.L38      #, tmp119,,
        lw      a5,-24(s0)      # tmp120, int_vs
        ble     a5,zero,.L39      #, tmp120,,
        li      a5,1                # iftmp.5_16,
        j       .L41      #
.L39:
        li      a5,-1             # iftmp.5_16,
        j       .L41      #
.L38:
        li      a5,0                # iftmp.5_16,
.L41:
        bne     a4,a5,.L42        #, iftmp.3_14, iftmp.5_16,
        lw      a5,-20(s0)      # tmp122, own_vs
        srai    a5,a5,31        #, tmp121, tmp122
        lw      a4,-20(s0)      # tmp123, own_vs
        xor     a4,a5,a4  # tmp123, _7, tmp121
        sub     a4,a4,a5  # _7, _7, tmp121
        lw      a5,-24(s0)      # tmp125, int_vs
        srai    a3,a5,31        #, tmp124, tmp125
        lw      a5,-24(s0)      # tmp126, int_vs
        xor     a5,a3,a5  # tmp126, _8, tmp124
        sub     a5,a5,a3  # _8, _8, tmp124
        bge     a4,a5,.L42        #, _7, _8,
.L33:
        lui     a5,%hi(TVTHR)     # tmp127,
        addi    a4,a5,%lo(TVTHR)        # tmp128, tmp127,
        lw      a5,-64(s0)      # tmp129, idx_table
        slli    a5,a5,2 #, tmp130, tmp129
        add     a5,a4,a5  # tmp130, tmp131, tmp128
        lw      a5,0(a5)            # _9, TVTHR[idx_table_24(D)]
        lw      a4,-36(s0)      # tmp132, projected_alt_time
        bge     a4,a5,.L44        #, tmp132, _9,
        li      a5,1                # _11,
        j       .L30      #
.L42:
        lui     a5,%hi(TAU)       # tmp133,
        addi    a3,a5,%lo(TAU)  # tmp134, tmp133,
        lw      a4,-60(s0)      # tmp135, type
        mv      a5,a4       # tmp136, tmp135
        slli    a5,a5,3 #, tmp137, tmp136
        sub     a5,a5,a4  # tmp136, tmp136, tmp135
        lw      a4,-64(s0)      # tmp139, idx_table
        add     a5,a5,a4  # tmp139, tmp138, tmp136
        slli    a5,a5,2 #, tmp140, tmp138
        add     a5,a3,a5  # tmp140, tmp141, tmp134
        lw      a5,0(a5)            # _10, TAU[type_23(D)][idx_table_24(D)]
        lw      a4,-36(s0)      # tmp142, projected_alt_time
        bge     a4,a5,.L44        #, tmp142, _10,
        li      a5,1                # _11,
        j       .L30      #
.L44:
        li      a5,0                # _11,
.L30:
        mv      a0,a5       #, <retval>
        lw      s0,60(sp)         #,
        addi    sp,sp,64        #,,
        jr      ra      #
hmdf_parabolic_range_est:
        addi    sp,sp,-64       #,,
        sw      ra,60(sp)   #,
        sw      s0,56(sp)   #,
        addi    s0,sp,64        #,,
        sw      a0,-36(s0)  # own_aircraft, own_aircraft
        sw      a1,-40(s0)  # intruder, intruder
        sw      a2,-44(s0)  # As, As
        sw      a3,-48(s0)  # Vs, Vs
        sw      a4,-52(s0)  # Rs, Rs
        lw      a5,-40(s0)      # tmp137, intruder
        flw     fa4,16(a5)        # _1, intruder_67(D)->slant_range
        lw      a5,-40(s0)      # tmp138, intruder
        flw     fa5,44(a5)        # _2, intruder_67(D)->_hmdf_Rp
        fsub.s  fa5,fa4,fa5 # tmp139, _1, _2
        fsw     fa5,-20(s0)       # tmp139, Re
        lw      a5,-36(s0)      # tmp140, own_aircraft
        flw     fa4,28(a5)        # _3, own_aircraft_69(D)->delta_update_time
        lw      a5,-40(s0)      # tmp141, intruder
        flw     fa5,28(a5)        # _4, intruder_67(D)->delta_update_time
        fdiv.s  fa5,fa4,fa5 # tmp142, _3, _4
        fsw     fa5,-24(s0)       # tmp142, curr_hit_ratio
        flw     fa4,-24(s0)       # tmp143, curr_hit_ratio
        lui     a5,%hi(.LC19)     # tmp145,
        flw     fa5,%lo(.LC19)(a5)        # tmp144,
        fle.s   a5,fa4,fa5    #, tmp146, tmp143, tmp144
        beq     a5,zero,.L52      #, tmp146,,
        lw      a5,-40(s0)      # tmp147, intruder
        lbu     a5,100(a5)        # _5, intruder_67(D)->_hmdf_hits
        addi    a5,a5,1 #, tmp148, _5
        andi    a4,a5,0xff      # _7, tmp148
        lw      a5,-40(s0)      # tmp149, intruder
        sb      a4,100(a5)  # _7, intruder_67(D)->_hmdf_hits
        lw      a5,-40(s0)      # tmp150, intruder
        lbu     a4,100(a5)        # _8, intruder_67(D)->_hmdf_hits
        li      a5,8                # tmp151,
        bleu    a4,a5,.L48      #, _8, tmp151,
        lw      a5,-40(s0)      # tmp152, intruder
        li      a4,8                # tmp153,
        sb      a4,100(a5)  # tmp153, intruder_67(D)->_hmdf_hits
        j       .L48      #
.L52:
        flw     fa5,-24(s0)       # tmp154, curr_hit_ratio
        fcvt.d.s        fa5,fa5 # _9, tmp154
        fmv.d   fa0,fa5       #, _9
        call    ceil            #
        fmv.d   fa5,fa0       # _10,
        fcvt.wu.d a5,fa5,rtz    # tmp155, _10
        sb      a5,-25(s0)  # tmp155, int_curr_hit_ratio
        lw      a5,-40(s0)      # tmp156, intruder
        lbu     a5,100(a5)        # _11, intruder_67(D)->_hmdf_hits
        lbu     a4,-25(s0)        # tmp157, int_curr_hit_ratio
        bgeu    a4,a5,.L49      #, tmp157, _11,
        lw      a5,-40(s0)      # tmp158, intruder
        lbu     a4,100(a5)        # _12, intruder_67(D)->_hmdf_hits
        lbu     a5,-25(s0)        # tmp159, int_curr_hit_ratio
        sub     a5,a4,a5  # tmp160, _12, tmp159
        andi    a4,a5,0xff      # _13, tmp160
        lw      a5,-40(s0)      # tmp161, intruder
        sb      a4,100(a5)  # _13, intruder_67(D)->_hmdf_hits
        j       .L48      #
.L49:
        lw      a5,-40(s0)      # tmp162, intruder
        sb      zero,100(a5)        #, intruder_67(D)->_hmdf_hits
.L48:
        lw      a5,-40(s0)      # tmp163, intruder
        flw     fa4,52(a5)        # _14, intruder_67(D)->_hmdf_Ap
        lw      a5,-40(s0)      # tmp164, intruder
        lbu     a5,100(a5)        # _15, intruder_67(D)->_hmdf_hits
        mv      a3,a5       # _16, _15
        lui     a5,%hi(HMDF_c)    # tmp165,
        addi    a4,a5,%lo(HMDF_c)       # tmp166, tmp165,
        slli    a5,a3,1 #, tmp167, _16
        add     a5,a4,a5  # tmp167, tmp168, tmp166
        lhu     a5,0(a5)  # _17, HMDF_c[_16]
        fcvt.s.w        fa3,a5  # _19, _18
        flw     fa5,-20(s0)       # tmp169, Re
        fmul.s  fa3,fa3,fa5 # _20, _19, tmp169
        lw      a5,-40(s0)      # tmp170, intruder
        flw     fa2,28(a5)        # _21, intruder_67(D)->delta_update_time
        lw      a5,-40(s0)      # tmp171, intruder
        flw     fa5,28(a5)        # _22, intruder_67(D)->delta_update_time
        fmul.s  fa5,fa2,fa5 # _23, _21, _22
        fdiv.s  fa5,fa3,fa5 # _24, _20, _23
        fadd.s  fa5,fa4,fa5 # _25, _14, _24
        lw      a5,-44(s0)      # tmp172, As
        fsw     fa5,0(a5) # _25, *As_76(D)
        lw      a5,-40(s0)      # tmp173, intruder
        flw     fa4,48(a5)        # _26, intruder_67(D)->_hmdf_Vp
        lw      a5,-40(s0)      # tmp174, intruder
        lbu     a5,100(a5)        # _27, intruder_67(D)->_hmdf_hits
        mv      a3,a5       # _28, _27
        lui     a5,%hi(HMDF_b)    # tmp175,
        addi    a4,a5,%lo(HMDF_b)       # tmp176, tmp175,
        slli    a5,a3,1 #, tmp177, _28
        add     a5,a4,a5  # tmp177, tmp178, tmp176
        lhu     a5,0(a5)  # _29, HMDF_b[_28]
        fcvt.s.w        fa3,a5  # _31, _30
        flw     fa5,-20(s0)       # tmp179, Re
        fmul.s  fa3,fa3,fa5 # _32, _31, tmp179
        lw      a5,-40(s0)      # tmp180, intruder
        flw     fa5,28(a5)        # _33, intruder_67(D)->delta_update_time
        fdiv.s  fa5,fa3,fa5 # _34, _32, _33
        fadd.s  fa5,fa4,fa5 # _35, _26, _34
        lw      a5,-48(s0)      # tmp181, Vs
        fsw     fa5,0(a5) # _35, *Vs_78(D)
        lw      a5,-40(s0)      # tmp182, intruder
        flw     fa4,44(a5)        # _36, intruder_67(D)->_hmdf_Rp
        lw      a5,-40(s0)      # tmp183, intruder
        lbu     a5,100(a5)        # _37, intruder_67(D)->_hmdf_hits
        mv      a3,a5       # _38, _37
        lui     a5,%hi(HMDF_a)    # tmp184,
        addi    a4,a5,%lo(HMDF_a)       # tmp185, tmp184,
        slli    a5,a3,1 #, tmp186, _38
        add     a5,a4,a5  # tmp186, tmp187, tmp185
        lhu     a5,0(a5)  # _39, HMDF_a[_38]
        fcvt.s.w        fa3,a5  # _41, _40
        flw     fa5,-20(s0)       # tmp188, Re
        fmul.s  fa5,fa3,fa5 # _42, _41, tmp188
        fadd.s  fa5,fa4,fa5 # _43, _36, _42
        lw      a5,-52(s0)      # tmp189, Rs
        fsw     fa5,0(a5) # _43, *Rs_80(D)
        lw      a5,-40(s0)      # tmp190, intruder
        flw     fa4,52(a5)        # _44, intruder_67(D)->_hmdf_Ap
        lw      a5,-44(s0)      # tmp191, As
        flw     fa5,0(a5) # _45, *As_76(D)
        fsub.s  fa5,fa4,fa5 # _46, _44, _45
        lw      a5,-40(s0)      # tmp192, intruder
        fsw     fa5,56(a5)        # _46, intruder_67(D)->_hmdf_diff_ApAs
        lw      a5,-44(s0)      # tmp193, As
        flw     fa5,0(a5) # _47, *As_76(D)
        lw      a5,-40(s0)      # tmp194, intruder
        fsw     fa5,52(a5)        # _47, intruder_67(D)->_hmdf_Ap
        lw      a5,-48(s0)      # tmp195, Vs
        flw     fa4,0(a5) # _48, *Vs_78(D)
        lw      a5,-40(s0)      # tmp196, intruder
        flw     fa3,28(a5)        # _49, intruder_67(D)->delta_update_time
        lw      a5,-44(s0)      # tmp197, As
        flw     fa5,0(a5) # _50, *As_76(D)
        fmul.s  fa5,fa3,fa5 # _51, _49, _50
        fadd.s  fa5,fa4,fa5 # _52, _48, _51
        lw      a5,-40(s0)      # tmp198, intruder
        fsw     fa5,48(a5)        # _52, intruder_67(D)->_hmdf_Vp
        lw      a5,-52(s0)      # tmp199, Rs
        flw     fa4,0(a5) # _53, *Rs_80(D)
        lw      a5,-40(s0)      # tmp200, intruder
        flw     fa3,28(a5)        # _54, intruder_67(D)->delta_update_time
        lw      a5,-48(s0)      # tmp201, Vs
        flw     fa5,0(a5) # _55, *Vs_78(D)
        fmul.s  fa5,fa3,fa5 # _56, _54, _55
        fadd.s  fa4,fa4,fa5 # _57, _53, _56
        lw      a5,-40(s0)      # tmp202, intruder
        flw     fa3,28(a5)        # _58, intruder_67(D)->delta_update_time
        lw      a5,-40(s0)      # tmp203, intruder
        flw     fa5,28(a5)        # _59, intruder_67(D)->delta_update_time
        fmul.s  fa3,fa3,fa5 # _60, _58, _59
        lw      a5,-44(s0)      # tmp204, As
        flw     fa5,0(a5) # _61, *As_76(D)
        fmul.s  fa3,fa3,fa5 # _62, _60, _61
        lui     a5,%hi(.LC20)     # tmp206,
        flw     fa5,%lo(.LC20)(a5)        # tmp205,
        fdiv.s  fa5,fa3,fa5 # _63, _62, tmp205
        fadd.s  fa5,fa4,fa5 # _64, _57, _63
        lw      a5,-40(s0)      # tmp207, intruder
        fsw     fa5,44(a5)        # _64, intruder_67(D)->_hmdf_Rp
        flw     fa5,-20(s0)       # _86, Re
        fmv.s   fa0,fa5       #, <retval>
        lw      ra,60(sp)         #,
        lw      s0,56(sp)         #,
        addi    sp,sp,64        #,,
        jr      ra      #
hdmf_accuracy_check:
        addi    sp,sp,-48       #,,
        sw      ra,44(sp)   #,
        sw      s0,40(sp)   #,
        addi    s0,sp,48        #,,
        sw      a0,-36(s0)  # intruder, intruder
        fsw     fa0,-40(s0)       # Re, Re
        lw      a5,-36(s0)      # tmp85, intruder
        flw     fa4,60(a5)        # _1, intruder_14(D)->_hmdf_E
        lui     a5,%hi(.LC21)     # tmp87,
        flw     fa5,%lo(.LC21)(a5)        # tmp86,
        fmul.s  fa4,fa4,fa5 # _2, _1, tmp86
        flw     fa3,-40(s0)       # tmp88, Re
        lui     a5,%hi(.LC22)     # tmp90,
        flw     fa5,%lo(.LC22)(a5)        # tmp89,
        fmul.s  fa3,fa3,fa5 # _3, tmp88, tmp89
        flw     fa5,-40(s0)       # tmp91, Re
        fmul.s  fa5,fa3,fa5 # _4, _3, tmp91
        fadd.s  fa5,fa4,fa5 # _5, _2, _4
        lw      a5,-36(s0)      # tmp92, intruder
        fsw     fa5,60(a5)        # _5, intruder_14(D)->_hmdf_E
        lw      a5,-36(s0)      # tmp93, intruder
        flw     fa5,60(a5)        # _6, intruder_14(D)->_hmdf_E
        fcvt.d.s        fa5,fa5 # _7, _6
        fmv.d   fa0,fa5       #, _7
        call    sqrt            #
        fmv.d   fa5,fa0       # _8,
        fcvt.s.d        fa5,fa5 # tmp94, _8
        fsw     fa5,-20(s0)       # tmp94, sigma
        flw     fa4,-20(s0)       # tmp95, sigma
        lui     a5,%hi(.LC23)     # tmp97,
        flw     fa5,%lo(.LC23)(a5)        # tmp96,
        fgt.s   a5,fa4,fa5    #, tmp98, tmp95, tmp96
        beq     a5,zero,.L62      #, tmp98,,
        flw     fa4,-20(s0)       # tmp99, sigma
        lui     a5,%hi(.LC24)     # tmp101,
        flw     fa5,%lo(.LC24)(a5)        # tmp100,
        fmul.s  fa4,fa4,fa5 # _9, tmp99, tmp100
        lui     a5,%hi(.LC23)     # tmp103,
        flw     fa5,%lo(.LC23)(a5)        # tmp102,
        fdiv.s  fa5,fa4,fa5 # iftmp.6_11, _9, tmp102
        j       .L56      #
.L62:
        lui     a5,%hi(.LC24)     # tmp104,
        flw     fa5,%lo(.LC24)(a5)        # iftmp.6_11,
.L56:
        fsw     fa5,-24(s0)       # iftmp.6_11, threshold
        lw      a5,-36(s0)      # tmp105, intruder
        flw     fa5,52(a5)        # _10, intruder_14(D)->_hmdf_Ap
        flw     fa4,-24(s0)       # tmp106, threshold
        fge.s   a5,fa4,fa5    #, tmp107, tmp106, _10
        beq     a5,zero,.L63      #, tmp107,,
        fmv.w.x fa5,zero  # _12,
        j       .L59      #
.L63:
        flw     fa5,-24(s0)       # _12, threshold
.L59:
        fmv.s   fa0,fa5       #, <retval>
        lw      ra,44(sp)         #,
        lw      s0,40(sp)         #,
        addi    sp,sp,48        #,,
        jr      ra      #
hmdf_predict_bearing_distance:
        addi    sp,sp,-128      #,,
        sw      ra,124(sp)  #,
        sw      s0,120(sp)  #,
        fsd     fs0,104(sp)       #,
        addi    s0,sp,128       #,,
        sw      a0,-116(s0) # own_aircraft, own_aircraft
        sw      a1,-120(s0) # intruder, intruder
        lui     a5,%hi(.LC25)     # tmp259,
        flw     fa5,%lo(.LC25)(a5)        # tmp260,
        fsw     fa5,-36(s0)       # tmp260, sigma_theta
        lui     a5,%hi(.LC21)     # tmp261,
        flw     fa5,%lo(.LC21)(a5)        # tmp262,
        fsw     fa5,-40(s0)       # tmp262, Q
        lw      a5,-120(s0)   # tmp263, intruder
        flw     fa5,28(a5)        # tmp264, intruder_192(D)->delta_update_time
        fsw     fa5,-44(s0)       # tmp264, T
        lw      a5,-120(s0)   # tmp265, intruder
        flw     fa5,16(a5)        # tmp266, intruder_192(D)->slant_range
        fsw     fa5,-48(s0)       # tmp266, slant_range
        lw      a5,-120(s0)   # tmp267, intruder
        flw     fa5,20(a5)        # _1, intruder_192(D)->bearing
        fcvt.d.s        fa4,fa5 # _2, _1
        lui     a5,%hi(.LC26)     # tmp269,
        fld     fa5,%lo(.LC26)(a5)        # tmp268,
        fmul.d  fa4,fa4,fa5 # _3, _2, tmp268
        lui     a5,%hi(.LC27)     # tmp271,
        fld     fa5,%lo(.LC27)(a5)        # tmp270,
        fdiv.d  fa5,fa4,fa5 # _4, _3, tmp270
        fcvt.s.d        fa5,fa5 # tmp272, _4
        fsw     fa5,-52(s0)       # tmp272, theta
        flw     fa5,-52(s0)       # tmp273, theta
        fcvt.d.s        fa5,fa5 # _5, tmp273
        fmv.d   fa0,fa5       #, _5
        call    sin       #
        fmv.d   fa5,fa0       # _6,
        fcvt.s.d        fa5,fa5 # tmp274, _6
        fsw     fa5,-56(s0)       # tmp274, s_theta
        flw     fa5,-52(s0)       # tmp275, theta
        fcvt.d.s        fa5,fa5 # _7, tmp275
        fmv.d   fa0,fa5       #, _7
        call    cos       #
        fmv.d   fa5,fa0       # _8,
        fcvt.s.d        fa5,fa5 # tmp276, _8
        fsw     fa5,-60(s0)       # tmp276, c_theta
        flw     fa4,-48(s0)       # tmp277, slant_range
        flw     fa5,-56(s0)       # tmp278, s_theta
        fmul.s  fa4,fa4,fa5 # _9, tmp277, tmp278
        lw      a5,-120(s0)   # tmp279, intruder
        flw     fa5,64(a5)        # _10, intruder_192(D)->_hmdf_RPX
        fsub.s  fa5,fa4,fa5 # tmp280, _9, _10
        fsw     fa5,-64(s0)       # tmp280, d_xm
        flw     fa4,-48(s0)       # tmp281, slant_range
        flw     fa5,-60(s0)       # tmp282, c_theta
        fmul.s  fa4,fa4,fa5 # _11, tmp281, tmp282
        lw      a5,-120(s0)   # tmp283, intruder
        flw     fa5,68(a5)        # _12, intruder_192(D)->_hmdf_RPY
        fsub.s  fa5,fa4,fa5 # tmp284, _11, _12
        fsw     fa5,-68(s0)       # tmp284, d_ym
        flw     fa4,-64(s0)       # tmp285, d_xm
        flw     fa5,-56(s0)       # tmp286, s_theta
        fmul.s  fa4,fa4,fa5 # _13, tmp285, tmp286
        flw     fa3,-68(s0)       # tmp287, d_ym
        flw     fa5,-60(s0)       # tmp288, c_theta
        fmul.s  fa5,fa3,fa5 # _14, tmp287, tmp288
        fadd.s  fa5,fa4,fa5 # tmp289, _13, _14
        fsw     fa5,-72(s0)       # tmp289, range
        flw     fa4,-68(s0)       # tmp290, d_ym
        flw     fa5,-56(s0)       # tmp291, s_theta
        fmul.s  fa4,fa4,fa5 # _15, tmp290, tmp291
        flw     fa3,-64(s0)       # tmp292, d_xm
        flw     fa5,-60(s0)       # tmp293, c_theta
        fmul.s  fa5,fa3,fa5 # _16, tmp292, tmp293
        fsub.s  fa5,fa4,fa5 # tmp294, _15, _16
        fsw     fa5,-76(s0)       # tmp294, xrange
        lw      a5,-120(s0)   # tmp295, intruder
        lbu     a4,100(a5)        # _17, intruder_192(D)->_hmdf_hits
        li      a5,1                # tmp296,
        bgtu    a4,a5,.L65      #, _17, tmp296,
        flw     fa5,-48(s0)       # tmp297, slant_range
        fmul.s  fa4,fa5,fa5 # _18, tmp297, tmp297
        flw     fa5,-36(s0)       # tmp298, sigma_theta
        fmul.s  fa4,fa4,fa5 # _19, _18, tmp298
        flw     fa5,-36(s0)       # tmp299, sigma_theta
        fmul.s  fa5,fa4,fa5 # _20, _19, tmp299
        lw      a5,-120(s0)   # tmp300, intruder
        fsw     fa5,80(a5)        # _20, intruder_192(D)->_hmdf_cov[0][0]
        flw     fa5,-48(s0)       # tmp301, slant_range
        fmul.s  fa4,fa5,fa5 # _21, tmp301, tmp301
        flw     fa5,-36(s0)       # tmp302, sigma_theta
        fmul.s  fa4,fa4,fa5 # _22, _21, tmp302
        flw     fa5,-36(s0)       # tmp303, sigma_theta
        fmul.s  fa4,fa4,fa5 # _23, _22, tmp303
        flw     fa5,-44(s0)       # tmp304, T
        fdiv.s  fa5,fa4,fa5 # _24, _23, tmp304
        lw      a5,-120(s0)   # tmp305, intruder
        fsw     fa5,84(a5)        # _24, intruder_192(D)->_hmdf_cov[0][1]
        lw      a5,-120(s0)   # tmp306, intruder
        flw     fa4,80(a5)        # _25, intruder_192(D)->_hmdf_cov[0][0]
        flw     fa5,-44(s0)       # tmp307, T
        fdiv.s  fa5,fa4,fa5 # _26, _25, tmp307
        lw      a5,-120(s0)   # tmp308, intruder
        fsw     fa5,88(a5)        # _26, intruder_192(D)->_hmdf_cov[1][0]
        lw      a5,-120(s0)   # tmp309, intruder
        flw     fa5,84(a5)        # _27, intruder_192(D)->_hmdf_cov[0][1]
        fadd.s  fa4,fa5,fa5 # _28, _27, _27
        flw     fa5,-44(s0)       # tmp310, T
        fdiv.s  fa5,fa4,fa5 # _29, _28, tmp310
        lw      a5,-120(s0)   # tmp311, intruder
        fsw     fa5,92(a5)        # _29, intruder_192(D)->_hmdf_cov[1][1]
        j       .L66      #
.L65:
        lw      a5,-120(s0)   # tmp312, intruder
        flw     fa4,80(a5)        # _30, intruder_192(D)->_hmdf_cov[0][0]
        flw     fa5,-44(s0)       # tmp313, T
        fadd.s  fa3,fa5,fa5 # _31, tmp313, tmp313
        lw      a5,-120(s0)   # tmp314, intruder
        flw     fa5,84(a5)        # _32, intruder_192(D)->_hmdf_cov[0][1]
        fmul.s  fa5,fa3,fa5 # _33, _31, _32
        fadd.s  fa4,fa4,fa5 # _34, _30, _33
        flw     fa5,-44(s0)       # tmp315, T
        fmul.s  fa3,fa5,fa5 # _35, tmp315, tmp315
        lw      a5,-120(s0)   # tmp316, intruder
        flw     fa5,92(a5)        # _36, intruder_192(D)->_hmdf_cov[1][1]
        fmul.s  fa5,fa3,fa5 # _37, _35, _36
        fadd.s  fa4,fa4,fa5 # _38, _34, _37
        flw     fa5,-44(s0)       # tmp317, T
        fmul.s  fa3,fa5,fa5 # _39, tmp317, tmp317
        flw     fa5,-44(s0)       # tmp318, T
        fmul.s  fa3,fa3,fa5 # _40, _39, tmp318
        flw     fa5,-44(s0)       # tmp319, T
        fmul.s  fa3,fa3,fa5 # _41, _40, tmp319
        flw     fa5,-40(s0)       # tmp320, Q
        fmul.s  fa3,fa3,fa5 # _42, _41, tmp320
        lui     a5,%hi(.LC28)     # tmp322,
        flw     fa5,%lo(.LC28)(a5)        # tmp321,
        fdiv.s  fa5,fa3,fa5 # _43, _42, tmp321
        fadd.s  fa5,fa4,fa5 # _44, _38, _43
        lw      a5,-120(s0)   # tmp323, intruder
        fsw     fa5,80(a5)        # _44, intruder_192(D)->_hmdf_cov[0][0]
        lw      a5,-120(s0)   # tmp324, intruder
        flw     fa4,84(a5)        # _45, intruder_192(D)->_hmdf_cov[0][1]
        lw      a5,-120(s0)   # tmp325, intruder
        flw     fa3,92(a5)        # _46, intruder_192(D)->_hmdf_cov[1][1]
        flw     fa5,-44(s0)       # tmp326, T
        fmul.s  fa5,fa3,fa5 # _47, _46, tmp326
        fadd.s  fa4,fa4,fa5 # _48, _45, _47
        flw     fa5,-44(s0)       # tmp327, T
        fmul.s  fa3,fa5,fa5 # _49, tmp327, tmp327
        flw     fa5,-44(s0)       # tmp328, T
        fmul.s  fa3,fa3,fa5 # _50, _49, tmp328
        flw     fa5,-40(s0)       # tmp329, Q
        fmul.s  fa3,fa3,fa5 # _51, _50, tmp329
        lui     a5,%hi(.LC20)     # tmp331,
        flw     fa5,%lo(.LC20)(a5)        # tmp330,
        fdiv.s  fa5,fa3,fa5 # _52, _51, tmp330
        fadd.s  fa5,fa4,fa5 # _53, _48, _52
        lw      a5,-120(s0)   # tmp332, intruder
        fsw     fa5,84(a5)        # _53, intruder_192(D)->_hmdf_cov[0][1]
        lw      a5,-120(s0)   # tmp333, intruder
        flw     fa4,88(a5)        # _54, intruder_192(D)->_hmdf_cov[1][0]
        lw      a5,-120(s0)   # tmp334, intruder
        flw     fa3,92(a5)        # _55, intruder_192(D)->_hmdf_cov[1][1]
        flw     fa5,-44(s0)       # tmp335, T
        fmul.s  fa5,fa3,fa5 # _56, _55, tmp335
        fadd.s  fa4,fa4,fa5 # _57, _54, _56
        flw     fa5,-44(s0)       # tmp336, T
        fmul.s  fa3,fa5,fa5 # _58, tmp336, tmp336
        flw     fa5,-44(s0)       # tmp337, T
        fmul.s  fa3,fa3,fa5 # _59, _58, tmp337
        flw     fa5,-40(s0)       # tmp338, Q
        fmul.s  fa3,fa3,fa5 # _60, _59, tmp338
        lui     a5,%hi(.LC20)     # tmp340,
        flw     fa5,%lo(.LC20)(a5)        # tmp339,
        fdiv.s  fa5,fa3,fa5 # _61, _60, tmp339
        fadd.s  fa5,fa4,fa5 # _62, _57, _61
        lw      a5,-120(s0)   # tmp341, intruder
        fsw     fa5,88(a5)        # _62, intruder_192(D)->_hmdf_cov[1][0]
        lw      a5,-120(s0)   # tmp342, intruder
        flw     fa4,92(a5)        # _63, intruder_192(D)->_hmdf_cov[1][1]
        flw     fa5,-44(s0)       # tmp343, T
        fmul.s  fa3,fa5,fa5 # _64, tmp343, tmp343
        flw     fa5,-40(s0)       # tmp344, Q
        fmul.s  fa5,fa3,fa5 # _65, _64, tmp344
        fadd.s  fa5,fa4,fa5 # _66, _63, _65
        lw      a5,-120(s0)   # tmp345, intruder
        fsw     fa5,92(a5)        # _66, intruder_192(D)->_hmdf_cov[1][1]
.L66:
        lw      a5,-120(s0)   # tmp346, intruder
        flw     fa4,80(a5)        # _67, intruder_192(D)->_hmdf_cov[0][0]
        flw     fa5,-48(s0)       # tmp347, slant_range
        fmul.s  fa3,fa5,fa5 # _68, tmp347, tmp347
        flw     fa5,-36(s0)       # tmp348, sigma_theta
        fmul.s  fa3,fa3,fa5 # _69, _68, tmp348
        flw     fa5,-36(s0)       # tmp349, sigma_theta
        fmul.s  fa5,fa3,fa5 # _70, _69, tmp349
        fadd.s  fa5,fa4,fa5 # tmp350, _67, _70
        fsw     fa5,-80(s0)       # tmp350, C_mu
        flw     fa5,-80(s0)       # tmp351, C_mu
        fmv.w.x fa4,zero  # tmp352,
        fgt.s   a5,fa5,fa4    #, tmp353, tmp351, tmp352
        beq     a5,zero,.L95      #, tmp353,,
        lw      a5,-120(s0)   # tmp354, intruder
        flw     fa5,80(a5)        # _71, intruder_192(D)->_hmdf_cov[0][0]
        fcvt.d.s        fa4,fa5 # _72, _71
        flw     fa5,-80(s0)       # tmp355, C_mu
        fmv.w.x fa3,zero  # tmp356,
        feq.s   a5,fa5,fa3    #, tmp357, tmp355, tmp356
        bne     a5,zero,.L69      #, tmp357,,
        flw     fa5,-80(s0)       # tmp358, C_mu
        fcvt.d.s        fa5,fa5 # iftmp.8_177, tmp358
        j       .L70      #
.L69:
        lui     a5,%hi(.LC18)     # tmp359,
        fld     fa5,%lo(.LC18)(a5)        # iftmp.8_177,
.L70:
        fdiv.d  fa5,fa4,fa5 # _73, _72, iftmp.8_177
        fcvt.s.d        fa5,fa5 # iftmp.7_176, _73
        j       .L71      #
.L95:
        fmv.w.x fa5,zero  # iftmp.7_176,
.L71:
        fsw     fa5,-84(s0)       # iftmp.7_176, alpha_x
        flw     fa5,-80(s0)       # tmp360, C_mu
        fmv.w.x fa4,zero  # tmp361,
        fgt.s   a5,fa5,fa4    #, tmp362, tmp360, tmp361
        beq     a5,zero,.L96      #, tmp362,,
        lw      a5,-120(s0)   # tmp363, intruder
        flw     fa5,88(a5)        # _74, intruder_192(D)->_hmdf_cov[1][0]
        fcvt.d.s        fa4,fa5 # _75, _74
        flw     fa5,-80(s0)       # tmp364, C_mu
        fmv.w.x fa3,zero  # tmp365,
        feq.s   a5,fa5,fa3    #, tmp366, tmp364, tmp365
        bne     a5,zero,.L74      #, tmp366,,
        flw     fa5,-80(s0)       # tmp367, C_mu
        fcvt.d.s        fa5,fa5 # iftmp.10_179, tmp367
        j       .L75      #
.L74:
        lui     a5,%hi(.LC18)     # tmp368,
        fld     fa5,%lo(.LC18)(a5)        # iftmp.10_179,
.L75:
        fdiv.d  fa5,fa4,fa5 # _76, _75, iftmp.10_179
        fcvt.s.d        fa5,fa5 # iftmp.9_178, _76
        j       .L76      #
.L96:
        fmv.w.x fa5,zero  # iftmp.9_178,
.L76:
        fsw     fa5,-88(s0)       # iftmp.9_178, beta_x
        lw      a5,-120(s0)   # tmp369, intruder
        lbu     a4,100(a5)        # _77, intruder_192(D)->_hmdf_hits
        li      a5,2                # tmp370,
        bleu    a4,a5,.L77      #, _77, tmp370,
        lui     a5,%hi(.LC19)     # tmp372,
        flw     fa4,%lo(.LC19)(a5)        # tmp371,
        flw     fa5,-84(s0)       # tmp373, alpha_x
        fsub.s  fa4,fa4,fa5 # _78, tmp371, tmp373
        lw      a5,-120(s0)   # tmp374, intruder
        flw     fa5,80(a5)        # _79, intruder_192(D)->_hmdf_cov[0][0]
        fmul.s  fa5,fa4,fa5 # _80, _78, _79
        lw      a5,-120(s0)   # tmp375, intruder
        fsw     fa5,80(a5)        # _80, intruder_192(D)->_hmdf_cov[0][0]
        lui     a5,%hi(.LC19)     # tmp377,
        flw     fa4,%lo(.LC19)(a5)        # tmp376,
        flw     fa5,-84(s0)       # tmp378, alpha_x
        fsub.s  fa4,fa4,fa5 # _81, tmp376, tmp378
        lw      a5,-120(s0)   # tmp379, intruder
        flw     fa5,84(a5)        # _82, intruder_192(D)->_hmdf_cov[0][1]
        fmul.s  fa5,fa4,fa5 # _83, _81, _82
        lw      a5,-120(s0)   # tmp380, intruder
        fsw     fa5,84(a5)        # _83, intruder_192(D)->_hmdf_cov[0][1]
        lui     a5,%hi(.LC19)     # tmp382,
        flw     fa4,%lo(.LC19)(a5)        # tmp381,
        flw     fa5,-84(s0)       # tmp383, alpha_x
        fsub.s  fa4,fa4,fa5 # _84, tmp381, tmp383
        lw      a5,-120(s0)   # tmp384, intruder
        flw     fa5,88(a5)        # _85, intruder_192(D)->_hmdf_cov[1][0]
        fmul.s  fa5,fa4,fa5 # _86, _84, _85
        lw      a5,-120(s0)   # tmp385, intruder
        fsw     fa5,88(a5)        # _86, intruder_192(D)->_hmdf_cov[1][0]
        lw      a5,-120(s0)   # tmp386, intruder
        flw     fa4,92(a5)        # _87, intruder_192(D)->_hmdf_cov[1][1]
        lw      a5,-120(s0)   # tmp387, intruder
        flw     fa3,84(a5)        # _88, intruder_192(D)->_hmdf_cov[0][1]
        flw     fa5,-88(s0)       # tmp388, beta_x
        fmul.s  fa5,fa3,fa5 # _89, _88, tmp388
        fsub.s  fa5,fa4,fa5 # _90, _87, _89
        lw      a5,-120(s0)   # tmp389, intruder
        fsw     fa5,92(a5)        # _90, intruder_192(D)->_hmdf_cov[1][1]
.L77:
        lw      a5,-120(s0)   # tmp390, intruder
        flw     fa4,64(a5)        # _91, intruder_192(D)->_hmdf_RPX
        lw      a5,-120(s0)   # tmp391, intruder
        lbu     a5,100(a5)        # _92, intruder_192(D)->_hmdf_hits
        mv      a3,a5       # _93, _92
        lui     a5,%hi(HMDF_BBT_a)        # tmp392,
        addi    a4,a5,%lo(HMDF_BBT_a)   # tmp393, tmp392,
        slli    a5,a3,1 #, tmp394, _93
        add     a5,a4,a5  # tmp394, tmp395, tmp393
        lhu     a5,0(a5)  # _94, HMDF_BBT_a[_93]
        fcvt.s.w        fa3,a5  # _96, _95
        flw     fa5,-72(s0)       # tmp396, range
        fmul.s  fa3,fa3,fa5 # _97, _96, tmp396
        flw     fa5,-56(s0)       # tmp397, s_theta
        fmul.s  fa5,fa3,fa5 # _98, _97, tmp397
        fadd.s  fa4,fa4,fa5 # _99, _91, _98
        flw     fa3,-84(s0)       # tmp398, alpha_x
        flw     fa5,-76(s0)       # tmp399, xrange
        fmul.s  fa3,fa3,fa5 # _100, tmp398, tmp399
        flw     fa5,-60(s0)       # tmp400, c_theta
        fmul.s  fa5,fa3,fa5 # _101, _100, tmp400
        fsub.s  fa5,fa4,fa5 # tmp401, _99, _101
        fsw     fa5,-92(s0)       # tmp401, RBX
        lw      a5,-120(s0)   # tmp402, intruder
        flw     fa4,68(a5)        # _102, intruder_192(D)->_hmdf_RPY
        lw      a5,-120(s0)   # tmp403, intruder
        lbu     a5,100(a5)        # _103, intruder_192(D)->_hmdf_hits
        mv      a3,a5       # _104, _103
        lui     a5,%hi(HMDF_BBT_a)        # tmp404,
        addi    a4,a5,%lo(HMDF_BBT_a)   # tmp405, tmp404,
        slli    a5,a3,1 #, tmp406, _104
        add     a5,a4,a5  # tmp406, tmp407, tmp405
        lhu     a5,0(a5)  # _105, HMDF_BBT_a[_104]
        fcvt.s.w        fa3,a5  # _107, _106
        flw     fa5,-72(s0)       # tmp408, range
        fmul.s  fa3,fa3,fa5 # _108, _107, tmp408
        flw     fa5,-60(s0)       # tmp409, c_theta
        fmul.s  fa5,fa3,fa5 # _109, _108, tmp409
        fadd.s  fa4,fa4,fa5 # _110, _102, _109
        flw     fa3,-84(s0)       # tmp410, alpha_x
        flw     fa5,-76(s0)       # tmp411, xrange
        fmul.s  fa3,fa3,fa5 # _111, tmp410, tmp411
        flw     fa5,-56(s0)       # tmp412, s_theta
        fmul.s  fa5,fa3,fa5 # _112, _111, tmp412
        fsub.s  fa5,fa4,fa5 # tmp413, _110, _112
        fsw     fa5,-96(s0)       # tmp413, RBY
        lw      a5,-120(s0)   # tmp414, intruder
        flw     fa5,72(a5)        # _113, intruder_192(D)->_hmdf_VPX
        fcvt.d.s        fa4,fa5 # _114, _113
        lw      a5,-120(s0)   # tmp415, intruder
        lbu     a5,100(a5)        # _115, intruder_192(D)->_hmdf_hits
        mv      a3,a5       # _116, _115
        lui     a5,%hi(HMDF_BBT_b)        # tmp416,
        addi    a4,a5,%lo(HMDF_BBT_b)   # tmp417, tmp416,
        slli    a5,a3,1 #, tmp418, _116
        add     a5,a4,a5  # tmp418, tmp419, tmp417
        lhu     a5,0(a5)  # _117, HMDF_BBT_b[_116]
        fcvt.d.w        fa3,a5  # _119, _118
        flw     fa2,-44(s0)       # tmp420, T
        flw     fa5,-72(s0)       # tmp421, range
        fmul.s  fa2,fa2,fa5 # _120, tmp420, tmp421
        flw     fa5,-56(s0)       # tmp422, s_theta
        fmul.s  fa5,fa2,fa5 # _121, _120, tmp422
        fmv.w.x fa2,zero  # tmp423,
        feq.s   a5,fa5,fa2    #, tmp424, _121, tmp423
        bne     a5,zero,.L78      #, tmp424,,
        flw     fa2,-44(s0)       # tmp425, T
        flw     fa5,-72(s0)       # tmp426, range
        fmul.s  fa2,fa2,fa5 # _122, tmp425, tmp426
        flw     fa5,-56(s0)       # tmp427, s_theta
        fmul.s  fa5,fa2,fa5 # _123, _122, tmp427
        fcvt.d.s        fa5,fa5 # iftmp.11_180, _123
        j       .L79      #
.L78:
        lui     a5,%hi(.LC18)     # tmp428,
        fld     fa5,%lo(.LC18)(a5)        # iftmp.11_180,
.L79:
        fdiv.d  fa5,fa3,fa5 # _124, _119, iftmp.11_180
        fadd.d  fa4,fa4,fa5 # _125, _114, _124
        flw     fa5,-88(s0)       # tmp429, beta_x
        fcvt.d.s        fa3,fa5 # _126, tmp429
        flw     fa2,-44(s0)       # tmp430, T
        flw     fa5,-76(s0)       # tmp431, xrange
        fmul.s  fa2,fa2,fa5 # _127, tmp430, tmp431
        flw     fa5,-60(s0)       # tmp432, c_theta
        fmul.s  fa5,fa2,fa5 # _128, _127, tmp432
        fmv.w.x fa2,zero  # tmp433,
        feq.s   a5,fa5,fa2    #, tmp434, _128, tmp433
        bne     a5,zero,.L80      #, tmp434,,
        flw     fa2,-44(s0)       # tmp435, T
        flw     fa5,-76(s0)       # tmp436, xrange
        fmul.s  fa2,fa2,fa5 # _129, tmp435, tmp436
        flw     fa5,-60(s0)       # tmp437, c_theta
        fmul.s  fa5,fa2,fa5 # _130, _129, tmp437
        fcvt.d.s        fa5,fa5 # iftmp.12_181, _130
        j       .L81      #
.L80:
        lui     a5,%hi(.LC18)     # tmp438,
        fld     fa5,%lo(.LC18)(a5)        # iftmp.12_181,
.L81:
        fdiv.d  fa5,fa3,fa5 # _131, _126, iftmp.12_181
        fsub.d  fa5,fa4,fa5 # _132, _125, _131
        fcvt.s.d        fa5,fa5 # tmp439, _132
        fsw     fa5,-100(s0)      # tmp439, VBX
        lw      a5,-120(s0)   # tmp440, intruder
        flw     fa5,76(a5)        # _133, intruder_192(D)->_hmdf_VPY
        fcvt.d.s        fa4,fa5 # _134, _133
        lw      a5,-120(s0)   # tmp441, intruder
        lbu     a5,100(a5)        # _135, intruder_192(D)->_hmdf_hits
        mv      a3,a5       # _136, _135
        lui     a5,%hi(HMDF_BBT_b)        # tmp442,
        addi    a4,a5,%lo(HMDF_BBT_b)   # tmp443, tmp442,
        slli    a5,a3,1 #, tmp444, _136
        add     a5,a4,a5  # tmp444, tmp445, tmp443
        lhu     a5,0(a5)  # _137, HMDF_BBT_b[_136]
        fcvt.d.w        fa3,a5  # _139, _138
        flw     fa2,-44(s0)       # tmp446, T
        flw     fa5,-72(s0)       # tmp447, range
        fmul.s  fa2,fa2,fa5 # _140, tmp446, tmp447
        flw     fa5,-60(s0)       # tmp448, c_theta
        fmul.s  fa5,fa2,fa5 # _141, _140, tmp448
        fmv.w.x fa2,zero  # tmp449,
        feq.s   a5,fa5,fa2    #, tmp450, _141, tmp449
        bne     a5,zero,.L82      #, tmp450,,
        flw     fa2,-44(s0)       # tmp451, T
        flw     fa5,-72(s0)       # tmp452, range
        fmul.s  fa2,fa2,fa5 # _142, tmp451, tmp452
        flw     fa5,-60(s0)       # tmp453, c_theta
        fmul.s  fa5,fa2,fa5 # _143, _142, tmp453
        fcvt.d.s        fa5,fa5 # iftmp.13_182, _143
        j       .L83      #
.L82:
        lui     a5,%hi(.LC18)     # tmp454,
        fld     fa5,%lo(.LC18)(a5)        # iftmp.13_182,
.L83:
        fdiv.d  fa5,fa3,fa5 # _144, _139, iftmp.13_182
        fadd.d  fa4,fa4,fa5 # _145, _134, _144
        flw     fa5,-88(s0)       # tmp455, beta_x
        fcvt.d.s        fa3,fa5 # _146, tmp455
        flw     fa2,-44(s0)       # tmp456, T
        flw     fa5,-76(s0)       # tmp457, xrange
        fmul.s  fa2,fa2,fa5 # _147, tmp456, tmp457
        flw     fa5,-56(s0)       # tmp458, s_theta
        fmul.s  fa5,fa2,fa5 # _148, _147, tmp458
        fmv.w.x fa2,zero  # tmp459,
        feq.s   a5,fa5,fa2    #, tmp460, _148, tmp459
        bne     a5,zero,.L84      #, tmp460,,
        flw     fa2,-44(s0)       # tmp461, T
        flw     fa5,-76(s0)       # tmp462, xrange
        fmul.s  fa2,fa2,fa5 # _149, tmp461, tmp462
        flw     fa5,-56(s0)       # tmp463, s_theta
        fmul.s  fa5,fa2,fa5 # _150, _149, tmp463
        fcvt.d.s        fa5,fa5 # iftmp.14_183, _150
        j       .L85      #
.L84:
        lui     a5,%hi(.LC18)     # tmp464,
        fld     fa5,%lo(.LC18)(a5)        # iftmp.14_183,
.L85:
        fdiv.d  fa5,fa3,fa5 # _151, _146, iftmp.14_183
        fsub.d  fa5,fa4,fa5 # _152, _145, _151
        fcvt.s.d        fa5,fa5 # tmp465, _152
        fsw     fa5,-104(s0)      # tmp465, VBY
        lw      a5,-120(s0)   # tmp466, intruder
        flw     fa5,-100(s0)      # tmp467, VBX
        fsw     fa5,72(a5)        # tmp467, intruder_192(D)->_hmdf_VPX
        lw      a5,-120(s0)   # tmp468, intruder
        flw     fa5,-104(s0)      # tmp469, VBY
        fsw     fa5,76(a5)        # tmp469, intruder_192(D)->_hmdf_VPY
        flw     fa4,-44(s0)       # tmp470, T
        flw     fa5,-100(s0)      # tmp471, VBX
        fmul.s  fa4,fa4,fa5 # _153, tmp470, tmp471
        flw     fa5,-92(s0)       # tmp472, RBX
        fadd.s  fa5,fa4,fa5 # _154, _153, tmp472
        lw      a5,-120(s0)   # tmp473, intruder
        fsw     fa5,64(a5)        # _154, intruder_192(D)->_hmdf_RPX
        flw     fa4,-44(s0)       # tmp474, T
        flw     fa5,-104(s0)      # tmp475, VBY
        fmul.s  fa4,fa4,fa5 # _155, tmp474, tmp475
        flw     fa5,-96(s0)       # tmp476, RBY
        fadd.s  fa5,fa4,fa5 # _156, _155, tmp476
        lw      a5,-120(s0)   # tmp477, intruder
        fsw     fa5,68(a5)        # _156, intruder_192(D)->_hmdf_RPY
        flw     fa4,-92(s0)       # tmp478, RBX
        flw     fa5,-104(s0)      # tmp479, VBY
        fmul.s  fa4,fa4,fa5 # _157, tmp478, tmp479
        flw     fa3,-96(s0)       # tmp480, RBY
        flw     fa5,-100(s0)      # tmp481, VBX
        fmul.s  fa5,fa3,fa5 # _158, tmp480, tmp481
        fsub.s  fa5,fa4,fa5 # _159, _157, _158
        fmv.w.x fa4,zero  # tmp482,
        fge.s   a5,fa5,fa4    #, tmp483, _159, tmp482
        beq     a5,zero,.L97      #, tmp483,,
        flw     fa4,-92(s0)       # tmp484, RBX
        flw     fa5,-104(s0)      # tmp485, VBY
        fmul.s  fa4,fa4,fa5 # _160, tmp484, tmp485
        flw     fa3,-96(s0)       # tmp486, RBY
        flw     fa5,-100(s0)      # tmp487, VBX
        fmul.s  fa5,fa3,fa5 # _161, tmp486, tmp487
        fsub.s  fa5,fa4,fa5 # iftmp.15_184, _160, _161
        j       .L88      #
.L97:
        flw     fa4,-92(s0)       # tmp488, RBX
        flw     fa5,-104(s0)      # tmp489, VBY
        fmul.s  fa4,fa4,fa5 # _162, tmp488, tmp489
        flw     fa3,-96(s0)       # tmp490, RBY
        flw     fa5,-100(s0)      # tmp491, VBX
        fmul.s  fa5,fa3,fa5 # _163, tmp490, tmp491
        fsub.s  fa5,fa4,fa5 # _164, _162, _163
        fneg.s  fa5,fa5     # iftmp.15_184, _164
.L88:
        fcvt.d.s        fs0,fa5 # _165, iftmp.15_184
        flw     fa5,-100(s0)      # tmp492, VBX
        fmul.s  fa4,fa5,fa5 # _166, tmp492, tmp492
        flw     fa5,-104(s0)      # tmp493, VBY
        fmul.s  fa5,fa5,fa5 # _167, tmp493, tmp493
        fadd.s  fa5,fa4,fa5 # _168, _166, _167
        fcvt.d.s        fa5,fa5 # _169, _168
        fmv.d   fa0,fa5       #, _169
        call    sqrt            #
        fmv.d   fa5,fa0       # _170,
        fcvt.d.w        fa4,x0  # tmp494
        feq.d   a5,fa5,fa4    #, tmp495, _170, tmp494
        bne     a5,zero,.L89      #, tmp495,,
        flw     fa5,-100(s0)      # tmp496, VBX
        fmul.s  fa4,fa5,fa5 # _171, tmp496, tmp496
        flw     fa5,-104(s0)      # tmp497, VBY
        fmul.s  fa5,fa5,fa5 # _172, tmp497, tmp497
        fadd.s  fa5,fa4,fa5 # _173, _171, _172
        fcvt.d.s        fa5,fa5 # _174, _173
        fmv.d   fa0,fa5       #, _174
        call    sqrt            #
        fmv.d   fa5,fa0       # iftmp.16_185,
        j       .L90      #
.L89:
        lui     a5,%hi(.LC18)     # tmp498,
        fld     fa5,%lo(.LC18)(a5)        # iftmp.16_185,
.L90:
        fdiv.d  fa5,fs0,fa5 # _175, _165, iftmp.16_185
        fcvt.s.d        fa5,fa5 # _247, _175
        fmv.s   fa0,fa5       #, <retval>
        lw      ra,124(sp)      #,
        lw      s0,120(sp)      #,
        fld     fs0,104(sp)       #,
        addi    sp,sp,128       #,,
        jr      ra      #
get_threshold:
        addi    sp,sp,-32       #,,
        sw      s0,28(sp)   #,
        addi    s0,sp,32        #,,
        sw      a0,-20(s0)  # sensitivity_level, sensitivity_level
        fsw     fa0,-24(s0)       # ttg_cpa, ttg_cpa
        flw     fa4,-24(s0)       # tmp74, ttg_cpa
        lui     a5,%hi(.LC29)     # tmp76,
        flw     fa5,%lo(.LC29)(a5)        # tmp75,
        fge.s   a5,fa4,fa5    #, tmp77, tmp74, tmp75
        beq     a5,zero,.L140     #, tmp77,,
        fmv.w.x fa5,zero  # _1,
        j       .L101   #
.L140:
        lw      a4,-20(s0)      # tmp78, sensitivity_level
        li      a5,2                # tmp79,
        bgt     a4,a5,.L102       #, tmp78, tmp79,
        flw     fa4,-24(s0)       # tmp80, ttg_cpa
        lui     a5,%hi(.LC30)     # tmp82,
        flw     fa5,%lo(.LC30)(a5)        # tmp81,
        fge.s   a5,fa4,fa5    #, tmp83, tmp80, tmp81
        beq     a5,zero,.L141     #, tmp83,,
        fmv.w.x fa5,zero  # _1,
        j       .L101   #
.L141:
        lui     a5,%hi(.LC31)     # tmp84,
        flw     fa5,%lo(.LC31)(a5)        # _1,
        j       .L101   #
.L102:
        lw      a4,-20(s0)      # tmp85, sensitivity_level
        li      a5,3                # tmp86,
        bne     a4,a5,.L105       #, tmp85, tmp86,
        flw     fa4,-24(s0)       # tmp87, ttg_cpa
        lui     a5,%hi(.LC32)     # tmp89,
        flw     fa5,%lo(.LC32)(a5)        # tmp88,
        fge.s   a5,fa4,fa5    #, tmp90, tmp87, tmp88
        beq     a5,zero,.L142     #, tmp90,,
        fmv.w.x fa5,zero  # _1,
        j       .L101   #
.L142:
        lui     a5,%hi(.LC33)     # tmp91,
        flw     fa5,%lo(.LC33)(a5)        # _1,
        j       .L101   #
.L105:
        lw      a4,-20(s0)      # tmp92, sensitivity_level
        li      a5,4                # tmp93,
        bne     a4,a5,.L108       #, tmp92, tmp93,
        flw     fa4,-24(s0)       # tmp94, ttg_cpa
        lui     a5,%hi(.LC34)     # tmp96,
        flw     fa5,%lo(.LC34)(a5)        # tmp95,
        fge.s   a5,fa4,fa5    #, tmp97, tmp94, tmp95
        beq     a5,zero,.L143     #, tmp97,,
        fmv.w.x fa5,zero  # _1,
        j       .L101   #
.L143:
        flw     fa4,-24(s0)       # tmp98, ttg_cpa
        lui     a5,%hi(.LC35)     # tmp100,
        flw     fa5,%lo(.LC35)(a5)        # tmp99,
        fge.s   a5,fa4,fa5    #, tmp101, tmp98, tmp99
        beq     a5,zero,.L144     #, tmp101,,
        lui     a5,%hi(.LC36)     # tmp102,
        flw     fa5,%lo(.LC36)(a5)        # _1,
        j       .L101   #
.L144:
        lui     a5,%hi(.LC37)     # tmp103,
        flw     fa5,%lo(.LC37)(a5)        # _1,
        j       .L101   #
.L108:
        lw      a4,-20(s0)      # tmp104, sensitivity_level
        li      a5,5                # tmp105,
        bne     a4,a5,.L113       #, tmp104, tmp105,
        flw     fa4,-24(s0)       # tmp106, ttg_cpa
        lui     a5,%hi(.LC38)     # tmp108,
        flw     fa5,%lo(.LC38)(a5)        # tmp107,
        fge.s   a5,fa4,fa5    #, tmp109, tmp106, tmp107
        beq     a5,zero,.L145     #, tmp109,,
        fmv.w.x fa5,zero  # _1,
        j       .L101   #
.L145:
        flw     fa4,-24(s0)       # tmp110, ttg_cpa
        lui     a5,%hi(.LC39)     # tmp112,
        flw     fa5,%lo(.LC39)(a5)        # tmp111,
        fge.s   a5,fa4,fa5    #, tmp113, tmp110, tmp111
        beq     a5,zero,.L146     #, tmp113,,
        lui     a5,%hi(.LC40)     # tmp114,
        flw     fa5,%lo(.LC40)(a5)        # _1,
        j       .L101   #
.L146:
        flw     fa4,-24(s0)       # tmp115, ttg_cpa
        lui     a5,%hi(.LC41)     # tmp117,
        flw     fa5,%lo(.LC41)(a5)        # tmp116,
        fge.s   a5,fa4,fa5    #, tmp118, tmp115, tmp116
        beq     a5,zero,.L147     #, tmp118,,
        lui     a5,%hi(.LC36)     # tmp119,
        flw     fa5,%lo(.LC36)(a5)        # _1,
        j       .L101   #
.L147:
        lui     a5,%hi(.LC42)     # tmp120,
        flw     fa5,%lo(.LC42)(a5)        # _1,
        j       .L101   #
.L113:
        flw     fa4,-24(s0)       # tmp121, ttg_cpa
        lui     a5,%hi(.LC43)     # tmp123,
        flw     fa5,%lo(.LC43)(a5)        # tmp122,
        fge.s   a5,fa4,fa5    #, tmp124, tmp121, tmp122
        beq     a5,zero,.L148     #, tmp124,,
        lui     a5,%hi(.LC44)     # tmp125,
        flw     fa5,%lo(.LC44)(a5)        # _1,
        j       .L101   #
.L148:
        flw     fa4,-24(s0)       # tmp126, ttg_cpa
        lui     a5,%hi(.LC45)     # tmp128,
        flw     fa5,%lo(.LC45)(a5)        # tmp127,
        fge.s   a5,fa4,fa5    #, tmp129, tmp126, tmp127
        beq     a5,zero,.L149     #, tmp129,,
        lui     a5,%hi(.LC46)     # tmp130,
        flw     fa5,%lo(.LC46)(a5)        # _1,
        j       .L101   #
.L149:
        flw     fa4,-24(s0)       # tmp131, ttg_cpa
        lui     a5,%hi(.LC34)     # tmp133,
        flw     fa5,%lo(.LC34)(a5)        # tmp132,
        fge.s   a5,fa4,fa5    #, tmp134, tmp131, tmp132
        beq     a5,zero,.L150     #, tmp134,,
        lui     a5,%hi(.LC47)     # tmp135,
        flw     fa5,%lo(.LC47)(a5)        # _1,
        j       .L101   #
.L150:
        flw     fa4,-24(s0)       # tmp136, ttg_cpa
        lui     a5,%hi(.LC30)     # tmp138,
        flw     fa5,%lo(.LC30)(a5)        # tmp137,
        fge.s   a5,fa4,fa5    #, tmp139, tmp136, tmp137
        beq     a5,zero,.L151     #, tmp139,,
        lui     a5,%hi(.LC48)     # tmp140,
        flw     fa5,%lo(.LC48)(a5)        # _1,
        j       .L101   #
.L151:
        lui     a5,%hi(.LC40)     # tmp141,
        flw     fa5,%lo(.LC40)(a5)        # _1,
.L101:
        fmv.s   fa0,fa5       #, <retval>
        lw      s0,28(sp)         #,
        addi    sp,sp,32        #,,
        jr      ra      #
is_manoeuvring_filter_1:
        addi    sp,sp,-32       #,,
        sw      s0,28(sp)   #,
        addi    s0,sp,32        #,,
        sw      a0,-20(s0)  # intruder, intruder
        lw      a5,-20(s0)      # tmp84, intruder
        flw     fa5,96(a5)        # _1, intruder_12(D)->_hmdf_dAs
        fcvt.d.s        fa4,fa5 # _2, _1
        lui     a5,%hi(.LC49)     # tmp86,
        fld     fa5,%lo(.LC49)(a5)        # tmp85,
        fmul.d  fa4,fa4,fa5 # _3, _2, tmp85
        lw      a5,-20(s0)      # tmp87, intruder
        flw     fa5,56(a5)        # _4, intruder_12(D)->_hmdf_diff_ApAs
        fcvt.d.s        fa3,fa5 # _5, _4
        lui     a5,%hi(.LC50)     # tmp89,
        fld     fa5,%lo(.LC50)(a5)        # tmp88,
        fmul.d  fa5,fa3,fa5 # _6, _5, tmp88
        fadd.d  fa5,fa4,fa5 # _7, _3, _6
        fcvt.s.d        fa5,fa5 # _8, _7
        lw      a5,-20(s0)      # tmp90, intruder
        fsw     fa5,96(a5)        # _8, intruder_12(D)->_hmdf_dAs
        lw      a5,-20(s0)      # tmp91, intruder
        flw     fa5,96(a5)        # _9, intruder_12(D)->_hmdf_dAs
        fmv.w.x fa4,zero  # tmp93,
        flt.s   a5,fa5,fa4    #, tmp95, _9, tmp93
        snez    a5,a5   # tmp96, tmp95
        andi    a5,a5,0xff      # _10, tmp92
        mv      a0,a5       #, <retval>
        lw      s0,28(sp)         #,
        addi    sp,sp,32        #,,
        jr      ra      #
is_manoeuvring_filter_2:
        addi    sp,sp,-32       #,,
        sw      s0,28(sp)   #,
        addi    s0,sp,32        #,,
        sw      a0,-20(s0)  # intruder, intruder
        fsw     fa0,-24(s0)       # threshold_accuracy, threshold_accuracy
        lw      a5,-20(s0)      # tmp78, intruder
        flw     fa4,56(a5)        # _1, intruder_6(D)->_hmdf_diff_ApAs
        lw      a5,-20(s0)      # tmp79, intruder
        flw     fa5,52(a5)        # _2, intruder_6(D)->_hmdf_Ap
        fsub.s  fa5,fa4,fa5 # _3, _1, _2
        flw     fa4,-24(s0)       # tmp81, threshold_accuracy
        flt.s   a5,fa4,fa5    #, tmp83, tmp81, _3
        snez    a5,a5   # tmp84, tmp83
        andi    a5,a5,0xff      # _4, tmp80
        mv      a0,a5       #, <retval>
        lw      s0,28(sp)         #,
        addi    sp,sp,32        #,,
        jr      ra      #
is_manoeuvring_filter_3_4:
        addi    sp,sp,-80       #,,
        sw      ra,76(sp)   #,
        sw      s0,72(sp)   #,
        addi    s0,sp,80        #,,
        sw      a0,-52(s0)  # intruder, intruder
        fsw     fa0,-56(s0)       # threshold_accuracy, threshold_accuracy
        sw      a1,-60(s0)  # As, As
        sw      a2,-64(s0)  # Vs, Vs
        sw      a3,-68(s0)  # Rs, Rs
        lw      a5,-68(s0)      # tmp105, Rs
        flw     fa4,0(a5) # _1, *Rs_35(D)
        lw      a5,-60(s0)      # tmp106, As
        flw     fa5,0(a5) # _2, *As_36(D)
        fmul.s  fa4,fa4,fa5 # _3, _1, _2
        lw      a5,-64(s0)      # tmp107, Vs
        flw     fa3,0(a5) # _4, *Vs_37(D)
        lw      a5,-64(s0)      # tmp108, Vs
        flw     fa5,0(a5) # _5, *Vs_37(D)
        fmul.s  fa5,fa3,fa5 # _6, _4, _5
        fadd.s  fa5,fa4,fa5 # _7, _3, _6
        fcvt.d.s        fa5,fa5 # _8, _7
        fmv.d   fa0,fa5       #, _8
        call    sqrt            #
        fmv.d   fa5,fa0       # _9,
        fcvt.s.d        fa5,fa5 # tmp109, _9
        fsw     fa5,-20(s0)       # tmp109, Vys
        lw      a5,-68(s0)      # tmp110, Rs
        flw     fa4,0(a5) # _10, *Rs_35(D)
        lw      a5,-64(s0)      # tmp111, Vs
        flw     fa5,0(a5) # _11, *Vs_37(D)
        fmul.s  fa4,fa4,fa5 # _12, _10, _11
        flw     fa5,-20(s0)       # tmp113, Vys
        fdiv.s  fa5,fa4,fa5 # tmp112, _12, tmp113
        fsw     fa5,-24(s0)       # tmp112, Rys
        lw      a5,-68(s0)      # tmp114, Rs
        flw     fa4,0(a5) # _13, *Rs_35(D)
        lw      a5,-68(s0)      # tmp115, Rs
        flw     fa5,0(a5) # _14, *Rs_35(D)
        fmul.s  fa4,fa4,fa5 # _15, _13, _14
        flw     fa5,-24(s0)       # tmp116, Rys
        fmul.s  fa5,fa5,fa5 # _16, tmp116, tmp116
        fsub.s  fa5,fa4,fa5 # _17, _15, _16
        fcvt.d.s        fa5,fa5 # _18, _17
        fmv.d   fa0,fa5       #, _18
        call    sqrt            #
        fmv.d   fa5,fa0       # _19,
        fcvt.s.d        fa5,fa5 # tmp117, _19
        fsw     fa5,-28(s0)       # tmp117, Rxs
        flw     fa5,-28(s0)       # tmp118, Rxs
        fsw     fa5,-32(s0)       # tmp118, Xp
        lw      a5,-52(s0)      # tmp119, intruder
        flw     fa4,28(a5)        # _20, intruder_44(D)->delta_update_time
        flw     fa5,-20(s0)       # tmp120, Vys
        fmul.s  fa5,fa4,fa5 # _21, _20, tmp120
        flw     fa4,-24(s0)       # tmp122, Rys
        fadd.s  fa5,fa4,fa5 # tmp121, tmp122, _21
        fsw     fa5,-36(s0)       # tmp121, Yp
        flw     fa5,-32(s0)       # tmp123, Xp
        fmul.s  fa4,fa5,fa5 # _22, tmp123, tmp123
        flw     fa5,-36(s0)       # tmp124, Yp
        fmul.s  fa5,fa5,fa5 # _23, tmp124, tmp124
        fadd.s  fa5,fa4,fa5 # _24, _22, _23
        fcvt.d.s        fa5,fa5 # _25, _24
        fmv.d   fa0,fa5       #, _25
        call    sqrt            #
        fmv.d   fa5,fa0       # _26,
        fcvt.s.d        fa5,fa5 # tmp125, _26
        fsw     fa5,-40(s0)       # tmp125, Rp2
        flw     fa4,-56(s0)       # tmp126, threshold_accuracy
        lui     a5,%hi(.LC24)     # tmp128,
        flw     fa5,%lo(.LC24)(a5)        # tmp127,
        fdiv.s  fa4,fa4,fa5 # _27, tmp126, tmp127
        lui     a5,%hi(.LC23)     # tmp131,
        flw     fa5,%lo(.LC23)(a5)        # tmp130,
        fmul.s  fa5,fa4,fa5 # tmp129, _27, tmp130
        fsw     fa5,-56(s0)       # tmp129, threshold_accuracy
        flw     fa4,-56(s0)       # tmp132, threshold_accuracy
        lui     a5,%hi(.LC23)     # tmp134,
        flw     fa5,%lo(.LC23)(a5)        # tmp133,
        flt.s   a5,fa4,fa5    #, tmp135, tmp132, tmp133
        beq     a5,zero,.L157     #, tmp135,,
        lui     a5,%hi(.LC23)     # tmp136,
        flw     fa5,%lo(.LC23)(a5)        # tmp137,
        fsw     fa5,-56(s0)       # tmp137, threshold_accuracy
.L157:
        flw     fa4,-56(s0)       # tmp139, threshold_accuracy
        lui     a5,%hi(.LC51)     # tmp141,
        flw     fa5,%lo(.LC51)(a5)        # tmp140,
        fmul.s  fa5,fa4,fa5 # tmp138, tmp139, tmp140
        fsw     fa5,-44(s0)       # tmp138, Trv
        lw      a5,-52(s0)      # tmp142, intruder
        flw     fa4,16(a5)        # _28, intruder_44(D)->slant_range
        flw     fa5,-40(s0)       # tmp143, Rp2
        fsub.s  fa5,fa4,fa5 # _29, _28, tmp143
        flw     fa4,-44(s0)       # tmp144, Trv
        fgt.s   a5,fa4,fa5    #, tmp145, tmp144, _29
        beq     a5,zero,.L167     #, tmp145,,
        li      a5,1                # _33,
        j       .L161   #
.L167:
        lw      a5,-60(s0)      # tmp146, As
        flw     fa4,0(a5) # _30, *As_36(D)
        flw     fa5,-56(s0)       # tmp147, threshold_accuracy
        fneg.s  fa5,fa5     # _31, tmp147
        flt.s   a5,fa4,fa5    #, tmp148, _30, _31
        beq     a5,zero,.L168     #, tmp148,,
        li      a5,1                # _33,
        j       .L161   #
.L168:
        li      a5,0                # _33,
.L161:
        mv      a0,a5       #, <retval>
        lw      ra,76(sp)         #,
        lw      s0,72(sp)         #,
        addi    sp,sp,80        #,,
        jr      ra      #
is_manoeuvring_filter_5:
        addi    sp,sp,-32       #,,
        sw      s0,28(sp)   #,
        addi    s0,sp,32        #,,
        fsw     fa0,-20(s0)       # R_HMD, R_HMD
        fsw     fa1,-24(s0)       # B_HMD, B_HMD
        flw     fa5,-24(s0)       # tmp78, B_HMD
        fcvt.d.s        fa4,fa5 # _1, tmp78
        flw     fa5,-20(s0)       # tmp79, R_HMD
        fcvt.d.s        fa3,fa5 # _2, tmp79
        lui     a5,%hi(.LC52)     # tmp81,
        fld     fa5,%lo(.LC52)(a5)        # tmp80,
        fmul.d  fa5,fa3,fa5 # _3, _2, tmp80
        flt.d   a5,fa4,fa5    #, tmp84, _1, _3
        snez    a5,a5   # tmp85, tmp84
        andi    a5,a5,0xff      # _4, tmp82
        mv      a0,a5       #, <retval>
        lw      s0,28(sp)         #,
        addi    sp,sp,32        #,,
        jr      ra      #
is_manoeuvring:
        addi    sp,sp,-48       #,,
        sw      ra,44(sp)   #,
        sw      s0,40(sp)   #,
        addi    s0,sp,48        #,,
        sw      a0,-20(s0)  # intruder, intruder
        fsw     fa0,-24(s0)       # threshold_accuracy, threshold_accuracy
        fsw     fa1,-28(s0)       # R_HMD, R_HMD
        fsw     fa2,-32(s0)       # B_HMD, B_HMD
        sw      a1,-36(s0)  # As, As
        sw      a2,-40(s0)  # Vs, Vs
        sw      a3,-44(s0)  # Rs, Rs
        lw      a0,-20(s0)      #, intruder
        call    is_manoeuvring_filter_1   #
        mv      a5,a0       # tmp78,
        beq     a5,zero,.L172     #, _1,,
        li      a5,1                # _5,
        j       .L173   #
.L172:
        flw     fa0,-24(s0)       #, threshold_accuracy
        lw      a0,-20(s0)      #, intruder
        call    is_manoeuvring_filter_2   #
        mv      a5,a0       # tmp79,
        beq     a5,zero,.L174     #, _2,,
        li      a5,1                # _5,
        j       .L173   #
.L174:
        lw      a3,-44(s0)      #, Rs
        lw      a2,-40(s0)      #, Vs
        lw      a1,-36(s0)      #, As
        flw     fa0,-24(s0)       #, threshold_accuracy
        lw      a0,-20(s0)      #, intruder
        call    is_manoeuvring_filter_3_4             #
        mv      a5,a0       # tmp80,
        beq     a5,zero,.L175     #, _3,,
        li      a5,1                # _5,
        j       .L173   #
.L175:
        flw     fa1,-32(s0)       #, B_HMD
        flw     fa0,-28(s0)       #, R_HMD
        call    is_manoeuvring_filter_5   #
        mv      a5,a0       # tmp81,
        beq     a5,zero,.L176     #, _4,,
        li      a5,1                # _5,
        j       .L173   #
.L176:
        li      a5,0                # _5,
.L173:
        mv      a0,a5       #, <retval>
        lw      ra,44(sp)         #,
        lw      s0,40(sp)         #,
        addi    sp,sp,48        #,,
        jr      ra      #
hmdf_test:
        addi    sp,sp,-80       #,,
        sw      ra,76(sp)   #,
        sw      s0,72(sp)   #,
        addi    s0,sp,80        #,,
        sw      a0,-68(s0)  # own_aircraft, own_aircraft
        sw      a1,-72(s0)  # intruder, intruder
        sw      a2,-76(s0)  # idx_table, idx_table
        fsw     fa0,-80(s0)       # ttg_cpa, ttg_cpa
        addi    a4,s0,-52       #, tmp106,
        addi    a3,s0,-48       #, tmp107,
        addi    a5,s0,-44       #, tmp108,
        mv      a2,a5       #, tmp108
        lw      a1,-72(s0)      #, intruder
        lw      a0,-68(s0)      #, own_aircraft
        call    hmdf_parabolic_range_est                #
        fsw     fa0,-20(s0)       #, Re
        flw     fa0,-20(s0)       #, Re
        lw      a0,-72(s0)      #, intruder
        call    hdmf_accuracy_check       #
        fsw     fa0,-24(s0)       #, threshold_accuracy
        flw     fa5,-24(s0)       # tmp109, threshold_accuracy
        fmv.w.x fa4,zero  # tmp110,
        feq.s   a5,fa5,fa4    #, tmp111, tmp109, tmp110
        beq     a5,zero,.L178     #, tmp111,,
        li      a5,0                # _31,
        j       .L188   #
.L178:
        flw     fa4,-52(s0)       # Rs.17_1, Rs
        flw     fa5,-52(s0)       # Rs.18_2, Rs
        fmul.s  fa5,fa4,fa5 # _3, Rs.17_1, Rs.18_2
        fcvt.d.s        fa4,fa5 # _4, _3
        flw     fa3,-52(s0)       # Rs.19_5, Rs
        flw     fa5,-48(s0)       # Vs.20_6, Vs
        fmul.s  fa3,fa3,fa5 # _7, Rs.19_5, Vs.20_6
        flw     fa5,-52(s0)       # Rs.21_8, Rs
        fmul.s  fa3,fa3,fa5 # _9, _7, Rs.21_8
        flw     fa5,-48(s0)       # Vs.22_10, Vs
        fmul.s  fa5,fa3,fa5 # _11, _9, Vs.22_10
        fcvt.d.s        fa3,fa5 # _12, _11
        flw     fa2,-52(s0)       # Rs.24_13, Rs
        flw     fa5,-44(s0)       # As.25_14, As
        fmul.s  fa2,fa2,fa5 # _15, Rs.24_13, As.25_14
        flw     fa1,-48(s0)       # Vs.26_16, Vs
        flw     fa5,-48(s0)       # Vs.27_17, Vs
        fmul.s  fa5,fa1,fa5 # _18, Vs.26_16, Vs.27_17
        fadd.s  fa5,fa2,fa5 # _19, _15, _18
        fmv.w.x fa2,zero  # tmp112,
        feq.s   a5,fa5,fa2    #, tmp113, _19, tmp112
        bne     a5,zero,.L180     #, tmp113,,
        flw     fa2,-52(s0)       # Rs.28_20, Rs
        flw     fa5,-44(s0)       # As.29_21, As
        fmul.s  fa2,fa2,fa5 # _22, Rs.28_20, As.29_21
        flw     fa1,-48(s0)       # Vs.30_23, Vs
        flw     fa5,-48(s0)       # Vs.31_24, Vs
        fmul.s  fa5,fa1,fa5 # _25, Vs.30_23, Vs.31_24
        fadd.s  fa5,fa2,fa5 # _26, _22, _25
        fcvt.d.s        fa5,fa5 # iftmp.23_32, _26
        j       .L181   #
.L180:
        lui     a5,%hi(.LC18)     # tmp114,
        fld     fa5,%lo(.LC18)(a5)        # iftmp.23_32,
.L181:
        fdiv.d  fa5,fa3,fa5 # _27, _12, iftmp.23_32
        fsub.d  fa5,fa4,fa5 # _28, _4, _27
        fmv.d   fa0,fa5       #, _28
        call    sqrt            #
        fmv.d   fa5,fa0       # _29,
        fcvt.s.d        fa5,fa5 # tmp115, _29
        fsw     fa5,-28(s0)       # tmp115, R_HMD
        lw      a1,-72(s0)      #, intruder
        lw      a0,-68(s0)      #, own_aircraft
        call    hmdf_predict_bearing_distance         #
        fsw     fa0,-32(s0)       #, B_HMD
        flw     fa4,-28(s0)       # tmp116, R_HMD
        flw     fa5,-32(s0)       # tmp117, B_HMD
        fgt.s   a5,fa4,fa5    #, tmp118, tmp116, tmp117
        beq     a5,zero,.L191     #, tmp118,,
        flw     fa5,-32(s0)       # iftmp.32_33, B_HMD
        j       .L184   #
.L191:
        flw     fa5,-28(s0)       # iftmp.32_33, R_HMD
.L184:
        fsw     fa5,-36(s0)       # iftmp.32_33, smaller_HMD
        flw     fa0,-80(s0)       #, ttg_cpa
        lw      a0,-76(s0)      #, idx_table
        call    get_threshold         #
        fsw     fa0,-40(s0)       #, threshold
        flw     fa4,-36(s0)       # tmp119, smaller_HMD
        flw     fa5,-40(s0)       # tmp120, threshold
        fle.s   a5,fa4,fa5    #, tmp121, tmp119, tmp120
        beq     a5,zero,.L192     #, tmp121,,
        li      a5,0                # _31,
        j       .L188   #
.L192:
        addi    a3,s0,-52       #, tmp122,
        addi    a4,s0,-48       #, tmp123,
        addi    a5,s0,-44       #, tmp124,
        mv      a2,a4       #, tmp123
        mv      a1,a5       #, tmp124
        flw     fa2,-32(s0)       #, B_HMD
        flw     fa1,-28(s0)       #, R_HMD
        flw     fa0,-24(s0)       #, threshold_accuracy
        lw      a0,-72(s0)      #, intruder
        call    is_manoeuvring      #
        mv      a5,a0       # tmp125,
        beq     a5,zero,.L187     #, _30,,
        li      a5,0                # _31,
        j       .L188   #
.L187:
        li      a5,1                # _31,
.L188:
        mv      a0,a5       #, <retval>
        lw      ra,76(sp)         #,
        lw      s0,72(sp)         #,
        addi    sp,sp,80        #,,
        jr      ra      #
test_ra:
        addi    sp,sp,-32       #,,
        sw      ra,28(sp)   #,
        sw      s0,24(sp)   #,
        addi    s0,sp,32        #,,
        sw      a0,-20(s0)  # own_aircraft, own_aircraft
        sw      a1,-24(s0)  # intruder, intruder
        sw      a2,-28(s0)  # idx_table, idx_table
        sw      a3,-32(s0)  # ttg_cpa, ttg_cpa
        lw      a5,-24(s0)      # tmp89, intruder
        lbu     a5,24(a5) # _1, intruder_19(D)->flags
        andi    a5,a5,1 #, _3, _2
        beq     a5,zero,.L194     #, _3,,
        li      a5,1                # _16,
        j       .L195   #
.L194:
        lui     a5,%hi(DMOD)      # tmp90,
        addi    a4,a5,%lo(DMOD) # tmp91, tmp90,
        lw      a5,-28(s0)      # tmp93, idx_table
        addi    a5,a5,7 #, tmp92, tmp93
        slli    a5,a5,2 #, tmp94, tmp92
        add     a5,a4,a5  # tmp94, tmp95, tmp91
        flw     fa5,0(a5) # _4, DMOD[1][idx_table_20(D)]
        fmv.s   fa0,fa5       #, _4
        lw      a1,-24(s0)      #, intruder
        lw      a0,-20(s0)      #, own_aircraft
        call    time_to_go_CPA      #
        fmv.s   fa5,fa0       # _5,
        lw      a5,-32(s0)      # tmp96, ttg_cpa
        fsw     fa5,0(a5) # _5, *ttg_cpa_23(D)
        lw      a5,-32(s0)      # tmp97, ttg_cpa
        flw     fa4,0(a5) # _6, *ttg_cpa_23(D)
        lui     a5,%hi(TAU)       # tmp98,
        addi    a4,a5,%lo(TAU)  # tmp99, tmp98,
        lw      a5,-28(s0)      # tmp101, idx_table
        addi    a5,a5,7 #, tmp100, tmp101
        slli    a5,a5,2 #, tmp102, tmp100
        add     a5,a4,a5  # tmp102, tmp103, tmp99
        lw      a5,0(a5)            # _7, TAU[1][idx_table_20(D)]
        fcvt.s.w        fa5,a5  # _8, _7
        fge.s   a5,fa4,fa5    #, tmp104, _6, _8
        beq     a5,zero,.L203     #, tmp104,,
        li      a5,1                # _16,
        j       .L195   #
.L203:
        lw      a3,-28(s0)      #, idx_table
        li      a2,1                #,
        lw      a1,-24(s0)      #, intruder
        lw      a0,-20(s0)      #, own_aircraft
        call    altitude_test         #
        mv      a5,a0       # tmp105,
        beq     a5,zero,.L198     #, _9,,
        lw      a5,-32(s0)      # tmp106, ttg_cpa
        flw     fa5,0(a5) # _10, *ttg_cpa_23(D)
        fmv.s   fa0,fa5       #, _10
        lw      a2,-28(s0)      #, idx_table
        lw      a1,-24(s0)      #, intruder
        lw      a0,-20(s0)      #, own_aircraft
        call    hmdf_test             #
        mv      a5,a0       # tmp107,
        beq     a5,zero,.L199     #, _11,,
        li      a5,1                # _16,
        j       .L195   #
.L199:
        lw      a5,-20(s0)      # tmp108, own_aircraft
        lw      a5,12(a5)         # _12, own_aircraft_21(D)->vert_spd
        ble     a5,zero,.L200     #, _12,,
        lw      a5,-20(s0)      # tmp109, own_aircraft
        lw      a4,8(a5)            # _13, own_aircraft_21(D)->radioalt
        li      a5,1099       # tmp110,
        bgt     a4,a5,.L200       #, _13, tmp110,
        li      a5,3                # _16,
        j       .L195   #
.L200:
        lw      a5,-20(s0)      # tmp111, own_aircraft
        lw      a5,12(a5)         # _14, own_aircraft_21(D)->vert_spd
        bge     a5,zero,.L201     #, _14,,
        lw      a5,-20(s0)      # tmp112, own_aircraft
        lw      a4,8(a5)            # _15, own_aircraft_21(D)->radioalt
        li      a5,899          # tmp113,
        bgt     a4,a5,.L201       #, _15, tmp113,
        li      a5,3                # _16,
        j       .L195   #
.L201:
        li      a5,4                # _16,
        j       .L195   #
.L198:
        li      a5,1                # _16,
.L195:
        mv      a0,a5       #, <retval>
        lw      ra,28(sp)         #,
        lw      s0,24(sp)         #,
        addi    sp,sp,32        #,,
        jr      ra      #
.LC53:
        .string "TTG_CPA: %f\n"
test_ta:
        addi    sp,sp,-64       #,,
        sw      ra,60(sp)   #,
        sw      s0,56(sp)   #,
        addi    s0,sp,64        #,,
        sw      a0,-36(s0)  # own_aircraft, own_aircraft
        sw      a1,-40(s0)  # intruder, intruder
        sw      a2,-44(s0)  # idx_table, idx_table
        lw      a5,-40(s0)      # tmp86, intruder
        lbu     a5,24(a5) # _1, intruder_17(D)->flags
        andi    a5,a5,1 #, _3, _2
        seqz    a5,a5   # tmp88, _3
        andi    a5,a5,0xff      # _4, tmp87
        sb      a5,-17(s0)  # _4, alt_reporting
        lbu     a5,-17(s0)        # tmp90, alt_reporting
        seqz    a5,a5   # tmp91, tmp90
        andi    a5,a5,0xff      # _5, tmp89
        mv      a3,a5       # _6, _5
        lui     a5,%hi(DMOD)      # tmp92,
        addi    a4,a5,%lo(DMOD) # tmp93, tmp92,
        mv      a5,a3       # tmp94, _6
        slli    a5,a5,3 #, tmp95, tmp94
        sub     a5,a5,a3  # tmp94, tmp94, _6
        lw      a3,-44(s0)      # tmp97, idx_table
        add     a5,a5,a3  # tmp97, tmp96, tmp94
        slli    a5,a5,2 #, tmp98, tmp96
        add     a5,a4,a5  # tmp98, tmp99, tmp93
        flw     fa5,0(a5) # _7, DMOD[_6][idx_table_19(D)]
        fmv.s   fa0,fa5       #, _7
        lw      a1,-40(s0)      #, intruder
        lw      a0,-36(s0)      #, own_aircraft
        call    time_to_go_CPA      #
        fsw     fa0,-24(s0)       #, ttg_cpa
        flw     fa5,-24(s0)       # tmp100, ttg_cpa
        fcvt.d.s        fa5,fa5 # _8, tmp100
        fsd     fa5,-56(s0)       # _8, %sfp
        lw      a2,-56(s0)      #, %sfp
        lw      a3,-52(s0)      #, %sfp
        lui     a5,%hi(.LC53)     # tmp101,
        addi    a0,a5,%lo(.LC53)        #, tmp101,
        call    printf      #
        lui     a5,%hi(TAU)       # tmp102,
        addi    a4,a5,%lo(TAU)  # tmp103, tmp102,
        lw      a5,-44(s0)      # tmp104, idx_table
        slli    a5,a5,2 #, tmp105, tmp104
        add     a5,a4,a5  # tmp105, tmp106, tmp103
        lw      a5,0(a5)            # _9, TAU[0][idx_table_19(D)]
        fcvt.s.w        fa5,a5  # _10, _9
        flw     fa4,-24(s0)       # tmp107, ttg_cpa
        fge.s   a5,fa4,fa5    #, tmp108, tmp107, _10
        beq     a5,zero,.L211     #, tmp108,,
        li      a5,1                # _13,
        j       .L207   #
.L211:
        lbu     a5,-17(s0)        # tmp109, alt_reporting
        beq     a5,zero,.L208     #, tmp109,,
        lw      a3,-44(s0)      #, idx_table
        li      a2,0                #,
        lw      a1,-40(s0)      #, intruder
        lw      a0,-36(s0)      #, own_aircraft
        call    altitude_test         #
        mv      a5,a0       # tmp110,
        beq     a5,zero,.L209     #, _11,,
        li      a5,3                # _13,
        j       .L207   #
.L208:
        lw      a5,-36(s0)      # tmp111, own_aircraft
        lw      a4,4(a5)            # _12, own_aircraft_20(D)->baroalt
        li      a5,16384            # tmp115,
        addi    a5,a5,-885      #, tmp114, tmp115
        bgt     a4,a5,.L209       #, _12, tmp114,
        li      a5,3                # _13,
        j       .L207   #
.L209:
        li      a5,1                # _13,
.L207:
        mv      a0,a5       #, <retval>
        lw      ra,60(sp)         #,
        lw      s0,56(sp)         #,
        addi    sp,sp,64        #,,
        jr      ra      #
.LC55:
        .string "-- START: ra_sense_param"
.LC56:
        .string "Target V/S: %d\n"
.LC57:
        .string "INITIAL SEP: %f\n"
.LC58:
        .string "NO ACTION SEP: %f\n"
.LC64:
        .string "FINAL SEP: %f\n"
.LC65:
        .string "-- END:   ra_sense_param"
ra_sense_param:
        addi    sp,sp,-80       #,,
        sw      ra,76(sp)   #,
        sw      s0,72(sp)   #,
        addi    s0,sp,80        #,,
        sw      a0,-52(s0)  # own_aircraft, own_aircraft
        sw      a1,-56(s0)  # intruder, intruder
        fsw     fa0,-60(s0)       # ttg_cpa, ttg_cpa
        sw      a2,-64(s0)  # target_vs, target_vs
        fsw     fa1,-68(s0)       # target_G, target_G
        sw      a3,-72(s0)  # initial_delay, initial_delay
        lw      a5,-56(s0)      # tmp132, intruder
        lw      a4,4(a5)            # _1, intruder_64(D)->baroalt
        lw      a5,-52(s0)      # tmp133, own_aircraft
        lw      a5,4(a5)            # _2, own_aircraft_65(D)->baroalt
        sub     a5,a4,a5  # _3, _1, _2
        fcvt.s.w        fa5,a5  # tmp134, _3
        fsw     fa5,-24(s0)       # tmp134, initial_separation
        lw      a5,-56(s0)      # tmp135, intruder
        lw      a4,12(a5)         # _4, intruder_64(D)->vert_spd
        lw      a5,-52(s0)      # tmp136, own_aircraft
        lw      a5,12(a5)         # _5, own_aircraft_65(D)->vert_spd
        sub     a5,a4,a5  # _6, _4, _5
        fcvt.s.w        fa5,a5  # tmp137, _6
        fsw     fa5,-28(s0)       # tmp137, initial_vs
        flw     fa4,-28(s0)       # tmp139, initial_vs
        flw     fa5,-60(s0)       # tmp140, ttg_cpa
        fmul.s  fa5,fa4,fa5 # tmp138, tmp139, tmp140
        fsw     fa5,-32(s0)       # tmp138, no_action_sep
        flw     fa4,-28(s0)       # tmp142, initial_vs
        lui     a5,%hi(.LC54)     # tmp144,
        flw     fa5,%lo(.LC54)(a5)        # tmp143,
        fdiv.s  fa5,fa4,fa5 # tmp141, tmp142, tmp143
        fsw     fa5,-28(s0)       # tmp141, initial_vs
        lw      a5,-72(s0)      # tmp145, initial_delay
        fcvt.s.w        fa5,a5  # _7, tmp145
        flw     fa4,-60(s0)       # tmp147, ttg_cpa
        fsub.s  fa5,fa4,fa5 # tmp146, tmp147, _7
        fsw     fa5,-60(s0)       # tmp146, ttg_cpa
        lui     a5,%hi(.LC55)     # tmp148,
        addi    a0,a5,%lo(.LC55)        #, tmp148,
        call    puts            #
        lw      a1,-64(s0)      #, target_vs
        lui     a5,%hi(.LC56)     # tmp149,
        addi    a0,a5,%lo(.LC56)        #, tmp149,
        call    printf      #
        flw     fa5,-24(s0)       # tmp150, initial_separation
        fcvt.d.s        fa5,fa5 # _8, tmp150
        fsd     fa5,-80(s0)       # _8, %sfp
        lw      a2,-80(s0)      #, %sfp
        lw      a3,-76(s0)      #, %sfp
        lui     a5,%hi(.LC57)     # tmp151,
        addi    a0,a5,%lo(.LC57)        #, tmp151,
        call    printf      #
        flw     fa5,-32(s0)       # tmp152, no_action_sep
        fcvt.d.s        fa5,fa5 # _9, tmp152
        fsd     fa5,-80(s0)       # _9, %sfp
        lw      a2,-80(s0)      #, %sfp
        lw      a3,-76(s0)      #, %sfp
        lui     a5,%hi(.LC58)     # tmp153,
        addi    a0,a5,%lo(.LC58)        #, tmp153,
        call    printf      #
        flw     fa5,-60(s0)       # tmp154, ttg_cpa
        fcvt.d.s        fa5,fa5 # _10, tmp154
        fsd     fa5,-80(s0)       # _10, %sfp
        lw      a2,-80(s0)      #, %sfp
        lw      a3,-76(s0)      #, %sfp
        lui     a5,%hi(.LC53)     # tmp155,
        addi    a0,a5,%lo(.LC53)        #, tmp155,
        call    printf      #
        flw     fa5,-60(s0)       # tmp156, ttg_cpa
        fmv.w.x fa4,zero  # tmp157,
        fle.s   a5,fa5,fa4    #, tmp158, tmp156, tmp157
        beq     a5,zero,.L239     #, tmp158,,
        lui     a5,%hi(.LC59)     # tmp159,
        flw     fa5,%lo(.LC59)(a5)        # iftmp.37_61,
        j       .L215   #
.L239:
        lw      a5,-52(s0)      # tmp160, own_aircraft
        lw      a5,12(a5)         # _11, own_aircraft_65(D)->vert_spd
        lw      a4,-64(s0)      # tmp161, target_vs
        sub     a5,a4,a5  # _12, tmp161, _11
        fcvt.d.w        fa4,a5  # _13, _12
        flw     fa5,-68(s0)       # tmp162, target_G
        fcvt.d.s        fa3,fa5 # _14, tmp162
        lui     a5,%hi(.LC60)     # tmp164,
        fld     fa5,%lo(.LC60)(a5)        # tmp163,
        fmul.d  fa3,fa3,fa5 # _15, _14, tmp163
        lui     a5,%hi(.LC61)     # tmp166,
        fld     fa5,%lo(.LC61)(a5)        # tmp165,
        fmul.d  fa3,fa3,fa5 # _16, _15, tmp165
        lui     a5,%hi(.LC62)     # tmp168,
        fld     fa5,%lo(.LC62)(a5)        # tmp167,
        fmul.d  fa5,fa3,fa5 # _17, _16, tmp167
        fdiv.d  fa5,fa4,fa5 # _18, _13, _17
        fcvt.s.d        fa5,fa5 # tmp169, _18
        fsw     fa5,-36(s0)       # tmp169, time_to_reach_fpm
        flw     fa5,-36(s0)       # tmp170, time_to_reach_fpm
        fmv.w.x fa4,zero  # tmp171,
        fge.s   a5,fa5,fa4    #, tmp172, tmp170, tmp171
        beq     a5,zero,.L240     #, tmp172,,
        flw     fa5,-36(s0)       # iftmp.33_57, time_to_reach_fpm
        j       .L218   #
.L240:
        flw     fa5,-36(s0)       # tmp173, time_to_reach_fpm
        fneg.s  fa5,fa5     # iftmp.33_57, tmp173
.L218:
        fsw     fa5,-36(s0)       # iftmp.33_57, time_to_reach_fpm
        flw     fa4,-36(s0)       # tmp174, time_to_reach_fpm
        flw     fa5,-60(s0)       # tmp175, ttg_cpa
        flt.s   a5,fa4,fa5    #, tmp176, tmp174, tmp175
        beq     a5,zero,.L241     #, tmp176,,
        flw     fa5,-36(s0)       # iftmp.34_58, time_to_reach_fpm
        j       .L221   #
.L241:
        flw     fa5,-60(s0)       # iftmp.34_58, ttg_cpa
.L221:
        fsw     fa5,-40(s0)       # iftmp.34_58, sec_to_target_fpm
        lw      a5,-52(s0)      # tmp177, own_aircraft
        lw      a5,12(a5)         # _19, own_aircraft_65(D)->vert_spd
        lw      a4,-64(s0)      # tmp178, target_vs
        sub     a5,a4,a5  # _20, tmp178, _19
        srai    a4,a5,31        #, tmp179, _20
        xor     a5,a4,a5  # _20, _21, tmp179
        sub     a5,a5,a4  # _21, _21, tmp179
        lw      a4,-52(s0)      # tmp180, own_aircraft
        lw      a4,12(a4)         # _22, own_aircraft_65(D)->vert_spd
        lw      a3,-64(s0)      # tmp181, target_vs
        beq     a3,a4,.L222       #, tmp181, _22,
        lw      a4,-52(s0)      # tmp182, own_aircraft
        lw      a4,12(a4)         # _23, own_aircraft_65(D)->vert_spd
        lw      a3,-64(s0)      # tmp183, target_vs
        sub     a4,a3,a4  # iftmp.35_59, tmp183, _23
        j       .L223   #
.L222:
        li      a4,1                # iftmp.35_59,
.L223:
        div     a5,a5,a4  # iftmp.35_59, tmp184, _21
        sw      a5,-44(s0)  # tmp184, vs_diff_sign
        lw      a5,-44(s0)      # tmp185, vs_diff_sign
        fcvt.d.w        fa4,a5  # _24, tmp185
        flw     fa5,-68(s0)       # tmp186, target_G
        fcvt.d.s        fa3,fa5 # _25, tmp186
        lui     a5,%hi(.LC60)     # tmp188,
        fld     fa5,%lo(.LC60)(a5)        # tmp187,
        fmul.d  fa3,fa3,fa5 # _26, _25, tmp187
        lui     a5,%hi(.LC61)     # tmp190,
        fld     fa5,%lo(.LC61)(a5)        # tmp189,
        fmul.d  fa5,fa3,fa5 # _27, _26, tmp189
        fmul.d  fa4,fa4,fa5 # _28, _24, _27
        flw     fa5,-40(s0)       # tmp191, sec_to_target_fpm
        fcvt.d.s        fa5,fa5 # _29, tmp191
        fmul.d  fa4,fa4,fa5 # _30, _28, _29
        flw     fa5,-40(s0)       # tmp192, sec_to_target_fpm
        fcvt.d.s        fa5,fa5 # _31, tmp192
        fmul.d  fa4,fa4,fa5 # _32, _30, _31
        lui     a5,%hi(.LC63)     # tmp194,
        fld     fa5,%lo(.LC63)(a5)        # tmp193,
        fdiv.d  fa5,fa4,fa5 # _33, _32, tmp193
        fcvt.s.d        fa5,fa5 # tmp195, _33
        fsw     fa5,-48(s0)       # tmp195, dist_start_to_target_fpm
        flw     fa4,-60(s0)       # tmp196, ttg_cpa
        flw     fa5,-40(s0)       # tmp197, sec_to_target_fpm
        fsub.s  fa5,fa4,fa5 # _34, tmp196, tmp197
        fmv.w.x fa4,zero  # tmp198,
        fgt.s   a5,fa5,fa4    #, tmp199, _34, tmp198
        beq     a5,zero,.L242     #, tmp199,,
        lw      a4,-64(s0)      # tmp200, target_vs
        li      a5,60             # tmp201,
        div     a5,a4,a5  # tmp201, _35, tmp200
        fcvt.s.w        fa4,a5  # _36, _35
        flw     fa3,-60(s0)       # tmp202, ttg_cpa
        flw     fa5,-40(s0)       # tmp203, sec_to_target_fpm
        fsub.s  fa5,fa3,fa5 # _37, tmp202, tmp203
        fmul.s  fa5,fa4,fa5 # tmp204, _36, _37
        fsw     fa5,-20(s0)       # tmp204, dist_steady_vs
        j       .L226   #
.L242:
        sw      zero,-20(s0)        #, dist_steady_vs
.L226:
        flw     fa4,-24(s0)       # tmp205, initial_separation
        flw     fa5,-32(s0)       # tmp206, no_action_sep
        fadd.s  fa4,fa4,fa5 # _38, tmp205, tmp206
        flw     fa5,-48(s0)       # tmp207, dist_start_to_target_fpm
        fsub.s  fa4,fa4,fa5 # _39, _38, tmp207
        flw     fa5,-20(s0)       # tmp208, dist_steady_vs
        fsub.s  fa5,fa4,fa5 # _40, _39, tmp208
        fmv.w.x fa4,zero  # tmp209,
        fge.s   a5,fa5,fa4    #, tmp210, _40, tmp209
        beq     a5,zero,.L243     #, tmp210,,
        flw     fa4,-24(s0)       # tmp211, initial_separation
        flw     fa5,-32(s0)       # tmp212, no_action_sep
        fadd.s  fa4,fa4,fa5 # _41, tmp211, tmp212
        flw     fa5,-48(s0)       # tmp213, dist_start_to_target_fpm
        fsub.s  fa4,fa4,fa5 # _42, _41, tmp213
        flw     fa5,-20(s0)       # tmp214, dist_steady_vs
        fsub.s  fa5,fa4,fa5 # iftmp.36_60, _42, tmp214
        j       .L229   #
.L243:
        flw     fa4,-24(s0)       # tmp215, initial_separation
        flw     fa5,-32(s0)       # tmp216, no_action_sep
        fadd.s  fa4,fa4,fa5 # _43, tmp215, tmp216
        flw     fa5,-48(s0)       # tmp217, dist_start_to_target_fpm
        fsub.s  fa4,fa4,fa5 # _44, _43, tmp217
        flw     fa5,-20(s0)       # tmp218, dist_steady_vs
        fsub.s  fa5,fa4,fa5 # _45, _44, tmp218
        fneg.s  fa5,fa5     # iftmp.36_60, _45
.L229:
        fcvt.d.s        fa5,fa5 # _46, iftmp.36_60
        fsd     fa5,-80(s0)       # _46, %sfp
        lw      a2,-80(s0)      #, %sfp
        lw      a3,-76(s0)      #, %sfp
        lui     a5,%hi(.LC64)     # tmp219,
        addi    a0,a5,%lo(.LC64)        #, tmp219,
        call    printf      #
        lui     a5,%hi(.LC65)     # tmp220,
        addi    a0,a5,%lo(.LC65)        #, tmp220,
        call    puts            #
        flw     fa4,-24(s0)       # tmp221, initial_separation
        flw     fa5,-32(s0)       # tmp222, no_action_sep
        fadd.s  fa4,fa4,fa5 # _47, tmp221, tmp222
        flw     fa5,-48(s0)       # tmp223, dist_start_to_target_fpm
        fsub.s  fa4,fa4,fa5 # _48, _47, tmp223
        flw     fa5,-20(s0)       # tmp224, dist_steady_vs
        fsub.s  fa5,fa4,fa5 # _49, _48, tmp224
        fmv.w.x fa4,zero  # tmp225,
        fge.s   a5,fa5,fa4    #, tmp226, _49, tmp225
        beq     a5,zero,.L244     #, tmp226,,
        flw     fa4,-24(s0)       # tmp227, initial_separation
        flw     fa5,-32(s0)       # tmp228, no_action_sep
        fadd.s  fa4,fa4,fa5 # _50, tmp227, tmp228
        flw     fa5,-48(s0)       # tmp229, dist_start_to_target_fpm
        fsub.s  fa4,fa4,fa5 # _51, _50, tmp229
        flw     fa5,-20(s0)       # tmp230, dist_steady_vs
        fsub.s  fa5,fa4,fa5 # iftmp.37_61, _51, tmp230
        j       .L215   #
.L244:
        flw     fa4,-24(s0)       # tmp231, initial_separation
        flw     fa5,-32(s0)       # tmp232, no_action_sep
        fadd.s  fa4,fa4,fa5 # _52, tmp231, tmp232
        flw     fa5,-48(s0)       # tmp233, dist_start_to_target_fpm
        fsub.s  fa4,fa4,fa5 # _53, _52, tmp233
        flw     fa5,-20(s0)       # tmp234, dist_steady_vs
        fsub.s  fa5,fa4,fa5 # _54, _53, tmp234
        fneg.s  fa5,fa5     # iftmp.37_61, _54
.L215:
        fmv.s   fa0,fa5       #, <retval>
        lw      ra,76(sp)         #,
        lw      s0,72(sp)         #,
        addi    sp,sp,80        #,,
        jr      ra      #
.LC67:
        .string "LEVEL OFF decision: %f > %d\n"
.LC68:
        .string "CLB SEP=%f\t DES SEP=%f\n"
ra_sense:
        addi    sp,sp,-80       #,,
        sw      ra,76(sp)   #,
        sw      s0,72(sp)   #,
        addi    s0,sp,80        #,,
        sw      a0,-52(s0)  # own_aircraft, own_aircraft
        sw      a1,-56(s0)  # intruder, intruder
        fsw     fa0,-60(s0)       # ttg_cpa, ttg_cpa
        sw      a2,-64(s0)  # idx_table, idx_table
        lui     a5,%hi(.LC66)     # tmp119,
        flw     fa5,%lo(.LC66)(a5)        # tmp118,
        li      a3,5                #,
        fmv.s   fa1,fa5       #, tmp118
        li      a2,0                #,
        flw     fa0,-60(s0)       #, ttg_cpa
        lw      a1,-56(s0)      #, intruder
        lw      a0,-52(s0)      #, own_aircraft
        call    ra_sense_param      #
        fsw     fa0,-24(s0)       #, stay_zero
        lui     a5,%hi(ALIM)      # tmp120,
        addi    a4,a5,%lo(ALIM) # tmp121, tmp120,
        lw      a5,-64(s0)      # tmp122, idx_table
        slli    a5,a5,2 #, tmp123, tmp122
        add     a5,a4,a5  # tmp123, tmp124, tmp121
        lw      a5,0(a5)            # tmp125, ALIM[idx_table_58(D)]
        sw      a5,-28(s0)  # tmp125, curr_alim
        flw     fa5,-24(s0)       # tmp126, stay_zero
        fmv.w.x fa4,zero  # tmp127,
        flt.s   a5,fa5,fa4    #, tmp128, tmp126, tmp127
        beq     a5,zero,.L298     #, tmp128,,
        lw      a5,-56(s0)      # tmp129, intruder
        lw      a5,104(a5)      # _42, intruder_54(D)->_prev_decision
        j       .L248   #
.L298:
        lw      a5,-56(s0)      # tmp130, intruder
        lw      a4,104(a5)      # _1, intruder_54(D)->_prev_decision
        li      a5,1                # tmp131,
        bne     a4,a5,.L249       #, _1, tmp131,
        lw      a5,-56(s0)      # tmp132, intruder
        lw      a4,104(a5)      # _2, intruder_54(D)->_prev_decision
        li      a5,16             # tmp133,
        bne     a4,a5,.L249       #, _2, tmp133,
        lui     a5,%hi(ALIM)      # tmp134,
        addi    a4,a5,%lo(ALIM) # tmp135, tmp134,
        lw      a5,-64(s0)      # tmp136, idx_table
        slli    a5,a5,2 #, tmp137, tmp136
        add     a5,a4,a5  # tmp137, tmp138, tmp135
        lw      a5,0(a5)            # _3, ALIM[idx_table_58(D)]
        fcvt.s.w        fa5,a5  # _4, _3
        flw     fa4,-24(s0)       # tmp139, stay_zero
        fgt.s   a5,fa4,fa5    #, tmp140, tmp139, _4
        beq     a5,zero,.L249     #, tmp140,,
        lw      a5,-56(s0)      # tmp141, intruder
        li      a4,16             # tmp142,
        sw      a4,104(a5)  # tmp142, intruder_54(D)->_prev_decision
        flw     fa5,-24(s0)       # tmp143, stay_zero
        fcvt.d.s        fa5,fa5 # _5, tmp143
        lui     a5,%hi(ALIM)      # tmp144,
        addi    a4,a5,%lo(ALIM) # tmp145, tmp144,
        lw      a5,-64(s0)      # tmp146, idx_table
        slli    a5,a5,2 #, tmp147, tmp146
        add     a5,a4,a5  # tmp147, tmp148, tmp145
        lw      a5,0(a5)            # _6, ALIM[idx_table_58(D)]
        mv      a4,a5       #, _6
        fsd     fa5,-72(s0)       # _5, %sfp
        lw      a2,-72(s0)      #, %sfp
        lw      a3,-68(s0)      #, %sfp
        lui     a5,%hi(.LC67)     # tmp149,
        addi    a0,a5,%lo(.LC67)        #, tmp149,
        call    printf      #
        li      a5,16             # _42,
        j       .L248   #
.L249:
        lui     a5,%hi(.LC66)     # tmp151,
        flw     fa5,%lo(.LC66)(a5)        # tmp150,
        li      a3,5                #,
        fmv.s   fa1,fa5       #, tmp150
        li      a2,1500       #,
        flw     fa0,-60(s0)       #, ttg_cpa
        lw      a1,-56(s0)      #, intruder
        lw      a0,-52(s0)      #, own_aircraft
        call    ra_sense_param      #
        fsw     fa0,-32(s0)       #, clb_sep
        lui     a5,%hi(.LC66)     # tmp153,
        flw     fa5,%lo(.LC66)(a5)        # tmp152,
        li      a3,5                #,
        fmv.s   fa1,fa5       #, tmp152
        li      a2,-1500            #,
        flw     fa0,-60(s0)       #, ttg_cpa
        lw      a1,-56(s0)      #, intruder
        lw      a0,-52(s0)      #, own_aircraft
        call    ra_sense_param      #
        fsw     fa0,-36(s0)       #, des_sep
        flw     fa5,-32(s0)       # tmp154, clb_sep
        fcvt.d.s        fa4,fa5 # _7, tmp154
        flw     fa5,-36(s0)       # tmp155, des_sep
        fcvt.d.s        fa5,fa5 # _8, tmp155
        fsd     fa5,-72(s0)       # _8, %sfp
        lw      a4,-72(s0)      #, %sfp
        lw      a5,-68(s0)      #, %sfp
        fsd     fa4,-72(s0)       # _7, %sfp
        lw      a2,-72(s0)      #, %sfp
        lw      a3,-68(s0)      #, %sfp
        lui     a1,%hi(.LC68)     # tmp156,
        addi    a0,a1,%lo(.LC68)        #, tmp156,
        call    printf      #
        lw      a5,-52(s0)      # tmp157, own_aircraft
        lw      a4,4(a5)            # _9, own_aircraft_53(D)->baroalt
        lw      a5,-56(s0)      # tmp158, intruder
        lw      a5,4(a5)            # _10, intruder_54(D)->baroalt
        ble     a4,a5,.L251       #, _9, _10,
        lw      a5,-28(s0)      # tmp159, curr_alim
        fcvt.s.w        fa5,a5  # _11, tmp159
        flw     fa4,-32(s0)       # tmp160, clb_sep
        fge.s   a5,fa4,fa5    #, tmp161, tmp160, _11
        beq     a5,zero,.L299     #, tmp161,,
        li      a5,5                # tmp162,
        sw      a5,-20(s0)  # tmp162, current_decision
        j       .L254   #
.L299:
        flw     fa4,-32(s0)       # tmp163, clb_sep
        flw     fa5,-36(s0)       # tmp164, des_sep
        fgt.s   a5,fa4,fa5    #, tmp165, tmp163, tmp164
        beq     a5,zero,.L300     #, tmp165,,
        li      a5,5                # iftmp.38_43,
        j       .L257   #
.L300:
        li      a5,11             # iftmp.38_43,
.L257:
        sw      a5,-20(s0)  # iftmp.38_43, current_decision
        lw      a5,-52(s0)      # tmp166, own_aircraft
        lw      a4,4(a5)            # _12, own_aircraft_53(D)->baroalt
        lw      a5,-56(s0)      # tmp167, intruder
        lw      a5,4(a5)            # _13, intruder_54(D)->baroalt
        sub     a4,a4,a5  # _14, _12, _13
        li      a5,-99          # tmp168,
        blt     a4,a5,.L254       #, _14, tmp168,
        lw      a5,-52(s0)      # tmp169, own_aircraft
        lw      a4,4(a5)            # _15, own_aircraft_53(D)->baroalt
        lw      a5,-56(s0)      # tmp170, intruder
        lw      a5,4(a5)            # _16, intruder_54(D)->baroalt
        sub     a4,a4,a5  # _17, _15, _16
        li      a5,99             # tmp171,
        bgt     a4,a5,.L254       #, _17, tmp171,
        lw      a4,-20(s0)      # tmp172, current_decision
        li      a5,11             # tmp173,
        bne     a4,a5,.L254       #, tmp172, tmp173,
        li      a5,9                # tmp174,
        sw      a5,-20(s0)  # tmp174, current_decision
        j       .L254   #
.L251:
        lw      a5,-28(s0)      # tmp175, curr_alim
        fcvt.s.w        fa5,a5  # _18, tmp175
        flw     fa4,-36(s0)       # tmp176, des_sep
        fge.s   a5,fa4,fa5    #, tmp177, tmp176, _18
        beq     a5,zero,.L301     #, tmp177,,
        li      a5,9                # tmp178,
        sw      a5,-20(s0)  # tmp178, current_decision
        j       .L254   #
.L301:
        flw     fa4,-32(s0)       # tmp179, clb_sep
        flw     fa5,-36(s0)       # tmp180, des_sep
        fgt.s   a5,fa4,fa5    #, tmp181, tmp179, tmp180
        beq     a5,zero,.L302     #, tmp181,,
        li      a5,7                # iftmp.39_44,
        j       .L262   #
.L302:
        li      a5,9                # iftmp.39_44,
.L262:
        sw      a5,-20(s0)  # iftmp.39_44, current_decision
        lw      a5,-52(s0)      # tmp182, own_aircraft
        lw      a4,4(a5)            # _19, own_aircraft_53(D)->baroalt
        lw      a5,-56(s0)      # tmp183, intruder
        lw      a5,4(a5)            # _20, intruder_54(D)->baroalt
        sub     a4,a4,a5  # _21, _19, _20
        li      a5,-99          # tmp184,
        blt     a4,a5,.L254       #, _21, tmp184,
        lw      a5,-52(s0)      # tmp185, own_aircraft
        lw      a4,4(a5)            # _22, own_aircraft_53(D)->baroalt
        lw      a5,-56(s0)      # tmp186, intruder
        lw      a5,4(a5)            # _23, intruder_54(D)->baroalt
        sub     a4,a4,a5  # _24, _22, _23
        li      a5,99             # tmp187,
        bgt     a4,a5,.L254       #, _24, tmp187,
        lw      a4,-20(s0)      # tmp188, current_decision
        li      a5,7                # tmp189,
        bne     a4,a5,.L254       #, tmp188, tmp189,
        li      a5,5                # tmp190,
        sw      a5,-20(s0)  # tmp190, current_decision
.L254:
        lw      a5,-56(s0)      # tmp191, intruder
        lw      a4,104(a5)      # _25, intruder_54(D)->_prev_decision
        li      a5,5                # tmp192,
        beq     a4,a5,.L263       #, _25, tmp192,
        lw      a5,-56(s0)      # tmp193, intruder
        lw      a4,104(a5)      # _26, intruder_54(D)->_prev_decision
        li      a5,6                # tmp194,
        beq     a4,a5,.L263       #, _26, tmp194,
        lw      a5,-56(s0)      # tmp195, intruder
        lw      a4,104(a5)      # _27, intruder_54(D)->_prev_decision
        li      a5,7                # tmp196,
        bne     a4,a5,.L264       #, _27, tmp196,
.L263:
        li      a5,1                # iftmp.40_45,
        j       .L265   #
.L264:
        li      a5,0                # iftmp.40_45,
.L265:
        sb      a5,-37(s0)  # iftmp.40_45, was_climb
        lbu     a5,-37(s0)        # tmp197, was_climb
        beq     a5,zero,.L266     #, tmp197,,
        lw      a4,-20(s0)      # tmp198, current_decision
        li      a5,9                # tmp199,
        beq     a4,a5,.L267       #, tmp198, tmp199,
        lw      a4,-20(s0)      # tmp200, current_decision
        li      a5,11             # tmp201,
        bne     a4,a5,.L266       #, tmp200, tmp201,
.L267:
        lw      a5,-28(s0)      # tmp202, curr_alim
        fcvt.s.w        fa5,a5  # _28, tmp202
        flw     fa4,-32(s0)       # tmp203, clb_sep
        fge.s   a5,fa4,fa5    #, tmp204, tmp203, _28
        beq     a5,zero,.L266     #, tmp204,,
        lw      a5,-56(s0)      # tmp205, intruder
        lw      a4,104(a5)      # _29, intruder_54(D)->_prev_decision
        li      a5,7                # tmp206,
        bne     a4,a5,.L269       #, _29, tmp206,
        li      a5,7                # iftmp.41_46,
        j       .L270   #
.L269:
        li      a5,5                # iftmp.41_46,
.L270:
        sw      a5,-20(s0)  # iftmp.41_46, current_decision
.L266:
        lw      a5,-56(s0)      # tmp207, intruder
        lw      a4,104(a5)      # _30, intruder_54(D)->_prev_decision
        li      a5,9                # tmp208,
        beq     a4,a5,.L271       #, _30, tmp208,
        lw      a5,-56(s0)      # tmp209, intruder
        lw      a4,104(a5)      # _31, intruder_54(D)->_prev_decision
        li      a5,10             # tmp210,
        beq     a4,a5,.L271       #, _31, tmp210,
        lw      a5,-56(s0)      # tmp211, intruder
        lw      a4,104(a5)      # _32, intruder_54(D)->_prev_decision
        li      a5,11             # tmp212,
        bne     a4,a5,.L272       #, _32, tmp212,
.L271:
        li      a5,1                # iftmp.42_47,
        j       .L273   #
.L272:
        li      a5,0                # iftmp.42_47,
.L273:
        sb      a5,-38(s0)  # iftmp.42_47, was_descent
        lbu     a5,-38(s0)        # tmp213, was_descent
        beq     a5,zero,.L274     #, tmp213,,
        lw      a4,-20(s0)      # tmp214, current_decision
        li      a5,5                # tmp215,
        beq     a4,a5,.L275       #, tmp214, tmp215,
        lw      a4,-20(s0)      # tmp216, current_decision
        li      a5,7                # tmp217,
        bne     a4,a5,.L274       #, tmp216, tmp217,
.L275:
        lw      a5,-28(s0)      # tmp218, curr_alim
        fcvt.s.w        fa5,a5  # _33, tmp218
        flw     fa4,-36(s0)       # tmp219, des_sep
        fge.s   a5,fa4,fa5    #, tmp220, tmp219, _33
        beq     a5,zero,.L274     #, tmp220,,
        lw      a5,-56(s0)      # tmp221, intruder
        lw      a4,104(a5)      # _34, intruder_54(D)->_prev_decision
        li      a5,11             # tmp222,
        bne     a4,a5,.L277       #, _34, tmp222,
        li      a5,11             # iftmp.43_48,
        j       .L278   #
.L277:
        li      a5,9                # iftmp.43_48,
.L278:
        sw      a5,-20(s0)  # iftmp.43_48, current_decision
.L274:
        lw      a5,-28(s0)      # tmp223, curr_alim
        fcvt.s.w        fa5,a5  # _35, tmp223
        flw     fa4,-32(s0)       # tmp224, clb_sep
        flt.s   a5,fa4,fa5    #, tmp225, tmp224, _35
        beq     a5,zero,.L279     #, tmp225,,
        lw      a5,-28(s0)      # tmp226, curr_alim
        fcvt.s.w        fa5,a5  # _36, tmp226
        flw     fa4,-36(s0)       # tmp227, des_sep
        flt.s   a5,fa4,fa5    #, tmp228, tmp227, _36
        beq     a5,zero,.L279     #, tmp228,,
        lw      a5,-56(s0)      # tmp229, intruder
        lw      a4,104(a5)      # _37, intruder_54(D)->_prev_decision
        li      a5,1                # tmp230,
        beq     a4,a5,.L279       #, _37, tmp230,
        lui     a5,%hi(.LC66)     # tmp232,
        flw     fa5,%lo(.LC66)(a5)        # tmp231,
        li      a3,5                #,
        fmv.s   fa1,fa5       #, tmp231
        li      a5,4096       # tmp233,
        addi    a2,a5,-1596     #,, tmp233
        flw     fa0,-60(s0)       #, ttg_cpa
        lw      a1,-56(s0)      #, intruder
        lw      a0,-52(s0)      #, own_aircraft
        call    ra_sense_param      #
        fsw     fa0,-32(s0)       #, clb_sep
        lui     a5,%hi(.LC69)     # tmp235,
        flw     fa5,%lo(.LC69)(a5)        # tmp234,
        li      a3,2                #,
        fmv.s   fa1,fa5       #, tmp234
        li      a5,-4096            # tmp236,
        addi    a2,a5,1596      #,, tmp236
        flw     fa0,-60(s0)       #, ttg_cpa
        lw      a1,-56(s0)      #, intruder
        lw      a0,-52(s0)      #, own_aircraft
        call    ra_sense_param      #
        fsw     fa0,-36(s0)       #, des_sep
        flw     fa4,-32(s0)       # tmp237, clb_sep
        flw     fa5,-36(s0)       # tmp238, des_sep
        fgt.s   a5,fa4,fa5    #, tmp239, tmp237, tmp238
        beq     a5,zero,.L279     #, tmp239,,
        flw     fa4,-32(s0)       # tmp240, clb_sep
        flw     fa5,-36(s0)       # tmp241, des_sep
        fgt.s   a5,fa4,fa5    #, tmp242, tmp240, tmp241
        beq     a5,zero,.L303     #, tmp242,,
        li      a5,6                # iftmp.44_49,
        j       .L285   #
.L303:
        li      a5,10             # iftmp.44_49,
.L285:
        sw      a5,-20(s0)  # iftmp.44_49, current_decision
.L279:
        lw      a5,-20(s0)      # _42, current_decision
.L248:
        mv      a0,a5       #, <retval>
        lw      ra,76(sp)         #,
        lw      s0,72(sp)         #,
        addi    sp,sp,80        #,,
        jr      ra      #
.LC70:
        .string "Result TA: %s\n"
.LC71:
        .string "Result RA: %s\n"
.LC72:
        .string "Result RA sense: %s\n"
acas_single:
        addi    sp,sp,-64       #,,
        sw      ra,60(sp)   #,
        sw      s0,56(sp)   #,
        addi    s0,sp,64        #,,
        sw      a0,-52(s0)  # own_aircraft, own_aircraft
        sw      a1,-56(s0)  # intruder, intruder
        lw      a5,-56(s0)      # tmp93, intruder
        lw      a5,4(a5)            # _1, intruder_28(D)->baroalt
        mv      a0,a5       #, _1
        call    quantize_altitude             #
        mv      a4,a0       # _2,
        lw      a5,-56(s0)      # tmp94, intruder
        sw      a4,4(a5)    # _2, intruder_28(D)->baroalt
        lw      a1,-56(s0)      #, intruder
        lw      a0,-52(s0)      #, own_aircraft
        call    estimate_intruder_alt         #
        sw      a0,-24(s0)  #, int_agl
        lw      a5,-56(s0)      # tmp95, intruder
        lbu     a5,32(a5) # _3, intruder_28(D)->_state
        andi    a5,a5,1 #, _5, _4
        beq     a5,zero,.L305     #, _5,,
        lw      a4,-24(s0)      # tmp96, int_agl
        li      a5,400          # tmp97,
        bgt     a4,a5,.L306       #, tmp96, tmp97,
        lw      a5,-56(s0)      # tmp98, intruder
        lbu     a5,32(a5) # _6, intruder_28(D)->_state
        andi    a5,a5,-2        #, tmp99, _6
        andi    a4,a5,0xff      # _7, tmp99
        lw      a5,-56(s0)      # tmp100, intruder
        sb      a4,32(a5)   # _7, intruder_28(D)->_state
        li      a5,0                # _22,
        j       .L311   #
.L305:
        lw      a4,-24(s0)      # tmp101, int_agl
        li      a5,599          # tmp102,
        ble     a4,a5,.L308       #, tmp101, tmp102,
        lw      a5,-56(s0)      # tmp103, intruder
        lbu     a5,32(a5) # _8, intruder_28(D)->_state
        ori     a5,a5,1   #, tmp104, _8
        andi    a4,a5,0xff      # _9, tmp104
        lw      a5,-56(s0)      # tmp105, intruder
        sb      a4,32(a5)   # _9, intruder_28(D)->_state
        j       .L306   #
.L308:
        li      a5,0                # _22,
        j       .L311   #
.L306:
        lw      a5,-52(s0)      # tmp106, own_aircraft
        lw      a4,4(a5)            # _10, own_aircraft_31(D)->baroalt
        lw      a5,-52(s0)      # tmp107, own_aircraft
        lw      a5,8(a5)            # _11, own_aircraft_31(D)->radioalt
        mv      a1,a5       #, _11
        mv      a0,a4       #, _10
        call    table_index       #
        mv      a5,a0       # _12,
        sw      a5,-28(s0)  # _12, idx_table
        lw      a2,-28(s0)      #, idx_table
        lw      a1,-56(s0)      #, intruder
        lw      a0,-52(s0)      #, own_aircraft
        call    test_ta   #
        sw      a0,-20(s0)  #, result
        lw      a0,-20(s0)      #, result
        call    result_to_str         #
        mv      a5,a0       # _13,
        mv      a1,a5       #, _13
        lui     a5,%hi(.LC70)     # tmp108,
        addi    a0,a5,%lo(.LC70)        #, tmp108,
        call    printf      #
        lw      a4,-20(s0)      # tmp109, result
        li      a5,1                # tmp110,
        beq     a4,a5,.L309       #, tmp109, tmp110,
        lw      a5,-56(s0)      # tmp111, intruder
        lbu     a5,24(a5) # _14, intruder_28(D)->flags
        andi    a5,a5,1 #, _16, _15
        bne     a5,zero,.L309     #, _16,,
        addi    a5,s0,-36       #, tmp112,
        mv      a3,a5       #, tmp112
        lw      a2,-28(s0)      #, idx_table
        lw      a1,-56(s0)      #, intruder
        lw      a0,-52(s0)      #, own_aircraft
        call    test_ra   #
        sw      a0,-32(s0)  #, result_ra
        lw      a0,-32(s0)      #, result_ra
        call    result_to_str         #
        mv      a5,a0       # _17,
        mv      a1,a5       #, _17
        lui     a5,%hi(.LC71)     # tmp113,
        addi    a0,a5,%lo(.LC71)        #, tmp113,
        call    printf      #
        lw      a4,-32(s0)      # tmp114, result_ra
        li      a5,1                # tmp115,
        beq     a4,a5,.L309       #, tmp114, tmp115,
        lw      a5,-32(s0)      # tmp116, result_ra
        sw      a5,-20(s0)  # tmp116, result
.L309:
        lw      a4,-20(s0)      # tmp117, result
        li      a5,4                # tmp118,
        bne     a4,a5,.L310       #, tmp117, tmp118,
        flw     fa5,-36(s0)       # ttg_cpa.45_18, ttg_cpa
        lw      a2,-28(s0)      #, idx_table
        fmv.s   fa0,fa5       #, ttg_cpa.45_18
        lw      a1,-56(s0)      #, intruder
        lw      a0,-52(s0)      #, own_aircraft
        call    ra_sense                #
        sw      a0,-20(s0)  #, result
        lw      a0,-20(s0)      #, result
        call    result_to_str         #
        mv      a5,a0       # _19,
        mv      a1,a5       #, _19
        lui     a5,%hi(.LC72)     # tmp119,
        addi    a0,a5,%lo(.LC72)        #, tmp119,
        call    printf      #
.L310:
        lw      a5,-20(s0)      # _22, result
.L311:
        mv      a0,a5       #, <retval>
        lw      ra,60(sp)         #,
        lw      s0,56(sp)         #,
        addi    sp,sp,64        #,,
        jr      ra      #
get_final_ra:
        addi    sp,sp,-48       #,,
        sw      s0,44(sp)   #,
        addi    s0,sp,48        #,,
        sw      a0,-36(s0)  # own_aircraft, own_aircraft
        sw      a1,-40(s0)  # current_dec, current_dec
        sw      a2,-44(s0)  # voting_ra, voting_ra
        mv      a5,a3       # tmp82, is_clb_xing
        sb      a5,-45(s0)  # tmp83, is_clb_xing
        mv      a5,a4       # tmp85, tmp84
        sb      a5,-46(s0)  # tmp85, is_des_xing
        lw      a5,-36(s0)      # tmp86, own_aircraft
        lw      a5,104(a5)      # tmp87, own_aircraft_19(D)->_prev_decision
        sw      a5,-24(s0)  # tmp87, prev_dec
        lw      a4,-40(s0)      # tmp88, current_dec
        li      a5,3                # tmp89,
        bne     a4,a5,.L313       #, tmp88, tmp89,
        li      a5,3                # _15,
        j       .L314   #
.L313:
        lw      a4,-44(s0)      # tmp90, voting_ra
        li      a5,99             # tmp91,
        ble     a4,a5,.L315       #, tmp90, tmp91,
        li      a5,6                # tmp92,
        sw      a5,-20(s0)  # tmp92, overall_res
        j       .L316   #
.L315:
        lw      a5,-44(s0)      # tmp93, voting_ra
        ble     a5,zero,.L317     #, tmp93,,
        lbu     a5,-45(s0)        # tmp94, is_clb_xing
        beq     a5,zero,.L318     #, tmp94,,
        li      a5,7                # iftmp.46_16,
        j       .L319   #
.L318:
        li      a5,5                # iftmp.46_16,
.L319:
        sw      a5,-20(s0)  # iftmp.46_16, overall_res
        j       .L316   #
.L317:
        lw      a4,-44(s0)      # tmp95, voting_ra
        li      a5,-99          # tmp96,
        bge     a4,a5,.L320       #, tmp95, tmp96,
        li      a5,10             # tmp97,
        sw      a5,-20(s0)  # tmp97, overall_res
        j       .L316   #
.L320:
        lw      a5,-44(s0)      # tmp98, voting_ra
        bge     a5,zero,.L321     #, tmp98,,
        lbu     a5,-46(s0)        # tmp99, is_des_xing
        beq     a5,zero,.L322     #, tmp99,,
        li      a5,11             # iftmp.47_17,
        j       .L323   #
.L322:
        li      a5,9                # iftmp.47_17,
.L323:
        sw      a5,-20(s0)  # iftmp.47_17, overall_res
        j       .L316   #
.L321:
        lw      a4,-40(s0)      # tmp100, current_dec
        li      a5,16             # tmp101,
        bne     a4,a5,.L324       #, tmp100, tmp101,
        li      a5,16             # tmp102,
        sw      a5,-20(s0)  # tmp102, overall_res
        j       .L316   #
.L324:
        lw      a4,-40(s0)      # tmp103, current_dec
        li      a5,1                # tmp104,
        beq     a4,a5,.L325       #, tmp103, tmp104,
        li      a5,5                # tmp105,
        sw      a5,-20(s0)  # tmp105, overall_res
        j       .L316   #
.L325:
        li      a5,1                # tmp106,
        sw      a5,-20(s0)  # tmp106, overall_res
.L316:
        lw      a4,-24(s0)      # tmp107, prev_dec
        li      a5,6                # tmp108,
        beq     a4,a5,.L326       #, tmp107, tmp108,
        lw      a4,-24(s0)      # tmp109, prev_dec
        li      a5,5                # tmp110,
        beq     a4,a5,.L326       #, tmp109, tmp110,
        lw      a4,-24(s0)      # tmp111, prev_dec
        li      a5,7                # tmp112,
        bne     a4,a5,.L327       #, tmp111, tmp112,
.L326:
        lw      a4,-20(s0)      # tmp113, overall_res
        li      a5,11             # tmp114,
        beq     a4,a5,.L328       #, tmp113, tmp114,
        lw      a4,-20(s0)      # tmp115, overall_res
        li      a5,9                # tmp116,
        beq     a4,a5,.L328       #, tmp115, tmp116,
        lw      a4,-20(s0)      # tmp117, overall_res
        li      a5,10             # tmp118,
        bne     a4,a5,.L327       #, tmp117, tmp118,
.L328:
        li      a5,12             # tmp119,
        sw      a5,-20(s0)  # tmp119, overall_res
.L327:
        lw      a4,-24(s0)      # tmp120, prev_dec
        li      a5,10             # tmp121,
        beq     a4,a5,.L329       #, tmp120, tmp121,
        lw      a4,-24(s0)      # tmp122, prev_dec
        li      a5,9                # tmp123,
        beq     a4,a5,.L329       #, tmp122, tmp123,
        lw      a4,-24(s0)      # tmp124, prev_dec
        li      a5,11             # tmp125,
        bne     a4,a5,.L330       #, tmp124, tmp125,
.L329:
        lw      a4,-20(s0)      # tmp126, overall_res
        li      a5,7                # tmp127,
        beq     a4,a5,.L331       #, tmp126, tmp127,
        lw      a4,-20(s0)      # tmp128, overall_res
        li      a5,5                # tmp129,
        beq     a4,a5,.L331       #, tmp128, tmp129,
        lw      a4,-20(s0)      # tmp130, overall_res
        li      a5,6                # tmp131,
        bne     a4,a5,.L330       #, tmp130, tmp131,
.L331:
        li      a5,8                # tmp132,
        sw      a5,-20(s0)  # tmp132, overall_res
.L330:
        lw      a4,-20(s0)      # tmp133, overall_res
        li      a5,8                # tmp134,
        beq     a4,a5,.L332       #, tmp133, tmp134,
        lw      a4,-20(s0)      # tmp135, overall_res
        li      a5,5                # tmp136,
        beq     a4,a5,.L332       #, tmp135, tmp136,
        lw      a4,-20(s0)      # tmp137, overall_res
        li      a5,7                # tmp138,
        bne     a4,a5,.L333       #, tmp137, tmp138,
.L332:
        lw      a5,-36(s0)      # tmp139, own_aircraft
        lw      a4,12(a5)         # _1, own_aircraft_19(D)->vert_spd
        li      a5,1500       # tmp140,
        ble     a4,a5,.L333       #, _1, tmp140,
        li      a5,15             # tmp141,
        sw      a5,-20(s0)  # tmp141, overall_res
.L333:
        lw      a4,-20(s0)      # tmp142, overall_res
        li      a5,6                # tmp143,
        bne     a4,a5,.L334       #, tmp142, tmp143,
        lw      a5,-36(s0)      # tmp144, own_aircraft
        lw      a4,12(a5)         # _2, own_aircraft_19(D)->vert_spd
        li      a5,4096       # tmp148,
        addi    a5,a5,-1596     #, tmp147, tmp148
        ble     a4,a5,.L334       #, _2, tmp147,
        li      a5,14             # tmp149,
        sw      a5,-20(s0)  # tmp149, overall_res
.L334:
        lw      a4,-20(s0)      # tmp150, overall_res
        li      a5,12             # tmp151,
        beq     a4,a5,.L335       #, tmp150, tmp151,
        lw      a4,-20(s0)      # tmp152, overall_res
        li      a5,9                # tmp153,
        beq     a4,a5,.L335       #, tmp152, tmp153,
        lw      a4,-20(s0)      # tmp154, overall_res
        li      a5,11             # tmp155,
        bne     a4,a5,.L336       #, tmp154, tmp155,
.L335:
        lw      a5,-36(s0)      # tmp156, own_aircraft
        lw      a4,12(a5)         # _3, own_aircraft_19(D)->vert_spd
        li      a5,1500       # tmp157,
        ble     a4,a5,.L336       #, _3, tmp157,
        li      a5,15             # tmp158,
        sw      a5,-20(s0)  # tmp158, overall_res
.L336:
        lw      a4,-20(s0)      # tmp159, overall_res
        li      a5,10             # tmp160,
        bne     a4,a5,.L337       #, tmp159, tmp160,
        lw      a5,-36(s0)      # tmp161, own_aircraft
        lw      a4,12(a5)         # _4, own_aircraft_19(D)->vert_spd
        li      a5,4096       # tmp165,
        addi    a5,a5,-1596     #, tmp164, tmp165
        ble     a4,a5,.L337       #, _4, tmp164,
        li      a5,14             # tmp166,
        sw      a5,-20(s0)  # tmp166, overall_res
.L337:
        lw      a4,-20(s0)      # tmp167, overall_res
        li      a5,16             # tmp168,
        bne     a4,a5,.L338       #, tmp167, tmp168,
        lw      a5,-36(s0)      # tmp169, own_aircraft
        lw      a4,12(a5)         # _5, own_aircraft_19(D)->vert_spd
        li      a5,299          # tmp170,
        bgt     a4,a5,.L338       #, _5, tmp170,
        lw      a5,-36(s0)      # tmp171, own_aircraft
        lw      a4,12(a5)         # _6, own_aircraft_19(D)->vert_spd
        li      a5,-299       # tmp172,
        blt     a4,a5,.L338       #, _6, tmp172,
        li      a5,13             # tmp173,
        sw      a5,-20(s0)  # tmp173, overall_res
.L338:
        lw      a5,-20(s0)      # _15, overall_res
.L314:
        mv      a0,a5       #, <retval>
        lw      s0,44(sp)         #,
        addi    sp,sp,48        #,,
        jr      ra      #
check_inhibit:
        addi    sp,sp,-32       #,,
        sw      s0,28(sp)   #,
        addi    s0,sp,32        #,,
        sw      a0,-20(s0)  # own_aircraft, own_aircraft
        lw      a5,-20(s0)      # tmp83, own_aircraft
        lbu     a5,32(a5) # _1, own_aircraft_14(D)->_state
        andi    a5,a5,1 #, _3, _2
        beq     a5,zero,.L340     #, _3,,
        lw      a5,-20(s0)      # tmp84, own_aircraft
        lw      a4,8(a5)            # _4, own_aircraft_14(D)->radioalt
        li      a5,400          # tmp85,
        bgt     a4,a5,.L341       #, _4, tmp85,
        lw      a5,-20(s0)      # tmp86, own_aircraft
        lbu     a5,32(a5) # _5, own_aircraft_14(D)->_state
        andi    a5,a5,-2        #, tmp87, _5
        andi    a4,a5,0xff      # _6, tmp87
        lw      a5,-20(s0)      # tmp88, own_aircraft
        sb      a4,32(a5)   # _6, own_aircraft_14(D)->_state
        li      a5,1                # _10,
        j       .L342   #
.L340:
        lw      a5,-20(s0)      # tmp89, own_aircraft
        lw      a4,8(a5)            # _7, own_aircraft_14(D)->radioalt
        li      a5,599          # tmp90,
        ble     a4,a5,.L343       #, _7, tmp90,
        lw      a5,-20(s0)      # tmp91, own_aircraft
        lbu     a5,32(a5) # _8, own_aircraft_14(D)->_state
        ori     a5,a5,1   #, tmp92, _8
        andi    a4,a5,0xff      # _9, tmp92
        lw      a5,-20(s0)      # tmp93, own_aircraft
        sb      a4,32(a5)   # _9, own_aircraft_14(D)->_state
        j       .L341   #
.L343:
        li      a5,1                # _10,
        j       .L342   #
.L341:
        li      a5,0                # _10,
.L342:
        mv      a0,a5       #, <retval>
        lw      s0,28(sp)         #,
        addi    sp,sp,32        #,,
        jr      ra      #
.LC73:
        .string "\n-----------------------------\nRUNNING ACAS"
.LC74:
        .string "Intruder %d result: %d (%s)\n\n"
.LC75:
        .string "0"
.LC76:
        .string "/app/example.c"
.LC77:
        .string "Final decision: %d (%s)\n\n"
acas:
        addi    sp,sp,-64       #,,
        sw      ra,60(sp)   #,
        sw      s0,56(sp)   #,
        addi    s0,sp,64        #,,
        sw      a0,-52(s0)  # own_aircraft, own_aircraft
        sw      a1,-56(s0)  # intruders, intruders
        sw      a2,-60(s0)  # nr_intruders, nr_intruders
        lui     a5,%hi(.LC73)     # tmp80,
        addi    a0,a5,%lo(.LC73)        #, tmp80,
        call    puts            #
        lw      a0,-52(s0)      #, own_aircraft
        call    check_inhibit         #
        mv      a5,a0       # tmp81,
        beq     a5,zero,.L345     #, _1,,
        li      a5,0                # _21,
        j       .L346   #
.L345:
        li      a5,1                # tmp82,
        sw      a5,-32(s0)  # tmp82, overall_res
        sb      zero,-18(s0)        #, is_des_xing
        lbu     a5,-18(s0)        # tmp83, is_des_xing
        sb      a5,-17(s0)  # tmp83, is_clb_xing
        sw      zero,-28(s0)        #, voting_ra
        sw      zero,-24(s0)        #, i
        j       .L347   #
.L362:
        lw      a4,-24(s0)      # i.48_2, i
        li      a5,108          # tmp84,
        mul     a5,a4,a5  # _3, i.48_2, tmp84
        lw      a4,-56(s0)      # tmp86, intruders
        add     a5,a4,a5  # _3, tmp85, tmp86
        sw      a5,-36(s0)  # tmp85, curr_intruder
        lw      a1,-36(s0)      #, curr_intruder
        lw      a0,-52(s0)      #, own_aircraft
        call    acas_single       #
        sw      a0,-40(s0)  #, res
        lui     a5,%hi(result_str)        # tmp87,
        addi    a4,a5,%lo(result_str)   # tmp88, tmp87,
        lw      a5,-40(s0)      # tmp89, res
        slli    a5,a5,2 #, tmp90, tmp89
        add     a5,a4,a5  # tmp90, tmp91, tmp88
        lw      a5,0(a5)            # _4, result_str[res_42]
        mv      a3,a5       #, _4
        lw      a2,-40(s0)      #, res
        lw      a1,-24(s0)      #, i
        lui     a5,%hi(.LC74)     # tmp92,
        addi    a0,a5,%lo(.LC74)        #, tmp92,
        call    printf      #
        lw      a4,-40(s0)      # tmp93, res
        li      a5,16             # tmp94,
        bgtu    a4,a5,.L348     #, tmp93, tmp94,
        lw      a5,-40(s0)      # tmp96, res
        slli    a4,a5,2 #, tmp95, tmp96
        lui     a5,%hi(.L350)     # tmp99,
        addi    a5,a5,%lo(.L350)        # tmp98, tmp99,
        add     a5,a4,a5  # tmp98, tmp97, tmp95
        lw      a5,0(a5)            # tmp100,
        jr      a5      # tmp100
.L350:
        .word   .L363
        .word   .L358
        .word   .L348
        .word   .L357
        .word   .L348
        .word   .L356
        .word   .L355
        .word   .L354
        .word   .L348
        .word   .L353
        .word   .L352
        .word   .L351
        .word   .L348
        .word   .L348
        .word   .L348
        .word   .L348
        .word   .L349
.L358:
        lw      a5,-36(s0)      # tmp101, curr_intruder
        lw      a4,104(a5)      # _5, curr_intruder_40->_prev_decision
        li      a5,1                # tmp102,
        beq     a4,a5,.L364       #, _5, tmp102,
        li      a5,2                # tmp103,
        sw      a5,-32(s0)  # tmp103, overall_res
        j       .L364   #
.L354:
        li      a5,1                # tmp104,
        sb      a5,-17(s0)  # tmp104, is_clb_xing
        li      a5,5                # tmp105,
        sw      a5,-32(s0)  # tmp105, overall_res
.L356:
        lw      a5,-28(s0)      # tmp107, voting_ra
        addi    a5,a5,1 #, tmp106, tmp107
        sw      a5,-28(s0)  # tmp106, voting_ra
        j       .L361   #
.L355:
        lw      a5,-28(s0)      # tmp109, voting_ra
        addi    a5,a5,100       #, tmp108, tmp109
        sw      a5,-28(s0)  # tmp108, voting_ra
        li      a5,5                # tmp110,
        sw      a5,-32(s0)  # tmp110, overall_res
        j       .L361   #
.L351:
        li      a5,1                # tmp111,
        sb      a5,-18(s0)  # tmp111, is_des_xing
        li      a5,9                # tmp112,
        sw      a5,-32(s0)  # tmp112, overall_res
.L353:
        lw      a5,-28(s0)      # tmp114, voting_ra
        addi    a5,a5,-1        #, tmp113, tmp114
        sw      a5,-28(s0)  # tmp113, voting_ra
        j       .L361   #
.L352:
        li      a5,9                # tmp115,
        sw      a5,-32(s0)  # tmp115, overall_res
        lw      a5,-28(s0)      # tmp117, voting_ra
        addi    a5,a5,-100      #, tmp116, tmp117
        sw      a5,-28(s0)  # tmp116, voting_ra
        j       .L361   #
.L349:
        li      a5,16             # tmp118,
        sw      a5,-32(s0)  # tmp118, overall_res
        j       .L361   #
.L357:
        li      a5,3                # tmp119,
        sw      a5,-32(s0)  # tmp119, overall_res
        j       .L361   #
.L348:
        lui     a5,%hi(.LC75)     # tmp120,
        addi    a3,a5,%lo(.LC75)        #, tmp120,
        lui     a5,%hi(__func__.0)        # tmp121,
        addi    a2,a5,%lo(__func__.0)   #, tmp121,
        li      a1,900          #,
        lui     a5,%hi(.LC76)     # tmp122,
        addi    a0,a5,%lo(.LC76)        #, tmp122,
        call    __assert_func         #
.L363:
        nop     
        j       .L361   #
.L364:
        nop     
.L361:
        lw      a5,-36(s0)      # tmp123, curr_intruder
        lw      a4,-32(s0)      # tmp124, overall_res
        sw      a4,104(a5)  # tmp124, curr_intruder_40->_prev_decision
        lw      a5,-24(s0)      # tmp126, i
        addi    a5,a5,1 #, tmp125, tmp126
        sw      a5,-24(s0)  # tmp125, i
.L347:
        lw      a4,-24(s0)      # tmp127, i
        lw      a5,-60(s0)      # tmp128, nr_intruders
        blt     a4,a5,.L362       #, tmp127, tmp128,
        lbu     a4,-18(s0)        # tmp129, is_des_xing
        lbu     a5,-17(s0)        # tmp130, is_clb_xing
        mv      a3,a5       #, tmp130
        lw      a2,-28(s0)      #, voting_ra
        lw      a1,-32(s0)      #, overall_res
        lw      a0,-52(s0)      #, own_aircraft
        call    get_final_ra            #
        sw      a0,-32(s0)  #, overall_res
        lui     a5,%hi(result_str)        # tmp131,
        addi    a4,a5,%lo(result_str)   # tmp132, tmp131,
        lw      a5,-32(s0)      # tmp133, overall_res
        slli    a5,a5,2 #, tmp134, tmp133
        add     a5,a4,a5  # tmp134, tmp135, tmp132
        lw      a5,0(a5)            # _6, result_str[overall_res_35]
        mv      a2,a5       #, _6
        lw      a1,-32(s0)      #, overall_res
        lui     a5,%hi(.LC77)     # tmp136,
        addi    a0,a5,%lo(.LC77)        #, tmp136,
        call    printf      #
        lw      a5,-52(s0)      # tmp137, own_aircraft
        lw      a4,-32(s0)      # tmp138, overall_res
        sw      a4,104(a5)  # tmp138, own_aircraft_26(D)->_prev_decision
        lw      a5,-32(s0)      # _21, overall_res
.L346:
        mv      a0,a5       #, <retval>
        lw      ra,60(sp)         #,
        lw      s0,56(sp)         #,
        addi    sp,sp,64        #,,
        jr      ra      #
initialize_acf:
        addi    sp,sp,-32       #,,
        sw      s0,28(sp)   #,
        addi    s0,sp,32        #,,
        sw      a0,-20(s0)  # acf, acf
        lw      a5,-20(s0)      # tmp74, acf
        sw      zero,0(a5)  #, acf_4(D)->identifier
        lw      a5,-20(s0)      # tmp75, acf
        sw      zero,4(a5)  #, acf_4(D)->baroalt
        lw      a5,-20(s0)      # tmp76, acf
        li      a4,4096       # tmp78,
        addi    a4,a4,-1096     #, tmp77, tmp78
        sw      a4,8(a5)    # tmp77, acf_4(D)->radioalt
        lw      a5,-20(s0)      # tmp79, acf
        sw      zero,12(a5) #, acf_4(D)->vert_spd
        lw      a5,-20(s0)      # tmp80, acf
        sw      zero,16(a5) #, acf_4(D)->slant_range
        lw      a5,-20(s0)      # tmp81, acf
        sw      zero,20(a5) #, acf_4(D)->bearing
        lw      a5,-20(s0)      # tmp82, acf
        sb      zero,24(a5) #, acf_4(D)->flags
        lw      a5,-20(s0)      # tmp83, acf
        sw      zero,28(a5) #, acf_4(D)->delta_update_time
        lw      a5,-20(s0)      # tmp84, acf
        sb      zero,32(a5) #, acf_4(D)->_state
        lw      a5,-20(s0)      # tmp85, acf
        lui     a4,%hi(.LC59)     # tmp86,
        flw     fa5,%lo(.LC59)(a4)        # tmp87,
        fsw     fa5,36(a5)        # tmp87, acf_4(D)->_closure_prev
        lw      a5,-20(s0)      # tmp88, acf
        sw      zero,40(a5) #, acf_4(D)->_heading_prev
        lw      a5,-20(s0)      # tmp89, acf
        sw      zero,44(a5) #, acf_4(D)->_hmdf_Rp
        lw      a5,-20(s0)      # tmp90, acf
        sw      zero,48(a5) #, acf_4(D)->_hmdf_Vp
        lw      a5,-20(s0)      # tmp91, acf
        sw      zero,52(a5) #, acf_4(D)->_hmdf_Ap
        lw      a5,-20(s0)      # tmp92, acf
        sw      zero,56(a5) #, acf_4(D)->_hmdf_diff_ApAs
        lw      a5,-20(s0)      # tmp93, acf
        sw      zero,60(a5) #, acf_4(D)->_hmdf_E
        lw      a5,-20(s0)      # tmp94, acf
        sw      zero,64(a5) #, acf_4(D)->_hmdf_RPX
        lw      a5,-20(s0)      # tmp95, acf
        sw      zero,68(a5) #, acf_4(D)->_hmdf_RPY
        lw      a5,-20(s0)      # tmp96, acf
        sw      zero,72(a5) #, acf_4(D)->_hmdf_VPX
        lw      a5,-20(s0)      # tmp97, acf
        sw      zero,76(a5) #, acf_4(D)->_hmdf_VPY
        lw      a5,-20(s0)      # tmp98, acf
        sw      zero,84(a5) #, acf_4(D)->_hmdf_cov[0][1]
        lw      a5,-20(s0)      # tmp99, acf
        flw     fa5,84(a5)        # _1, acf_4(D)->_hmdf_cov[0][1]
        lw      a5,-20(s0)      # tmp100, acf
        fsw     fa5,80(a5)        # _1, acf_4(D)->_hmdf_cov[0][0]
        lw      a5,-20(s0)      # tmp101, acf
        sw      zero,92(a5) #, acf_4(D)->_hmdf_cov[1][1]
        lw      a5,-20(s0)      # tmp102, acf
        flw     fa5,92(a5)        # _2, acf_4(D)->_hmdf_cov[1][1]
        lw      a5,-20(s0)      # tmp103, acf
        fsw     fa5,88(a5)        # _2, acf_4(D)->_hmdf_cov[1][0]
        lw      a5,-20(s0)      # tmp104, acf
        sw      zero,96(a5) #, acf_4(D)->_hmdf_dAs
        lw      a5,-20(s0)      # tmp105, acf
        sb      zero,100(a5)        #, acf_4(D)->_hmdf_hits
        lw      a5,-20(s0)      # tmp106, acf
        li      a4,1                # tmp107,
        sw      a4,104(a5)  # tmp107, acf_4(D)->_prev_decision
        nop     
        lw      s0,28(sp)         #,
        addi    sp,sp,32        #,,
        jr      ra      #
__func__.0:
        .string "acas"
.LC17:
        .word   1315859240
.LC18:
        .word   1116375951
        .word   943784861
.LC19:
        .word   1065353216
.LC20:
        .word   1073741824
.LC21:
        .word   1008981770
.LC22:
        .word   1065185444
.LC23:
        .word   1108082688
.LC24:
        .word   1069547520
.LC25:
        .word   1007585906
.LC26:
        .word   1413754136
        .word   1074340347
.LC27:
        .word   0
        .word   1080459264
.LC28:
        .word   1082130432
.LC29:
        .word   1103626240
.LC30:
        .word   1093664768
.LC31:
        .word   1159479296
.LC32:
        .word   1096810496
.LC33:
        .word   1163575296
.LC34:
        .word   1098907648
.LC35:
        .word   1092616192
.LC36:
        .word   1168891904
.LC37:
        .word   1166843904
.LC38:
        .word   1100480512
.LC39:
        .word   1099431936
.LC40:
        .word   1169915904
.LC41:
        .word   1090519040
.LC42:
        .word   1167867904
.LC43:
        .word   1102053376
.LC44:
        .word   1175232512
.LC45:
        .word   1101004800
.LC46:
        .word   1174720512
.LC47:
        .word   1174011904
.LC48:
        .word   1171963904
.LC49:
        .word   -858993459
        .word   1072483532
.LC50:
        .word   -1717986918
        .word   1069128089
.LC51:
        .word   -1069547520
.LC52:
        .word   0
        .word   1071644672
.LC54:
        .word   1114636288
.LC59:
        .word   -1082130432
.LC60:
        .word   180045029
        .word   1074413353
.LC61:
        .word   1374389535
        .word   1076076216
.LC62:
        .word   0
        .word   1078853632
.LC63:
        .word   0
        .word   1073741824
.LC66:
        .word   1048576000
.LC69:
        .word   1051931443