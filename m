From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 22 Oct 2020 12:17:25 +1030
Subject: [PATCH v2 0/6] ARM: dts: Enable ramoops for Rainier and Tacoma
Message-ID: <20201022014731.2035438-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

We're looking to improve our crash data capture for the BMC on some IBM
platforms. This small series enables ramoops for Rainier and Tacoma.

v2 fixes an address overlap bug for Tacoma in v1, which was caused by a node vs
reg mismatch of one of the other reserved memory regions. v2 contains a several
cosmetic cleanups for both the Tacoma and Rainier reserved memory regions
before enabling ramoops in the final two patches. The geometry of the rings has
changed from v1; the slot sizes have been doubled, reducing the captured crash
count from 32 to 16 (32 seemed like overkill and we could trade that for more
space in each slot).

v1 can be found here:

https://lore.kernel.org/linux-arm-kernel/20201016043513.119841-1-andrew at aj.id.au/

Please review.

Andrew

Andrew Jeffery (6):
  ARM: dts: tacoma: Fix node vs reg mismatch for flash memory
  ARM: dts: tacoma: Zero-pad flash memory region length
  ARM: dts: rainier,tacoma: Fix size comment whitespace
  ARM: dts: rainier,tacoma: Comment reserved memory regions
  ARM: dts: rainier: Add reserved memory for ramoops
  ARM: dts: tacoma: Add reserved memory for ramoops

 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 15 ++++++++++++++-
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts  | 19 ++++++++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.25.1

