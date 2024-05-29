From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 29 May 2024 14:43:19 +0930
Subject: [PATCH 0/4] dt-bindings: gpio: aspeed,sgpio: Miscellaneous
 cleanups
Message-ID: <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-0-91c42976833b@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This short series fixes some SGPIO-related devicetree warnings currently
emitted by `make dtbs_check` for Aspeed devicetrees.

One change documents `#interrupt-cells` and a subseqent change makes
it required. The property should have been both documented and marked
as required from the start. As the change is technically not backwards
compatible, I've split it such that we can debate the required status
separately.

Please review!

Andrew

---
Andrew Jeffery (4):
      dt-bindings: gpio: aspeed,sgpio: Order properties by DTS style
      dt-bindings: gpio: aspeed,sgpio: Specify gpio-line-names
      dt-bindings: gpio: aspeed,sgpio: Specify #interrupt-cells
      dt-bindings: gpio: aspeed,sgpio: Require #interrupt-cells

 .../devicetree/bindings/gpio/aspeed,sgpio.yaml     | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240528-dt-warnings-gpio-sgpio-interrupt-cells-685a0efd2c0b

Best regards,
-- 
Andrew Jeffery <andrew@codeconstruct.com.au>

