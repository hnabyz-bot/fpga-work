// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------

`timescale 1 ps / 1 ps

(* BLOCK_STUB = "true" *)
module seq_lut (
  a,
  d,
  dpra,
  clk,
  we,
  dpo
);

  (* X_INTERFACE_IGNORE = "true" *)
  input [7:0]a;
  (* X_INTERFACE_IGNORE = "true" *)
  input [51:0]d;
  (* X_INTERFACE_IGNORE = "true" *)
  input [7:0]dpra;
  (* X_INTERFACE_IGNORE = "true" *)
  input clk;
  (* X_INTERFACE_IGNORE = "true" *)
  input we;
  (* X_INTERFACE_IGNORE = "true" *)
  output [51:0]dpo;

  // stub module has no contents

endmodule
