From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue,  3 Dec 2019 23:08:22 +1030
Subject: [PATCH 0/3] ipmi: kcs-bmc: Rework bindings to clean up DT warnings
Message-ID: <cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This is a short series reworking the devicetree binding and driver for the
ASPEED BMC KCS devices. With the number of supported ASPEED BMC devicetrees the
changes enable removal of more than 100 lines of warning output from dtc.

These changes are extracted from an RFC series posted previously, which can be
found here:

https://lore.kernel.org/lkml/20190726053959.2003-1-andrew at aj.id.au/

Haiyue has already reviewed the driver patches in that thread so the re-posting
carries his tags. Since the original series the patches have been rebased on
top of char-misc/master with no further changes. However, please take a look to
make sure the patches are still sane.

Cheers,

Andrew

Andrew Jeffery (3):
  dt-bindings: ipmi: aspeed: Introduce a v2 binding for KCS
  ipmi: kcs: Finish configuring ASPEED KCS device before enable
  ipmi: kcs: aspeed: Implement v2 bindings

 Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt |  20 +-
 drivers/char/ipmi/kcs_bmc_aspeed.c                        | 151 +++++--
 2 files changed, 139 insertions(+), 32 deletions(-)

base-commit: 937d6eefc716a9071f0e3bada19200de1bb9d048
-- 
git-series 0.9.1
