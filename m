From: Olof Johansson <olof@lixom.net>
Date: Tue, 11 Dec 2018 08:01:21 -0800
Subject: [GIT PULL] ARM: aspeed: dts changes for 4.21
In-Reply-To: <CACPK8XcioxMDmJpKxdA7xfSmvEy++LUtELGOxRaoBFB0cT0RSA@mail.gmail.com>
References: <CACPK8XcioxMDmJpKxdA7xfSmvEy++LUtELGOxRaoBFB0cT0RSA@mail.gmail.com>
Message-ID: <20181211160121.tngbngmi2iowoipr@localhost>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 05, 2018 at 10:21:08AM +1030, Joel Stanley wrote:
> Hello ARM maintainers,
> 
> Here's the ASPEED pull request. A new system from Facebook and some
> small updates that were being carried in the OpenBMC kernel tree.
> Thanks!
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
>     tags/aspeed-4.21-devicetree

Thanks for adding the '\' here! Makes our lives ever so slightly easier
when copying and pasting the line-wrapped refspec.

> 
> for you to fetch changes up to 76d0bbd8a4ef1b1256d49e082a61a33eb0b004c7:
> 
>   ARM: dts: aspeed: Add Facebook Backpack-CMM BMC (2018-12-03 09:17:15 +1030)
> 
> ----------------------------------------------------------------
> ASPEED device tree updates for 4.20
> 
>  - New machine: Facebook Backpack-CMM BMC and flash layout
> 
>  - OpenPower reference systems (Palmetto P8, Romulus P9) move to the
>    ColdFire based FSI driver
> 
>  - Misc device tree updates from the OpenBMC project
> 
> ----------------------------------------------------------------
> Benjamin Herrenschmidt (2):
>       ARM: dts: aspeed: Romulus system can use coprocessor for FSI
>       ARM: dts: aspeed: Palmetto system can use coprocessor for FSI
> 
> Joel Stanley (2):
>       ARM: dts: aspeed-palmetto: Add LPC control node
>       ARM: dts: aspeed: Enable VHUB on Romulus
> 
> Lei YU (1):
>       ARM: dts: aspeed: romulus: Enable iio-hwmon-battery
> 
> Matt Spinler (1):
>       ARM: dts: aspeed: wspoon: Enable iio-hwmon battery
> 
> Tao Ren (2):
>       ARM: dts: Add Facebook BMC flash layout

Should this have been in the an aspeed namespace? Seems quite platform
dependent to me. Doesn't matter all that much with the proposed move into
subdirectories that Rob is staging; this file would go under aspeed in that
case.

Merged into next/dt.

-Olof
