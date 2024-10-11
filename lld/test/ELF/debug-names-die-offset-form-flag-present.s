# This file was generated by:
# clang++ -g -O0 -S -fdebug-compilation-dir='/proc/self/cwd' -gpubnames a.cpp

# Then manually changing the first .debug_names abbrev, so that the
# DW_IDX_die_offset uses DW_FORM_flag_present (invalid) & the DW_IDX_parent
# uses DW_FORM_ref4. Also updated the sizes of the values in the entry
# that uses the abbrev, to match the sizes of the forms.

# Contents of a.cpp
# int main (int argc, char **argv) { }

# REQUIRES: x86
# RUN: llvm-mc -filetype=obj -triple=x86_64 %s -o %t1.o
# RUN: not ld.lld --debug-names %t1.o -o /dev/null 2>&1 \
# RUN:   | FileCheck -DFILE=%t1.o --implicit-check-not=error: %s

# CHECK: error: [[FILE]]:(.debug_names): unrecognized form encoding 25 in abbrev table

	.text
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
.Lfunc_begin0:
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
.Ltmp0:
	xorl	%eax, %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Ltmp1:
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.section	.debug_abbrev,"",@progbits
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	0                               # EOM(3)
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.long	.Ldebug_info_end0-.Ldebug_info_start0 # Length of Unit
.Ldebug_info_start0:
	.short	5                               # DWARF version number
	.byte	1                               # DWARF Unit Type
	.byte	8                               # Address Size (in bytes)
	.long	.debug_abbrev                   # Offset Into Abbrev. Section
.Ldebug_info_end0:
	.section	.debug_str_offsets,"",@progbits
	.long	36                              # Length of String Offsets Set
	.short	5
	.short	0
.Lstr_offsets_base0:
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"clang version 19.0.0git (git@github.com:llvm/llvm-project.git 53b14cd9ce2b57da73d173fc876d2e9e199f5640)" # string offset=0
.Linfo_string1:
	.asciz	"a.cpp"                         # string offset=104
.Linfo_string2:
	.asciz	"/proc/self/cwd"                # string offset=110
.Linfo_string3:
	.asciz	"main"                          # string offset=125
.Linfo_string4:
	.asciz	"int"                           # string offset=130
.Linfo_string5:
	.asciz	"argc"                          # string offset=134
.Linfo_string6:
	.asciz	"argv"                          # string offset=139
.Linfo_string7:
	.asciz	"char"                          # string offset=144
.Laddr_table_base0:
	.quad	.Lfunc_begin0
.Ldebug_addr_end0:
	.section	.debug_names,"",@progbits
	.long	.Lnames_end0-.Lnames_start0     # Header: unit length
.Lnames_start0:
	.short	5                               # Header: version
	.short	0                               # Header: padding
	.long	1                               # Header: compilation unit count
	.long	0                               # Header: local type unit count
	.long	0                               # Header: foreign type unit count
	.long	3                               # Header: bucket count
	.long	3                               # Header: name count
	.long	.Lnames_abbrev_end0-.Lnames_abbrev_start0 # Header: abbreviation table size
	.long	8                               # Header: augmentation string size
	.ascii	"LLVM0700"                      # Header: augmentation string
	.long	.Lcu_begin0                     # Compilation unit 0
	.long	0                               # Bucket 0
	.long	1                               # Bucket 1
	.long	2                               # Bucket 2
	.long	2090499946                      # Hash in Bucket 1
	.long	193495088                       # Hash in Bucket 2
	.long	2090147939                      # Hash in Bucket 2
	.long	.Linfo_string3                  # String in Bucket 1: main
	.long	.Linfo_string4                  # String in Bucket 2: int
	.long	.Linfo_string7                  # String in Bucket 2: char
	.long	.Lnames0-.Lnames_entries0       # Offset in Bucket 1
	.long	.Lnames1-.Lnames_entries0       # Offset in Bucket 2
	.long	.Lnames2-.Lnames_entries0       # Offset in Bucket 2
.Lnames_abbrev_start0:
	.byte	1                               # Abbrev code
	.byte	46                              # DW_TAG_subprogram
	.byte	3                               # DW_IDX_die_offset
	.byte	25                              # DW_FORM_flag_present
	.byte	4                               # DW_IDX_parent
	.byte	19                              # DW_FORM_ref4
	.byte	0                               # End of abbrev
	.byte	0                               # End of abbrev
	.byte	2                               # Abbrev code
	.byte	36                              # DW_TAG_base_type
	.byte	3                               # DW_IDX_die_offset
	.byte	19                              # DW_FORM_ref4
	.byte	4                               # DW_IDX_parent
	.byte	25                              # DW_FORM_flag_present
	.byte	0                               # End of abbrev
	.byte	0                               # End of abbrev
	.byte	0                               # End of abbrev list
.Lnames_abbrev_end0:
.Lnames_entries0:
.Lnames0:
.L1:
	.byte	1                               # Abbreviation code
	.byte	35                              # DW_IDX_die_offset
	.long	0                               # DW_IDX_parent
                                        # End of list: main
.Lnames1:
.L0:
	.byte	2                               # Abbreviation code
	.long	73                              # DW_IDX_die_offset
	.byte	0                               # DW_IDX_parent
                                        # End of list: int
.Lnames2:
.L2:
	.byte	2                               # Abbreviation code
	.long	87                              # DW_IDX_die_offset
	.byte	0                               # DW_IDX_parent
                                        # End of list: char
	.p2align	2, 0x0
.Lnames_end0:
	.ident	"clang version 19.0.0git (git@github.com:llvm/llvm-project.git 53b14cd9ce2b57da73d173fc876d2e9e199f5640)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.section	.debug_line,"",@progbits
.Lline_table_start0:
