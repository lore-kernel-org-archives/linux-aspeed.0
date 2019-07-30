From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 29 Jul 2019 18:53:11 -0600
Subject: [RFC-ish PATCH 00/17] Clean up ASPEED devicetree warnings
In-Reply-To: <20190726053959.2003-1-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
Message-ID: <CAL_JsqJ+sFDG8eKbV3gvmqVHx+otWbki4dY213apzXgfhbXXEw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 25, 2019 at 11:40 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hello,
>
> The aim of this series is to minimise/eliminate all the warnings from the
> ASPEED devicetrees. It mostly achieves its goal, as outlined below.
>
> Using `aspeed_g5_defconfig` we started with the follow warning count:
>
>     $ make dtbs 2>&1 >/dev/null | wc -l
>     218
>
> and after the full series is applied we have:
>
>     $ make dtbs 2>&1 >/dev/null | wc -l
>     2
>
> for a 100x reduction.
>
> Getting there though isn't without some potential controversy, which I've saved
> for the last half of the series. The following patches I think are in pretty
> good shape:
>
>   ARM: dts: aspeed-g5: Move EDAC node to APB
>   ARM: dts: aspeed-g5: Use recommended generic node name for SDMC
>   ARM: dts: aspeed-g5: Fix aspeed,external-nodes description
>   ARM: dts: vesnin: Add unit address for memory node
>   ARM: dts: fp5280g2: Cleanup gpio-keys-polled properties
>   ARM: dts: swift: Cleanup gpio-keys-polled properties
>   ARM: dts: witherspoon: Cleanup gpio-keys-polled properties
>   ARM: dts: aspeed: Cleanup lpc-ctrl and snoop regs
>   ARM: dts: ibm-power9-dual: Add a unit address for OCC nodes
>
> With these patches applied we get to:
>
>     $ make dtbs 2>&1 >/dev/null | wc -l
>     144
>
> So they make a dent, but fail to clean up the bulk of the issues. From here
> I've mixed in some binding and driver changes with subsequent updates to the
> devicetrees:
>
>   dt-bindings: pinctrl: aspeed: Add reg property as a hint
>   dt-bindings: misc: Document reg for aspeed,p2a-ctrl nodes
>   ARM: dts: aspeed: Add reg hints to syscon children
>   dt-bindings: ipmi: aspeed: Introduce a v2 binding for KCS
>   ipmi: kcs: Finish configuring ASPEED KCS device before enable
>   ipmi: kcs: aspeed: Implement v2 bindings
>   ARM: dts: aspeed-g5: Change KCS nodes to v2 binding
>   ARM: dts: aspeed-g5: Sort LPC child nodes by unit address
>
> By `dt-bindings: ipmi: aspeed: Introduce a v2 binding for KCS` the warnings are
> reduced to:
>
>     $ make dtbs 2>&1 >/dev/null | wc -l
>     125
>
> The bang-for-buck is in fixing up the KCS bindings which removes all-but-two of
> the remaining warnings (which we can't feasibly remove), but doing so forces
> code changes (which I'd avoided up until this point).
>
> Reflecting broadly on the fixes, I think I've made a mistake way back by using
> syscon/simple-mfds to expose the innards of the SCU and LPC controllers in the
> devicetree. This series cleans up what's currently there, but I have half a
> mind to rev the SCU and LPC bindings to not use simple-mfd and instead have a
> driver implementation that uses `platform_device_register_full()` or similar to
> deal with the mess.
>
> Rob - I'm looking for your thoughts here and on the series, I've never felt
> entirely comfortable with what I cooked up. Your advice would be appreciated.

The series generally looks fine to me from a quick scan. As far as
dropping 'simple-mfd', having less fine grained description in DT is
generally my preference. It comes down to whether what you have
defined is maintainable. As most of it is just additions, I think what
you have is fine. Maybe keep all this in mind for the next chip
depending how the SCU and LPC change.

Rob
