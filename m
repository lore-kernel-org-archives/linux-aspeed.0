From: Joel Stanley <joel@jms.id.au>
Date: Fri,  4 Mar 2022 10:33:09 +1030
Subject: [PATCH v2 0/2] dt-bindings: Convert GFX bindings to yaml
Message-ID: <20220304000311.970267-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

v1: https://lore.kernel.org/all/20220302051056.678367-1-joel at jms.id.au/

This series cleans up the bindings for the ASPEED GFX unit.

The old text files are deleted for both the description under gpu, and the
placeholder one under mfd.

The mfd one existed because pinctrl for the 2500 depends on the gfx
bindings, and at the time we didn't have any support fo the gfx device,
so Andrew added the mfd ones.

The example in the pinctrl bindings is updated to prevent warnings about
missing properties that pop up when the gfx yaml bindings are added.

Joel Stanley (2):
  dt-bindings: pinctrl: aspeed: Update gfx node in example
  dt-bindings: gpu: Convert aspeed-gfx bindings to yaml

 .../devicetree/bindings/gpu/aspeed,gfx.yaml   | 69 +++++++++++++++++++
 .../devicetree/bindings/gpu/aspeed-gfx.txt    | 41 -----------
 .../devicetree/bindings/mfd/aspeed-gfx.txt    | 17 -----
 .../pinctrl/aspeed,ast2500-pinctrl.yaml       | 16 +++++
 4 files changed, 85 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/aspeed,gfx.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-gfx.txt

-- 
2.34.1

