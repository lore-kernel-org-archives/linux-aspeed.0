From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 3 Dec 2019 08:47:40 -0600
Subject: [PATCH 00/14] ARM: dts: aspeed: Cleanup dtc warnings
In-Reply-To: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
Message-ID: <CAL_JsqLMs1MsNXMFTCVdrkNNx5ktg0_Q=zf6xgiTkeys-T+CNg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 3, 2019 at 6:02 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hello,
>
> This series is based on an RFC-ish series I sent quite some time ago to which I
> have only just been able to circle back. The previous discussion can be found
> here:
>
> https://lore.kernel.org/lkml/20190726053959.2003-1-andrew at aj.id.au/
>
> I've split, shuffled and rebased the series a little, with at least one extra
> cleanup for the g6 dtsi. This series is just the devicetree changes, the IPMI
> KCS changes will be posted separately shortly.
>
> Combined with the KCS changes we achieve similar stats to the RFC series,
> reducing 264 warnings to 6.
>
> I've added each patches' tags from last time, but please glance over them
> again.
>
> Cheers,
>
> Andrew
>
> Andrew Jeffery (14):
>   dt-bindings: pinctrl: aspeed: Add reg property as a hint
>   dt-bindings: misc: Document reg for aspeed,p2a-ctrl nodes
>   ARM: dts: aspeed-g5: Move EDAC node to APB
>   ARM: dts: aspeed-g5: Use recommended generic node name for SDMC
>   ARM: dts: aspeed-g5: Fix aspeed,external-nodes description
>   ARM: dts: vesnin: Add unit address for memory node
>   ARM: dts: fp5280g2: Cleanup gpio-keys-polled properties
>   ARM: dts: swift: Cleanup gpio-keys-polled properties
>   ARM: dts: witherspoon: Cleanup gpio-keys-polled properties
>   ARM: dts: aspeed: Cleanup lpc-ctrl and snoop regs
>   ARM: dts: aspeed: Add reg hints to syscon children
>   ARM: dts: aspeed-g5: Sort LPC child nodes by unit address
>   ARM: dts: aspeed-g6: Cleanup watchdog unit address
>   ARM: dts: ibm-power9-dual: Add a unit address for OCC nodes
>
>  Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt            |  1 +
>  Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml |  3 +++
>  Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml |  3 +++
>  arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts                  |  4 ----
>  arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts              |  4 ----
>  arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts                      | 11 +++++++----
>  arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts                        |  4 ----
>  arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts                          |  4 ----
>  arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts                          |  4 ----
>  arch/arm/boot/dts/aspeed-bmc-opp-swift.dts                            |  6 ------
>  arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts                           |  2 +-
>  arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts                      |  6 ------
>  arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts                            |  2 --
>  arch/arm/boot/dts/aspeed-g4.dtsi                                      | 21 ++++++++++++---------
>  arch/arm/boot/dts/aspeed-g5.dtsi                                      | 49 ++++++++++++++++++++++++++-----------------------
>  arch/arm/boot/dts/aspeed-g6.dtsi                                      |  2 +-
>  arch/arm/boot/dts/ibm-power9-dual.dtsi                                |  4 ++--
>  17 files changed, 56 insertions(+), 74 deletions(-)

Other than patch 5, for the series:

Reviewed-by: Rob Herring <robh@kernel.org>
