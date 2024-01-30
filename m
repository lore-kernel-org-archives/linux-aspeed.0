From: Corona, Ernesto <ernesto.corona@intel.com>
Date: Tue, 30 Jan 2024 23:25:58 +0000
Subject: [PATCH 30 0/7] JTAG driver introduction
Message-ID: <LV8PR11MB84630A9738C99952A0ABEC788B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When a need raise up to use JTAG interface for system's devices programming or CPU debugging, usually the user layer application implements jtag protocol by bit-bang or using a proprietary connection to vendor hardware.
This method can be slow and not generic.
 
We propose to implement general JTAG interface and infrastructure to communicate with user layer application. In such way, we can have the standard JTAG interface core part and separation from specific HW implementation.
This allow new capability to debug the CPU or program system's device via BMC without additional devices nor cost. 

This patch purpose is to add JTAG master core infrastructure by defining new JTAG class and provide generic JTAG interface to allow hardware specific drivers to connect this interface.
This will enable all JTAG drivers to use the common interface part and will have separate for hardware implementation.

The JTAG (Joint Test Action Group) core driver provides minimal generic JTAG interface, which can be used by hardware specific JTAG master controllers. By providing common interface for the JTAG controllers, user space device programing is hardware independent.
 
Modern SoC which in use for embedded system' equipped with internal JTAG master interface.
This interface is used for programming and debugging system's hardware components, like CPLD, FPGA, CPU, voltage and industrial controllers.
Firmware for such devices can be upgraded through JTAG interface during Runtime. The JTAG standard support for multiple devices programming, is in case their lines are daisy-chained together.

For example, systems which equipped with host CPU, BMC SoC or/and number of programmable devices are capable to connect a pin and select system components dynamically for programming and debugging, This is using by the BMC which is equipped with internal SoC master controller.
For example:

BMC JTAG master --> pin selected to CPLDs chain for programming (filed upgrade, production) 
BMC JTAG master --> pin selected to voltage monitors for programming (field upgrade, production) 
BMC JTAG master --> pin selected to host CPU (on-site debugging and developers debugging)

For example, we can have application in user space which using calls to JTAG driver executes CPLD programming directly from SVF file
 
The JTAG standard (IEEE 1149.1) defines the next connector pins:
- TDI (Test Data In);
- TDO (Test Data Out);
- TCK (Test Clock);
- TMS (Test Mode Select);
- TRST (Test Reset) (Optional);

The SoC equipped with JTAG master controller, performs device programming on command or vector level. For example a file in a standard SVF (Serial Vector Format) that contains boundary scan vectors, can be used by sending each vector to the JTAG interface and the JTAG controller will execute the programming.

Initial version provides the system calls set for:
- SIR (Scan Instruction Register, IEEE 1149.1 Instruction Register scan);
- SDR (Scan Data Register, IEEE 1149.1 Data Register scan);
- RUNTEST (Forces the IEEE 1149.1 bus to a run state for a specified number of clocks.

SoC which are not equipped with JTAG master interface, can be built on top of JTAG core driver infrastructure, by applying bit-banging of TDI, TDO, TCK and TMS pins within the hardware specific driver.

Testing
These drivers are in use for the At-scale-debug solution mostly in the server space. We have been using AST2500 and AST2600 from Aspeed for over 4 years, so this are working drivers.

Ernesto Corona (7):
  Add JTAG core driver
  Add binding for Aspeed SOC
  Add Aspeed SOC 24xx, 25xx and 26xx JTAG support
  Add ABI documentation
  Add JTAG core driver ioctl number
  Add JTAG core driver Maintainers
  Add AST2500 and AST2600 JTAG device in DTS

 Documentation/ABI/testing/jtag-dev            |   23 +
 .../devicetree/bindings/jtag/aspeed-jtag.yaml |   85 +
 Documentation/jtag/index.rst                  |   18 +
 Documentation/jtag/jtag-summary.rst           |   49 +
 Documentation/jtag/jtagdev.rst                |  222 +++
 .../userspace-api/ioctl/ioctl-number.rst      |    2 +
 MAINTAINERS                                   |   13 +
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi       |    9 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |   20 +
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    1 +
 drivers/jtag/Kconfig                          |   46 +
 drivers/jtag/Makefile                         |    2 +
 drivers/jtag/jtag-aspeed.c                    | 1666 +++++++++++++++++
 drivers/jtag/jtag.c                           |  387 ++++
 include/linux/jtag.h                          |   49 +
 include/uapi/linux/jtag.h                     |  378 ++++
 17 files changed, 2972 insertions(+)
 create mode 100644 Documentation/ABI/testing/jtag-dev
 create mode 100644 Documentation/devicetree/bindings/jtag/aspeed-jtag.yaml
 create mode 100644 Documentation/jtag/index.rst
 create mode 100644 Documentation/jtag/jtag-summary.rst
 create mode 100644 Documentation/jtag/jtagdev.rst
 create mode 100644 drivers/jtag/Kconfig
 create mode 100644 drivers/jtag/Makefile
 create mode 100644 drivers/jtag/jtag-aspeed.c
 create mode 100644 drivers/jtag/jtag.c
 create mode 100644 include/linux/jtag.h
 create mode 100644 include/uapi/linux/jtag.h

-- 
2.25.1
