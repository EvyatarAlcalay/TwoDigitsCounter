# Two-Digit Verilog Counter (00–99)

This Verilog project implements a **two-digit decimal counter**, counting from 00 to 99 using two cascaded 4-bit counters and 7-segment displays. It's designed for **Intel FPGA boards**, including simulation and deployment on hardware.

---

## 🔧 Target Platform

- **FPGA Board**: `5CSXFC6D6F31C6` (Intel/Altera Cyclone V)
- **Software**: [Intel Quartus Prime](https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/overview.html)
- **Clock Source**: 50MHz onboard clock

---

## 📁 Project Structure

| File              | Description                                     |
|-------------------|-------------------------------------------------|
| `mainQ1.v`        | Top-level module, connects counters and displays |
| `counter.v`       | 4-bit counter module (counts 0–9 with rollover) |
| `display.v`       | 7-segment display decoder (binary to HEX format) |
| `LPM.qip`         | IP file for LPM-based clock divider             |
| `Waveform.vwf`    | Simulation file (waveform for timing/behavior)  |

---

## ⚙️ How It Works

- **LPM** (Low-level PLL-based divider) divides the 50MHz clock into 1Hz.
- The **first counter** (units digit) counts from 0 to 9.
- On overflow, it sends a signal (`end_count`) to the **second counter** (tens digit).
- Each counter outputs a 4-bit binary number which is converted into 7-segment output using the `display` module.

---

## 🧪 Simulation

To simulate the design:

1. Open Quartus.
2. Load the waveform file: `Waveform.vwf`.
3. Compile the project.
4. Launch the **Simulation Waveform Editor**.
5. Observe:
   - `clk`: toggles every 20ns.
   - `reset`: asserted low for first 100ns, again at 1.64µs for 80ns.
   - `display1`, `display2`: update every second to reflect the count.
   - `en1`, `end_count_1`: internal signals controlling counter behavior.

---

## 🔌 FPGA Pin Mapping

| Signal       | FPGA Pin / Resource |
|--------------|---------------------|
| `clk`        | Connected to board's internal 50MHz clock |
| `reset`      | **KEY0** (push button) |
| `display1`   | **HEX0** (right digit) |
| `display2`   | **HEX1** (left digit)  |

> If using DE10-Nano or similar boards, you can use the default constraints file (`.qsf`) to assign pins accordingly.

# Assigning Pins in Quartus
To properly map the input/output pins for this project, please follow these steps:
1. Make sure the target FPGA device for your project is set correctly (Assignment → Devices).
2. In the window that opens, select the device model 5CSXFC6D6F31C6.
3. Compile and verify that your Top-Level Entity is the intended one (in our case, mainq1).
4. Navigate to Assignment → Pin Planner.
5. All inputs and outputs of your Top-Level Entity will be listed here. Assign the correct FPGA pins to each input/output according to the device datasheet.
6. Pay attention that pins may not appear in a specific order, so double-check your assignments carefully.
7. Re-compile the project after assigning the pins.

---

## ▶️ Running on Hardware

1. Compile the project in Quartus.
2. Program the FPGA board using `.sof` file.
3. Connect the FPGA board to power and your computer.
4. Open Tools → Programmer.
5. Under Hardware Setup, ensure the USB device is selected.
6. Click Auto-Detect and select the second-to-last device in the list.
7. Click Add File, navigate to the output folder, and select the .sof file.
8. You should see three devices listed in the Programmer; delete the first one.
9. Click Start to begin programming the FPGA.
10. Press and hold **KEY0** to reset the counter to 00.
11. Release the reset — the counter will now increment **once per second**, displaying the value on HEX0 and HEX1.
12. After reaching 99, the counter rolls back to 00 and repeats.

---

## 📸 Example Display (Simulated)

```
HEX1 HEX0
[ 0 ] [ 0 ]   →  00
[ 0 ] [ 1 ]   →  01
...
[ 9 ] [ 9 ]   →  99
→ Rolls over to →
[ 0 ] [ 0 ]   →  00
```

---

## 📌 Notes

- The `LPM.qip` is used for generating a 1Hz enable pulse from the system clock using Quartus's Megafunction.
- The `Waveform.vwf` simulates the key functionality and is helpful for debugging the counter and reset logic.
- No additional testbench is needed — the waveform file is sufficient for validating the behavior.

---

## 📂 Future Work

- Add optional `pause` / `start` control.
- Expand to support minutes and hours.
- Display decimal points or blinking effects.
