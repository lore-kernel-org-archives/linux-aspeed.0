From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 26 Jul 2019 15:09:42 +0930
Subject: [RFC-ish PATCH 00/17] Clean up ASPEED devicetree warnings
Message-ID: <20190726053959.2003-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

The aim of this series is to minimise/eliminate all the warnings from the
ASPEED devicetrees. It mostly achieves its goal, as outlined below.

Using `aspeed_g5_defconfig` we started with the follow warning count:

    $ make dtbs 2>&1 >/dev/null | wc -l
    218

and after the full series is applied we have:

    $ make dtbs 2>&1 >/dev/null | wc -l
    2

for a 100x reduction.

Getting there though isn't without some potential controversy, which I've saved
for the last half of the series. The following patches I think are in pretty
good shape:

  ARM: dts: aspeed-g5: Move EDAC node to APB
  ARM: dts: aspeed-g5: Use recommended generic node name for SDMC
  ARM: dts: aspeed-g5: Fix aspeed,external-nodes description
  ARM: dts: vesnin: Add unit address for memory node
  ARM: dts: fp5280g2: Cleanup gpio-keys-polled properties
  ARM: dts: swift: Cleanup gpio-keys-polled properties
  ARM: dts: witherspoon: Cleanup gpio-keys-polled properties
  ARM: dts: aspeed: Cleanup lpc-ctrl and snoop regs
  ARM: dts: ibm-power9-dual: Add a unit address for OCC nodes

With these patches applied we get to:

    $ make dtbs 2>&1 >/dev/null | wc -l
    144

So they make a dent, but fail to clean up the bulk of the issues. From here
I've mixed in some binding and driver changes with subsequent updates to the
devicetrees:

  dt-bindings: pinctrl: aspeed: Add reg property as a hint
  dt-bindings: misc: Document reg for aspeed,p2a-ctrl nodes
  ARM: dts: aspeed: Add reg hints to syscon children
  dt-bindings: ipmi: aspeed: Introduce a v2 binding for KCS
  ipmi: kcs: Finish configuring ASPEED KCS device before enable
  ipmi: kcs: aspeed: Implement v2 bindings
  ARM: dts: aspeed-g5: Change KCS nodes to v2 binding
  ARM: dts: aspeed-g5: Sort LPC child nodes by unit address

By `dt-bindings: ipmi: aspeed: Introduce a v2 binding for KCS` the warnings are
reduced to:

    $ make dtbs 2>&1 >/dev/null | wc -l
    125

The bang-for-buck is in fixing up the KCS bindings which removes all-but-two of
the remaining warnings (which we can't feasibly remove), but doing so forces
code changes (which I'd avoided up until this point).

Reflecting broadly on the fixes, I think I've made a mistake way back by using
syscon/simple-mfds to expose the innards of the SCU and LPC controllers in the
devicetree. This series cleans up what's currently there, but I have half a
mind to rev the SCU and LPC bindings to not use simple-mfd and instead have a
driver implementation that uses `platform_device_register_full()` or similar to
deal with the mess.

Rob - I'm looking for your thoughts here and on the series, I've never felt
entirely comfortable with what I cooked up. Your advice would be appreciated.

Anyway, everyone, please let me know your thoughts on the bits relevant to you.
If we can agree on a way forward I'll split up the series for subsequent
submissions so it isn't such a spam-fest.

Cheers,

Andrew

Andrew Jeffery (17):
  ARM: dts: aspeed-g5: Move EDAC node to APB
  ARM: dts: aspeed-g5: Use recommended generic node name for SDMC
  ARM: dts: aspeed-g5: Fix aspeed,external-nodes description
  ARM: dts: vesnin: Add unit address for memory node
  ARM: dts: fp5280g2: Cleanup gpio-keys-polled properties
  ARM: dts: swift: Cleanup gpio-keys-polled properties
  ARM: dts: witherspoon: Cleanup gpio-keys-polled properties
  ARM: dts: aspeed: Cleanup lpc-ctrl and snoop regs
  ARM: dts: ibm-power9-dual: Add a unit address for OCC nodes
  dt-bindings: pinctrl: aspeed: Add reg property as a hint
  dt-bindings: misc: Document reg for aspeed,p2a-ctrl nodes
  ARM: dts: aspeed: Add reg hints to syscon children
  dt-bindings: ipmi: aspeed: Introduce a v2 binding for KCS
  ipmi: kcs: Finish configuring ASPEED KCS device before enable
  ipmi: kcs: aspeed: Implement v2 bindings
  ARM: dts: aspeed-g5: Change KCS nodes to v2 binding
  ARM: dts: aspeed-g5: Sort LPC child nodes by unit address

 .../bindings/ipmi/aspeed-kcs-bmc.txt          |  20 ++-
 .../bindings/misc/aspeed-p2a-ctrl.txt         |   1 +
 .../pinctrl/aspeed,ast2400-pinctrl.yaml       |   3 +
 .../pinctrl/aspeed,ast2500-pinctrl.yaml       |   3 +
 .../dts/aspeed-bmc-arm-centriq2400-rep.dts    |   4 -
 .../aspeed-bmc-arm-stardragon4800-rep2.dts    |   4 -
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts |   4 -
 .../arm/boot/dts/aspeed-bmc-facebook-yamp.dts |   4 -
 .../boot/dts/aspeed-bmc-inspur-fp5280g2.dts   |   6 -
 .../arm/boot/dts/aspeed-bmc-intel-s2600wf.dts |   4 -
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts  |   4 -
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  |   4 -
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts    |   6 -
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts   |   2 +-
 .../boot/dts/aspeed-bmc-opp-witherspoon.dts   |   6 -
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts    |   2 -
 arch/arm/boot/dts/aspeed-g4.dtsi              |  21 ++-
 arch/arm/boot/dts/aspeed-g5.dtsi              |  73 ++++----
 arch/arm/boot/dts/ibm-power9-dual.dtsi        |   4 +-
 drivers/char/ipmi/kcs_bmc_aspeed.c            | 163 ++++++++++++++----
 20 files changed, 205 insertions(+), 133 deletions(-)

-- 
2.20.1

