From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 15 Apr 2024 10:39:04 -0500
Subject: [PATCH v2 0/3] fsi: sbefifo: Prevent async FFDC collection for Odyssey SBEFIFOs
Message-ID: <20240415153907.10051-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A new type of SBE on the Odyssey chip will return any async FFDC in the
next transaction, so collecting the FFDC is unnecessary and results in
unexpected behavior. Turn off the async collection for Odyssey SBEFIFOs.

Changes since v1:
 - Change "ody" to "odyssey"
 - Fix minor issues in binding document

Eddie James (3):
  dt-bindings: fsi: Document the IBM SBEFIFO engine
  fsi: sbefifo: Prevent async FFDC collection for Odyssey SBEFIFOs
  ARM: dts: aspeed: Update Odyssey SBEFIFO compatible strings

 .../devicetree/bindings/fsi/ibm,sbefifo.yaml  | 39 +++++++++++
 .../dts/aspeed/aspeed-bmc-ibm-everest.dts     | 64 +++++++++----------
 .../arm/boot/dts/aspeed/ibm-power10-quad.dtsi | 64 +++++++++----------
 drivers/fsi/fsi-sbefifo.c                     | 37 +++++++++++
 4 files changed, 140 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,sbefifo.yaml

-- 
2.39.3

