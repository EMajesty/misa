// Simple ATF1508 glue for MISA 68k SBC
// - Decodes ROM, RAM, IO window
// - Generates UART/IDE/KBD/VID/AUDFM/WIFI chip selects
// - Very simple DTACK/BERR generation (tweak as needed)

module misa_glue (
    input  wire        clk,       // if you want registered outputs; can be omitted
    input  wire        reset_n,   // active-low reset for any registered logic

    // 68k bus inputs
    input  wire        as_n,
    input  wire        uds_n,
    input  wire        lds_n,
    input  wire [23:1] a,         // A23..A1 from CPU

    // chip select outputs (active low)
    output wire        romcs_n,
    output wire        ramcs_n,
    output wire        uartcs_n,
    output wire        idecs_n,
    output wire        kbdcs_n,
    output wire        vidcs_n,
    output wire        audfmcs_n,
    output wire        wifics_n,

    // bus handshake
    output wire        dtack_n,
    output wire        berr_n
);

    // Convenience aliases
    wire A23 = a[23];
    wire A22 = a[22];
    wire A21 = a[21];
    wire A20 = a[20];
    wire A19 = a[19];
    wire A18 = a[18];
    wire A17 = a[17];
    wire A16 = a[16];
    wire A15 = a[15];
    wire A14 = a[14];
    wire A13 = a[13];
    wire A12 = a[12];
    // lower bits (A11..A1) unused for coarse decode here

    // ----------------------------------------------------------------
    // Top-level regions (from README)
    // ROM 0x00000000–0x000FFFFF  (1 MiB)
    // RAM 0x00100000–0x001FFFFF  (1 MiB)
    // IO  0x00E00000–0x00FFFFFF  (2 MiB, sub-decoded)
    // ----------------------------------------------------------------

    // A23..A20 patterns:
    //  0000 -> ROM
    //  0001 -> RAM
    //  1110/1111 -> IO (0x00E00000–0x00FFFFFF)

    wire rom_region = ~A23 & ~A22 & ~A21 & ~A20;
    wire ram_region = ~A23 & ~A22 & ~A21 &  A20;
    wire io_region  =  A23 &  A22 &  A21;   // A20 = 0 or 1 -> 0x00E00000–0x00FFFFFF

    assign romcs_n = ~(rom_region);
    assign ramcs_n = ~(ram_region);

    // ----------------------------------------------------------------
    // IO submap, 4 KiB windows (README IO table)
    // Base: 0x00E00000
    //
    // UART   0x00E00000
    // IDE    0x00E01000
    // KBD    0x00E02000
    // VIDEO  0x00E03000
    // AUDIO  0x00E04000
    // WIFI   0x00E05000
    //
    // Here we just use A15..A12 as in the CUPL example.
    // ----------------------------------------------------------------

    wire uart_region  = io_region & ~A15 & ~A14 & ~A13 & ~A12;
    wire ide_region   = io_region & ~A15 & ~A14 & ~A13 &  A12;
    wire kbd_region   = io_region & ~A15 & ~A14 &  A13 & ~A12;
    wire vid_region   = io_region & ~A15 & ~A14 &  A13 &  A12;
    wire aud_region   = io_region & ~A15 &  A14 & ~A13 & ~A12;
    wire wifi_region  = io_region & ~A15 &  A14 & ~A13 &  A12;

    assign uartcs_n   = ~(uart_region);
    assign idecs_n    = ~(ide_region);
    assign kbdcs_n    = ~(kbd_region);
    assign vidcs_n    = ~(vid_region);
    assign audfmcs_n  = ~(aud_region);
    assign wifics_n   = ~(wifi_region);

    // ----------------------------------------------------------------
    // Simple DTACK/BERR
    // ----------------------------------------------------------------

    wire any_cs = ~romcs_n | ~ramcs_n |
                  ~uartcs_n | ~idecs_n | ~kbdcs_n |
                  ~vidcs_n  | ~audfmcs_n | ~wifics_n;

    // Combinatorial version (fast, minimal). For nicer timing, register these.
    assign dtack_n = ~(as_n == 1'b0 && any_cs);  // DTACK low when AS low & mapped
    assign berr_n  = ~(as_n == 1'b0 && ~any_cs); // BERR low when AS low & unmapped

endmodule

