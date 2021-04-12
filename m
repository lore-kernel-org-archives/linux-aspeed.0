From: Zev Weiss <zev@bewilderbeest.net>
Date: Sun, 11 Apr 2021 22:47:08 -0500
Subject: [PATCH v6 0/4] serial: 8250_aspeed_vuart: generalized DT properties
Message-ID: <20210412034712.16778-1-zev@bewilderbeest.net>
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

The rest of the series adds two new properties, aspeed,lpc-io-reg and
aspeed,lpc-interrupts.  The latter allows describing the SIRQ polarity
(along with the interrupt number) directly, providing a simpler
replacement for aspeed,sirq-polarity-sense.

Changes since v5 [4]:
 - corrected stale DT property name in commit message
 - factored aspeed_vuart_map_irq_polarity() out of
   aspeed_vuart_probe()
 - fixed commit message subject line prefixes

Changes since v4 [3]:
 - fixed commit reference formatting in commit message

Changes since v3 [2]:
 - renamed properties to match aspeed,ast2400-kcs-bmc

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
[2] https://lore.kernel.org/openbmc/20210402004716.15961-1-zev at bewilderbeest.net/
[3] https://lore.kernel.org/openbmc/20210402182724.20848-1-zev at bewilderbeest.net/
[4] https://lore.kernel.org/openbmc/20210408011637.5361-1-zev at bewilderbeest.net/


Zev Weiss (4):
  dt-bindings: serial: 8250: deprecate aspeed,sirq-polarity-sense
  serial: 8250_aspeed_vuart: refactor sirq and lpc address setting code
  serial: 8250_aspeed_vuart: add aspeed,lpc-io-reg and
    aspeed,lpc-interrupts DT properties
  dt-bindings: serial: 8250: add aspeed,lpc-io-reg and
    aspeed,lpc-interrupts

 .../devicetree/bindings/serial/8250.yaml      |  28 ++++-
 drivers/tty/serial/8250/8250_aspeed_vuart.c   | 102 ++++++++++++++----
 2 files changed, 109 insertions(+), 21 deletions(-)

-- 
2.31.1

