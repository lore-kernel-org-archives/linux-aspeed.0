From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Tue,  5 Sep 2023 14:22:20 +0800
Subject: [PATCH v8 0/2] Add Facebook Minerva (AST2600) BMC
Message-ID: <20230905062223.774871-1-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Summary:
Correcting the arrangement order in Makefile.
  +	aspeed-bmc-facebook-greatlakes.dtb \
  +	aspeed-bmc-facebook-minerva.dtb \
  +	aspeed-bmc-facebook-minipack.dtb \

Correcting the arrangement order in Document
  +            - facebook,greatlakes-bmc
  +            - facebook,minerva-bmc
  +            - facebook,yosemite4-bmc

Remove redundant blank line.
1.
  +	/*P4-P7 line 248-255*/
  +	"","","","","","","","";
  +};

2.
  +
  +// SOL Host Console

3.
  +
  +//BIOS Flash

4.
  +&uart2 {
  +	status = "okay";
  +	pinctrl-0 = <>;
  +};

Use stdout-path.
  +	chosen {
  +		stdout-path = &uart5;
  +	};

Fix dts path.
  old:arch/arm/boot/dts/
  new:arch/arm/boot/dts/aspeed


*** BLURB HERE ***

Peter Yin (2):
  ARM: dts: aspeed: Minerva: Add Facebook Minerva (AST2600) BMC
  dt-bindings: arm: aspeed: add Meta Minerva board

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 377 ++++++++++++++++++
 3 files changed, 379 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts

-- 
2.25.1

