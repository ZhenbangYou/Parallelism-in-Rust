	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 11, 0
	.p2align	2
__ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17ha3c7ae2750d7d300E:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	__ZN4core3ops8function6FnOnce9call_once17h719ff96e6d362f08E
	; InlineAsm Start
	; InlineAsm End
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
	.cfi_endproc

	.private_extern	__ZN3std2rt10lang_start17h0dcdc967cf174d5fE
	.globl	__ZN3std2rt10lang_start17h0dcdc967cf174d5fE
	.p2align	2
__ZN3std2rt10lang_start17h0dcdc967cf174d5fE:
	.cfi_startproc
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	x8, x0
	str	x1, [sp]
	mov	x0, x2
	ldr	x2, [sp]
	str	x0, [sp, #8]
	mov	x4, x3
	ldr	x3, [sp, #8]
	sub	x0, x29, #8
	stur	x8, [x29, #-8]
	adrp	x1, l___unnamed_1@PAGE
	add	x1, x1, l___unnamed_1@PAGEOFF
	bl	__ZN3std2rt19lang_start_internal17h8ee16b8f6c950a26E
	str	x0, [sp, #16]
	ldr	x0, [sp, #16]
	.cfi_def_cfa wsp, 48
	ldp	x29, x30, [sp, #32]
	add	sp, sp, #48
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
	.cfi_endproc

	.p2align	2
__ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17hf12078a810ccfc9bE:
	.cfi_startproc
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x0, [x0]
	bl	__ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17ha3c7ae2750d7d300E
	bl	__ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17hdd45e9cd1ad29b18E
	sturb	w0, [x29, #-1]
	ldurb	w0, [x29, #-1]
	.cfi_def_cfa wsp, 32
	ldp	x29, x30, [sp, #16]
	add	sp, sp, #32
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
	.cfi_endproc

	.p2align	2
__ZN4core3fmt9Arguments9new_const17h8fce462b4f9257ebE:
	.cfi_startproc
	sub	sp, sp, #112
	.cfi_def_cfa_offset 112
	stp	x29, x30, [sp, #96]
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_remember_state
	str	x8, [sp, #8]
	str	x0, [sp, #16]
	str	x1, [sp, #24]
	subs	x8, x1, #1
	cset	w8, hi
	tbnz	w8, #0, LBB3_2
	b	LBB3_1
LBB3_1:
	ldr	x8, [sp, #8]
	ldr	x9, [sp, #24]
	ldr	x10, [sp, #16]
	stur	xzr, [x29, #-16]
	str	x10, [x8, #16]
	str	x9, [x8, #24]
	ldur	x10, [x29, #-16]
	ldur	x9, [x29, #-8]
	str	x10, [x8]
	str	x9, [x8, #8]
	adrp	x9, l___unnamed_2@PAGE
	add	x9, x9, l___unnamed_2@PAGEOFF
	str	x9, [x8, #32]
	str	xzr, [x8, #40]
	.cfi_def_cfa wsp, 112
	ldp	x29, x30, [sp, #96]
	add	sp, sp, #112
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
LBB3_2:
	.cfi_restore_state
	add	x8, sp, #32
	str	x8, [sp]
	adrp	x0, l___unnamed_3@PAGE
	add	x0, x0, l___unnamed_3@PAGEOFF
	mov	w9, #1
	mov	x1, x9
	bl	__ZN4core3fmt9Arguments9new_const17h8fce462b4f9257ebE
	ldr	x0, [sp]
	adrp	x1, l___unnamed_4@PAGE
	add	x1, x1, l___unnamed_4@PAGEOFF
	bl	__ZN4core9panicking9panic_fmt17h324f50b29db90195E
	.cfi_endproc

	.p2align	2
__ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h3a0475ca445090ffE:
	.cfi_startproc
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x0, [x0]
	bl	__ZN4core3ops8function6FnOnce9call_once17he4458c8ab1f59a79E
	.cfi_def_cfa wsp, 32
	ldp	x29, x30, [sp, #16]
	add	sp, sp, #32
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
	.cfi_endproc

	.p2align	2
__ZN4core3ops8function6FnOnce9call_once17h719ff96e6d362f08E:
	.cfi_startproc
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	blr	x0
	.cfi_def_cfa wsp, 32
	ldp	x29, x30, [sp, #16]
	add	sp, sp, #32
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
	.cfi_endproc

	.p2align	2
__ZN4core3ops8function6FnOnce9call_once17he4458c8ab1f59a79E:
Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, _rust_eh_personality
	.cfi_lsda 16, Lexception0
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	stp	x29, x30, [sp, #48]
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	x8, x0
	add	x0, sp, #16
	str	x8, [sp, #16]
Ltmp0:
	bl	__ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17hf12078a810ccfc9bE
	str	w0, [sp, #12]
Ltmp1:
	b	LBB6_3
LBB6_1:
	ldur	x0, [x29, #-16]
	bl	__Unwind_Resume
LBB6_2:
Ltmp2:
	stur	x0, [x29, #-16]
	mov	x8, x1
	stur	w8, [x29, #-8]
	b	LBB6_1
LBB6_3:
	ldr	w0, [sp, #12]
	.cfi_def_cfa wsp, 64
	ldp	x29, x30, [sp, #48]
	add	sp, sp, #64
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
Lfunc_end0:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table6:
Lexception0:
	.byte	255
	.byte	255
	.byte	1
	.uleb128 Lcst_end0-Lcst_begin0
Lcst_begin0:
	.uleb128 Ltmp0-Lfunc_begin0
	.uleb128 Ltmp1-Ltmp0
	.uleb128 Ltmp2-Lfunc_begin0
	.byte	0
	.uleb128 Ltmp1-Lfunc_begin0
	.uleb128 Lfunc_end0-Ltmp1
	.byte	0
	.byte	0
Lcst_end0:
	.p2align	2, 0x0

	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2
__ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17hd325421ab1669943E:
	.cfi_startproc
	ret
	.cfi_endproc

	.p2align	2
__ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17hdd45e9cd1ad29b18E:
	.cfi_startproc
	mov	w0, #0
	ret
	.cfi_endproc

	.p2align	2
__ZN4main4main17hac82363469e1a7a2E:
	.cfi_startproc
	sub	sp, sp, #80
	.cfi_def_cfa_offset 80
	stp	x29, x30, [sp, #64]
	add	x29, sp, #64
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	add	x8, sp, #16
	str	x8, [sp, #8]
	adrp	x0, l___unnamed_5@PAGE
	add	x0, x0, l___unnamed_5@PAGEOFF
	mov	w9, #1
	mov	x1, x9
	bl	__ZN4core3fmt9Arguments9new_const17h8fce462b4f9257ebE
	ldr	x0, [sp, #8]
	bl	__ZN3std2io5stdio6_print17h0b10b84a921ebcebE
	.cfi_def_cfa wsp, 80
	ldp	x29, x30, [sp, #64]
	add	sp, sp, #80
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
	.cfi_endproc

	.globl	_main
	.p2align	2
_main:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	x2, x1
	mov	x8, x0
	sxtw	x1, w8
	adrp	x0, __ZN4main4main17hac82363469e1a7a2E@PAGE
	add	x0, x0, __ZN4main4main17hac82363469e1a7a2E@PAGEOFF
	mov	w3, #0
	bl	__ZN3std2rt10lang_start17h0dcdc967cf174d5fE
	ldp	x29, x30, [sp], #16
	ret
	.cfi_endproc

	.section	__DATA,__const
	.p2align	3, 0x0
l___unnamed_1:
	.quad	__ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17hd325421ab1669943E
	.asciz	"\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	__ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h3a0475ca445090ffE
	.quad	__ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17hf12078a810ccfc9bE
	.quad	__ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17hf12078a810ccfc9bE

	.section	__TEXT,__const
l___unnamed_6:
	.ascii	"invalid args"

	.section	__DATA,__const
	.p2align	3, 0x0
l___unnamed_3:
	.quad	l___unnamed_6
	.asciz	"\f\000\000\000\000\000\000"

	.section	__TEXT,__const
l___unnamed_7:
	.ascii	"/rustc/90c541806f23a127002de5b4038be731ba1458ca/library/core/src/fmt/mod.rs"

	.section	__DATA,__const
	.p2align	3, 0x0
l___unnamed_4:
	.quad	l___unnamed_7
	.asciz	"K\000\000\000\000\000\000\000\221\001\000\000\r\000\000"

	.section	__TEXT,__const
	.p2align	3, 0x0
l___unnamed_2:
	.byte	0

l___unnamed_8:
	.ascii	"Hello, world!\n"

	.section	__DATA,__const
	.p2align	3, 0x0
l___unnamed_5:
	.quad	l___unnamed_8
	.asciz	"\016\000\000\000\000\000\000"

.subsections_via_symbols
