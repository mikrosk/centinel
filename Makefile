top_dir	:= $(PWD)

AS	:= asm020.ttp
ASFLAGS	:= -w -l1 -i$(top_dir) -p=68020
LD	:= plink.ttp
LDFLAGS := -G -L -S=128

default: DSP_BUG.PRG CENTINEL.PRG

# linkdsp.lnk
OBJ_DSP_BUG := \
	dsp\dsp_bug.o \
	dsp\dsp_desa.o \
	dsp\load_cld.o \
	dsp\load_lod.o \
	dsp\load_p56.o \
	dsp\gen_fen.o \
	dsp\windows.o \
	dsp\scroll.o \
	40\cent_bug.o \
	40\dessas.o \
	40\asm.inc\asm.o \
	40\main.inc\aff_desa.o \
	40\main.inc\aff_reg.o \
	40\main.inc\test.o \
	40\main.inc\aff_dump.o \
	40\main.inc\r_total.o \
	40\main.inc\load.o \
	both\aff_font.o \
	both\clavier.o \
	both\hexedit.o \
	both\eval.o \
	both\gestion.o \
	both\menu.o \
	both\video.o \
	both\cfg_file.o \
	both\f_sel.o
#dsp\lod.o

# centinel.lnk
OBJ_CENTINEL := \
 	40\cent_bug.o \
	40\asm.inc\asm.o \
	40\dessas.o \
	40\main.inc\aff_desa.o \
	40\main.inc\aff_reg.o \
	40\main.inc\aff_dump.o \
	40\main.inc\r_total.o \
	40\main.inc\load.o \
	40\main.inc\test.o \
	dsp\dsp_bug.o \
	dsp\load_cld.o \
	dsp\load_lod.o \
	dsp\load_p56.o \
	dsp\gen_fen.o \
	dsp\dsp_desa.o \
	dsp\scroll.o \
	both\aff_font.o \
	both\clavier.o \
	both\hexedit.o \
	both\eval.o \
	both\gestion.o \
	both\menu.o \
	both\windows.o \
	both\video.o \
	both\cfg_file.o \
	both\f_sel.o
#dsp\lod.o

DSP_BUG.PRG: $(OBJ_DSP_BUG) dsp\lod.o
	# $(OBJ_DSP_BUG) is too long...
	$(LD) $(LDFLAGS) -C=linkdsp.lnk -O=$@

CENTINEL.PRG: $(OBJ_CENTINEL) dsp\lod.o
	# $(OBJ_CENTINEL) is too long...
	$(LD) $(LDFLAGS) -C=centinel.lnk -O=$@
	#$(CP) CENTINEL.PRG $(CODEPATH)\mon.prg
	#$(CP) CENTINEL.PRG c:\auto\rentinel.prg

# 040
40\asm.inc\asm.o : both\define.s 40\macros.s
40\cent_bug.o	: both\define.s 40\macros.s 40\main.inc\fonction.s 40\main.inc\reloc.s 40\main.inc\saveload.s 40\main.inc\aff_dump.s 40\main.inc\scroll.s
40\dessas.o	: both\define.s 40\desas.inc\aff_nb.s 40\desas.inc\aff_nb_z.s 40\desas.inc\mode.s 40\desas.inc\table_fp.s 40\desas.inc\table_i.s
40\main.inc\aff_desa.o	: both\define.s 40\macros.s
40\main.inc\aff_reg.o	: both\define.s 40\macros.s
40\main.inc\aff_dump.o	: both\define.s 40\macros.s
40\main.inc\load.o	: both\define.s 40\macros.s
40\main.inc\r_total.o	: both\define.s 40\macros.s
# BOTH
both\aff_font.o : both\define.s both\tabaff.s both\open_win.s
both\clavier.o 	: both\define.s both\tab_car.S
both\hexedit.o 	: both\define.s
both\eval.o 	: both\define.s 40\eval.inc\convert.s 40\eval.inc\aff_n.s
both\gestion.o 	: both\define.s
both\video.o	: both\define.s both\xbios.equ both\video.rs both\gem.equ
both\cfg_file.o	: both\define.s both\default.inf
both\f_sel.o 	: both\define.s
both\menu.o	: both\define.s both\localmac.s
#both\windows.o	:
#40\main.inc\test.o :

# DSP
dsp\dsp_bug.o : both\define.s dsp\dsp.p56
dsp\load_cld.o:	both\define.s
dsp\load_lod.o:	both\define.s
dsp\load_p56.o:	both\define.s
dsp\gen_fen.o :	both\define.s
dsp\dsp_desa.o: both\define.s dsp\table.s dsp\instruct.s dsp\no_paral.s dsp\paral.s
dsp\scroll.o  :	both\define.s
dsp\windows.o :	both\define.s

.s.o:
	$(AS) $(ASFLAGS) -o=$(top_dir)\$@ $(top_dir)\$<

clean:
	rm -f DSP_BUG.PRG CENTINEL.PRG $(OBJ_DSP_BUG) $(OBJ_CENTINEL)
