From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 31 May 2024 12:32:46 +0930
Subject: [PATCH 0/3] dt-bindings: pinctrl: aspeed: Define missing functions
 and groups
Message-ID: <20240531-dt-warnings-gpio-ast2600-pinctrl-funcs-groups-v1-0-a6fe2281a1b8@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This short series cleans up a collection of binding warnings concerning
use of undefined pinctrl functions and groups. Together they make a
reasonable dent in the volume of output from `make dtbs_check` for the
Aspeed devicetrees.

Please review!

Andrew

---
Andrew Jeffery (3):
      dt-bindings: pinctrl: aspeed: Use block syntax for function and groups
      dt-bindings: pinctrl: aspeed,ast2500-pinctrl: Describe SGPM
      dt-bindings: pinctrl: aspeed,ast2600-pinctrl: Describe I3C, USB

 .../bindings/pinctrl/aspeed,ast2400-pinctrl.yaml   | 169 ++++++-
 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   | 188 +++++++-
 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   | 507 +++++++++++++++++++--
 3 files changed, 781 insertions(+), 83 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240531-dt-warnings-gpio-ast2600-pinctrl-funcs-groups-e1464a72d84b

Best regards,
-- 
Andrew Jeffery <andrew@codeconstruct.com.au>

