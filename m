From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 08 Aug 2024 13:44:23 +0930
Subject: [PATCH v2 0/2] dt-bindings: interrupt-controller: Convert Aspeed
 (C)VIC to DT schema
Message-ID: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-0-c2531e02633d@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This short series converts the Aspeed VIC and CVIC bindings over to DT
schema. The CVIC has historically been documented under "misc" as it's
the interrupt controller for the Coldfire co-processor embedded in the
SoCs, and not for the main ARM core. Regardless, I've updated both in
this series.

I tried to document the historical oddities and conversion quirks in the
commit messages where appropriate.

Please review!

Andrew

---
Changes in v2:
- Address feedback from Krzysztof
  - https://lore.kernel.org/r/c51fb027-f8bd-4b10-b9c0-dbbe8e8cf4c1 at kernel.org/
  - https://lore.kernel.org/r/ec19fe07-84bd-4c32-a886-e6126af52f4c at kernel.org/
- Address feedback from Rob
  - https://lore.kernel.org/r/20240806172917.GA1836473-robh at kernel.org/
- Link to v1: https://lore.kernel.org/r/20240802-dt-warnings-irq-aspeed-dt-schema-v1-0-8cd4266d2094 at codeconstruct.com.au

---
Andrew Jeffery (2):
      dt-bindings: interrupt-controller: aspeed,ast2400-vic: Convert to DT schema
      dt-bindings: misc: aspeed,ast2400-cvic: Convert to DT schema

 .../interrupt-controller/aspeed,ast2400-vic.txt    | 23 --------
 .../interrupt-controller/aspeed,ast2400-vic.yaml   | 62 ++++++++++++++++++++++
 .../bindings/misc/aspeed,ast2400-cvic.yaml         | 60 +++++++++++++++++++++
 .../devicetree/bindings/misc/aspeed,cvic.txt       | 35 ------------
 4 files changed, 122 insertions(+), 58 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240802-dt-warnings-irq-aspeed-dt-schema-5f5efd5d431a

Best regards,
-- 
Andrew Jeffery <andrew@codeconstruct.com.au>

