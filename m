From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed, 31 Mar 2021 19:56:59 -0500
Subject: [PATCH v2 0/3] simplify Aspeed VUART SIRQ polarity DT config
In-Reply-To: <YGOuhjD19SmjmQou@hatter.bewilderbeest.net>
References: <YGOuhjD19SmjmQou@hatter.bewilderbeest.net>
Message-ID: <20210401005702.28271-1-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The aspeed,sirq-polarity-sense property was a bit of a design mistake
in that it ties Aspeed VUART SIRQ polarity to SCU register bits that
aren't really inherently related to it.

This patch series deprecates that property (though we hope to
eventually remove it) and adds a simple boolean property
(aspeed,sirq-active-high) to use instead.


Changes since v1:
 - deprecate and retain aspeed,sirq-polarity-sense instead of removing it
 - drop e3c246d4i dts addition from this series


Zev Weiss (3):
  dt-bindings: serial: 8250: deprecate aspeed,sirq-polarity-sense
  drivers/tty/serial/8250: add DT property for aspeed vuart sirq
    polarity
  dt-bindings: serial: 8250: add aspeed,sirq-active-high

 Documentation/devicetree/bindings/serial/8250.yaml | 14 +++++++++++---
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |  3 +++
 2 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.31.1

