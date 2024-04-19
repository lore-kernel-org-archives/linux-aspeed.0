From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 19 Apr 2024 16:11:40 -0500
Subject: [PATCH v3 0/3] fsi: sbefifo: Prevent async FFDC collection for Odyssey SBEFIFOs
Message-ID: <20240419211143.1039868-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A new type of SBE, found on the Odyssey chip, will return any async FFDC in
the next transaction, so collecting the FFDC is unnecessary and results in
unexpected behavior. This difference in behavior between the Odyssey SBE
and the POWER9/10 SBEs wasn't apparent when support for the Odyssey was
added. To fix the unexpected behavior, turn off the async collection fot
Odyssey SBEFIFOs.

Changes since v2:
 - Update commit messages slightly
 - Rename dts binding file
 - Remove '|' after description in dts binding
 - Change generic node name in dts binding to match fsi.txt

Changes since v1:
 - Change "ody" to "odyssey"
 - Fix minor issues in binding document

Eddie James (3):
  dt-bindings: fsi: Document the IBM SBEFIFO engine
  fsi: sbefifo: Prevent async FFDC collection for Odyssey SBEFIFOs
  ARM: dts: aspeed: Update Odyssey SBEFIFO compatible strings

 .../bindings/fsi/ibm,p9-sbefifo.yaml          | 39 +++++++++++
 .../dts/aspeed/aspeed-bmc-ibm-everest.dts     | 64 +++++++++----------
 .../arm/boot/dts/aspeed/ibm-power10-quad.dtsi | 64 +++++++++----------
 drivers/fsi/fsi-sbefifo.c                     | 37 +++++++++++
 4 files changed, 140 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-sbefifo.yaml

-- 
2.39.3

