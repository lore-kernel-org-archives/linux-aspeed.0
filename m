From: Oskar Senft <osk@google.com>
Date: Thu, 4 Nov 2021 21:55:39 -0400
Subject: [PATCH v2] ARM: dts: aspeed: tyan-s7106: Update nct7802 config
In-Reply-To: <CABoTLcS=s0XuM9jiisYW3=1gXtiwP8WeopqTOeBwnTX1XCky9Q@mail.gmail.com>
References: <20211105005955.107419-1-osk@google.com>
 <CACPK8XcXR=V5-Q+sC4MniNJZJgvbiysFD-5yu6v30_2BwDRTSA@mail.gmail.com>
 <CABoTLcS=s0XuM9jiisYW3=1gXtiwP8WeopqTOeBwnTX1XCky9Q@mail.gmail.com>
Message-ID: <CABoTLcRyc0B5HXSzEusPKWOwO+BG6GfSmmv0miDd6Y4rRCYTiw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

To answer my own question and as a reminder for myself ...

> > I applied this and tried comple testing, and got this warning:
> >
> >   DTC     arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dtb
> > ../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:217.4-14: Warning
> > (reg_format): /ahb/apb/bus at 1e78a000/i2c-bus at 40/nct7802 at 28/channel at 0:reg:
> > property has invalid length (4 bytes) (#address-cells == 2,
> > #size-cells == 1)
> Is there an easy way for me to see these types of warnings? Or should
> they really come out as errors?

Yes, there is:

1) Copy the .config from the OpenBMC build directory:
cp ~/src/openbmc/build/s7106/tmp/work/s7106-openbmc-linux-gnueabi/linux-aspeed/5.15+gitAUTOINC+da6376d789-r0/linux-s7106-standard-build/.config
.

2) Run
ARCH="arm" make aspeed-bmc-tyan-s7106.dtb


Oskar.
