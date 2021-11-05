From: Oskar Senft <osk@google.com>
Date: Thu, 4 Nov 2021 21:46:57 -0400
Subject: [PATCH v2] ARM: dts: aspeed: tyan-s7106: Update nct7802 config
In-Reply-To: <CACPK8XcXR=V5-Q+sC4MniNJZJgvbiysFD-5yu6v30_2BwDRTSA@mail.gmail.com>
References: <20211105005955.107419-1-osk@google.com>
 <CACPK8XcXR=V5-Q+sC4MniNJZJgvbiysFD-5yu6v30_2BwDRTSA@mail.gmail.com>
Message-ID: <CABoTLcS=s0XuM9jiisYW3=1gXtiwP8WeopqTOeBwnTX1XCky9Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel

Oh man, this is embarrassing!

> I applied this and tried comple testing, and got this warning:
>
>   DTC     arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dtb
> ../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:217.4-14: Warning
> (reg_format): /ahb/apb/bus at 1e78a000/i2c-bus at 40/nct7802 at 28/channel at 0:reg:
> property has invalid length (4 bytes) (#address-cells == 2,
> #size-cells == 1)
> [...]
> You need to add this to the nct node:
>
> #address-cells = <1>;
> #size-cells = <0>;
Oh yeah, of course. It's even in the example in the binding that I wrote.

> Did you see this with your testing? I'm building on top of v5.15 and
> my distro's dtc is 1.6.0.
I built (as part of OpenBMC) and ran (on actual HW), but these
warnings don't make it out to the console. In my "defense", I did run
checkpatch.pl, though.

Is there an easy way for me to see these types of warnings? Or should
they really come out as errors?

I'll fix and send a PATCH v3.

I'm really sorry, this shouldn't be so much work for you!

Oskar.
