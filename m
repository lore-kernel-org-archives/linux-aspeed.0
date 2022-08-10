From: Rob Herring <robh@kernel.org>
Date: Wed, 10 Aug 2022 10:16:33 -0600
Subject: [PATCH 0/2] Convert Aspeed SCU to DT schema
Message-ID: <20220810161635.73936-1-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This short series converts the aspeed,ast2x00-scu binding to DT schema.
The binding is already in use in examples which unsurprisingly need fixes
with the schema added.

If someone wants to convert the remaining child node bindings, that would
be nice.

This is part of getting rid of the remaining ~40 cases of compatibles
without a schema in the examples.

Rob


Rob Herring (2):
  dt-bindings: pinctrl: aspeed: Add missing properties to examples
  dt-bindings: mfd: aspeed,ast2x00-scu: Convert to DT schema format

 .../bindings/mfd/aspeed,ast2x00-scu.yaml      | 110 ++++++++++++++++++
 .../devicetree/bindings/mfd/aspeed-scu.txt    |  48 --------
 .../pinctrl/aspeed,ast2400-pinctrl.yaml       |   6 +
 .../pinctrl/aspeed,ast2500-pinctrl.yaml       |   4 +
 .../pinctrl/aspeed,ast2600-pinctrl.yaml       |   6 +
 5 files changed, 126 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-scu.txt

--
2.34.1
