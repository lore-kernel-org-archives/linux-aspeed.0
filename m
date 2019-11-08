From: Olof Johansson <olof@lixom.net>
Date: Fri, 8 Nov 2019 10:31:24 -0800
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 5.5
In-Reply-To: <CACPK8Xe8XiJ+oEp3_AXO5Mox-mXWVrOJKQLJMKJxg1WdYCTzMw@mail.gmail.com>
References: <CACPK8Xe8XiJ+oEp3_AXO5Mox-mXWVrOJKQLJMKJxg1WdYCTzMw@mail.gmail.com>
Message-ID: <20191108183124.r2wdql4rmdbzx2up@localhost>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,


On Thu, Nov 07, 2019 at 11:18:10AM +0000, Joel Stanley wrote:
> Hello ARM maintainers,
> 
> Here's the ASPEED dts tree for 5.5.
> 
> The following changes since commit 3eca037f2dfce07a31da0a837ac35d6d846614b0:
> 
>   ARM: dts: aspeed-g6: Add timer description (2019-11-07 21:23:56 +1030)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
>     tags/aspeed-5.5-devicetree

This is a weird format. Mind changing your script to not put the '\' at EOL?
It's messing up the parsing scripts, and git doesn't use it.

> for you to fetch changes up to 3eca037f2dfce07a31da0a837ac35d6d846614b0:
> 
>   ARM: dts: aspeed-g6: Add timer description (2019-11-07 21:23:56 +1030)
> 
> ----------------------------------------------------------------
> ASPEED device tree updates for 5.5
> 
>  - Lots of work on the AST2600 boards as bringup continues. There's the
>  eval board, and two IBM boards called Tacoma and Rainier
> 
>  - A new flash layout for OpenBMC systems with larger flashes
> 
>  - Better support for the MAC clocking when talking to a NCSI device,
>  making Linux less reliant on u-boot having done the correct thing
> 
>  - LED fixes for vesin and fp5280g2
> 
>  - SGPIO support
> 
>  - Facebook network BMC cleanup with the common hardware moved to a
>  shared dtsi
> 
> ----------------------------------------------------------------

... also, there's no shortlog and no diffstat on the pull request. We usually
want to see those.


That being said, I merged this branch. Thanks!


-Olof
