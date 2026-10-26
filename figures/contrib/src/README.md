# Contribution figures for the TOMM extension of MOSAIC

Eight vector figures and two tables that document what was built or changed in each layer of the pipeline. All figures are drawn at the `acmart` `acmsmall` text width (13.9 cm), so they are included with `width=\textwidth` and the text inside them stays at 6–7.5 pt. Fonts are Libertinus Sans and Inconsolata (the acmart code face), embedded and subset in every PDF.

| File | Content |
|---|---|
| `fig1_overview.pdf` | Whole pipeline in four lanes, each component tagged new / patched / unmodified, with measurement points |
| `fig2_encoder_shim.pdf` | TMC2 + HMAPP shim (ffmpeg 6.1.1 + libx265 3.5) + HM for occupancy, chunking |
| `fig3_decoder_integration.pdf` | (a) DASH-client replacement DLL feeding the 5G-MAG decoder, (b) teardown deadlock fix |
| `fig4_http3_plugin.pdf` | (a) lsquic plugin architecture and C ABI, (b) connection model vs curl, (c) measured comparison |
| `fig5_deadline_scheduler.pdf` | (a) per-slot scheduler loop (campaign-v2), (b) lag classification |
| `fig6_gldx_openxr_bypass.pdf` | GLDXInterop: GL to D3D11 zero copy, direct OpenVR submit, OpenXR bypassed |
| `fig7_origin_impairment.pdf` | Caddy, per-port HTB/TBF/netem chain, single TX queue, qlog + pcap join |
| `fig8_transport_map.pdf` | Harness transport map (B loss, C delay, D 9 ms + loss) with verdict bands |
| `tab_contributions.tex` | Table: upstream baseline, our adaptation and reason, per component |
| `tab_transport_confounds.tex` | Table: the six transport confounds, before and after |
| `include_in_paper.tex` | Ready figure environments with captions and the `\Description` text acmart requires |

Provenance encoding (all figures): blue solid = new in this work, orange dashed = upstream component we patched, grey thin = upstream or third party used unmodified, red dotted = removed or bypassed path. Colour and line style both carry the meaning, so the figures survive grayscale printing. Sequence colours follow the packetization study (Soldier `#0072B2`, ThaiDancer `#009E73`, Longdress `#CC79A7`).

## Rebuild

```
./build.sh                 # all figures, XeLaTeX, previews in preview/
./build.sh fig4_http3_plugin.tex
```

`figstyle.tex` holds the palette, fonts and box styles. Fonts load from `fonts/` (SIL OFL), so the build does not depend on system fonts. Overleaf: upload the folder and set the compiler to XeLaTeX, or just upload the PDFs.

## Check before submission

Each item below comes from chat history or project notes rather than from the code, so it is worth one look:

1. **Fig. 2, shim back end.** The figure says the shim calls ffmpeg 6.1.1 with libx265 3.5 (matches the encoder log `[x265-wrapper]` and the `dpkg` version check). One June chat claimed the shim calls the x265 CLI directly. Confirm with `grep -E "ffmpeg|x265" ~/tmc2.sh` in WSL.
2. **Fig. 4(c) numbers** (98.6 ± 0.6 vs 47.6 ± 14.6 % on time at 8 sessions; 93.6 vs ≈43 Mb/s at 4 sessions under a 100 Mb/s cap) come from the June benchmark at look-ahead 4. Re-read them from the benchmark CSVs. The same campaign found curl recovering faster than the plugin at look-ahead 2, so the text should say the plugin's advantage is concurrency and per-session state, not cold start.
3. **Fig. 3.** "4 HEVC decoders" and the `dashc_*` names come from the upstream issue and the shim source (the DLL exports seven `dashc_*` symbols; the figure abbreviates two of them).
4. **Fig. 7, slice A.** Drawn as TBF without netem. Check `tc qdisc show dev eth0` on the VM. The netem queue limit is "raised" (10 000 on 19/10 per the server notes, 20 000 in the briefs), so the figure gives no number.
5. **Fig. 8** shows harness results, not Unity results, and marks the candidate values (B 1.25 %, C 55 ms, D 9 ms + 0.02 %) that still need the Unity lap.
6. **Fig. 1 and 6** show Stage 2 over private 5G with the USB-C dongle, as in the ICIP paper. The tutorial setup uses Wi-Fi instead. Eye targets are 1832×1920 per eye, which the tutorial plan flags as a candidate to raise.
