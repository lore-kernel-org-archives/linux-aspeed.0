From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 30 May 2024 11:09:47 +0930
Subject: [PATCH v2 0/2] dt-bindings: gpio: aspeed,sgpio: Miscellaneous
 cleanups
Message-ID: <20240530-dt-warnings-gpio-sgpio-interrupt-cells-v2-0-912cd16e641f@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This short series fixes some SGPIO-related devicetree warnings currently
emitted by `make dtbs_check` for Aspeed devicetrees.

Please review!

Andrew

---
Changes in v2:
- Dropped 1/4 from v1 as it was considered noise (Krzysztof)
- Squashed 4/4 into 3/4 from v1 (Krzysztof)
- Addressed remaining comments and applied tags (Krzysztof)
- Link to v1: https://lore.kernel.org/r/20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-0-91c42976833b at codeconstruct.com.au

---
Andrew Jeffery (2):
      dt-bindings: gpio: aspeed,sgpio: Specify gpio-line-names
      dt-bindings: gpio: aspeed,sgpio: Specify #interrupt-cells

 Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240528-dt-warnings-gpio-sgpio-interrupt-cells-685a0efd2c0b

Best regards,
-- 
Andrew Jeffery <andrew@codeconstruct.com.au>

