From: Zev Weiss <zev@bewilderbeest.net>
Date: Thu,  1 Apr 2021 19:47:12 -0500
Subject: [PATCH v3 0/4] aspeed-vuart: generalized DT properties
Message-ID: <20210402004716.15961-1-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series generalizes the aspeed-vuart driver's device tree
properties to cover all the attributes it currently exposes via sysfs.

The aspeed,sirq-polarity-sense property was a bit of a design mistake
in that it ties Aspeed VUART SIRQ polarity to SCU register bits that
aren't really inherently related to it; the first patch in this series
deprecates it (though we hope to eventually remove it).

The rest of the series adds two new properties, aspeed,lpc-address and
aspeed,sirq.  The latter allows describing the SIRQ polarity (along
with the interrupt number) directly, providing a simpler replacement
for aspeed,sirq-polarity-sense.


Changes since v2 [0]:
 - expanded to also handle sirq number and lpc address in addition to
   sirq polarity
 - added default settings if DT properties not specified
 - refactored existing sysfs code slightly, adding range checks
 - cleaned up 'make dt_binding_check' warnings

Changes since v1 [1]:
 - deprecate and retain aspeed,sirq-polarity-sense instead of removing it
 - drop e3c246d4i dts addition from this series

[0] https://lore.kernel.org/openbmc/20210401005702.28271-1-zev at bewilderbeest.net/
[1] https://lore.kernel.org/openbmc/20210330002338.335-1-zev at bewilderbeest.net/

Zev Weiss (4):
  dt-bindings: serial: 8250: deprecate aspeed,sirq-polarity-sense
  drivers/tty/serial/8250: refactor sirq and lpc address setting code
  drivers/tty/serial/8250: add aspeed,lpc-address and aspeed,sirq DT
    properties
  dt-bindings: serial: 8250: add aspeed,lpc-address and aspeed,sirq

 .../devicetree/bindings/serial/8250.yaml      | 28 +++++-
 drivers/tty/serial/8250/8250_aspeed_vuart.c   | 95 +++++++++++++++----
 2 files changed, 103 insertions(+), 20 deletions(-)

-- 
2.31.1

