From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue,  8 Aug 2017 15:46:32 +0930
Subject: [RESEND PATCH 0/2] Fix clock name in Aspeed GPIO bindings and driver
Message-ID: <20170808061634.11857-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Resending to fix Ryan's email address. I think I'll step away from computers
now.

Hello,

Joel discovered I brain-farted the referenced clock name in the patches
introducing the debounce capability for the Aspeed driver. The datasheet says
PCLK but I wrote HPLL for whatever reason, so clean up that mistake by simply
removing references to HPLL and put the onus on the devicetree author to
get it right.

Cheers,

Andrew

Andrew Jeffery (2):
  dt-bindings: gpio: aspeed: Remove reference to clock name
  gpio: aspeed: Remove reference to clock name in debounce warning
    message

 Documentation/devicetree/bindings/gpio/gpio-aspeed.txt | 2 +-
 drivers/gpio/gpio-aspeed.c                             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.11.0

