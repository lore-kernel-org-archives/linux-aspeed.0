From: Joel Stanley <joel@jms.id.au>
Date: Fri, 8 May 2020 07:49:25 +0000
Subject: ARM: aspeed: devicetree changes for 5.8
Message-ID: <CACPK8Xd-=XFREvvS-mK_ECyn14y0GPAMyy5BpEEUYfaw4jAgsw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello ARM Maintainers,

Thanks to covid chaos there was no aspeed pull request for 5.7. We're
back for 5.8 though!

There's a patch in here that causes some build time warnings from the
device tree compiler. I've sent a patch for that to the dtc folk:

https://lore.kernel.org/lkml/20200508063904.60162-1-joel at jms.id.au/

The following changes since commit fa4c8ec6feaa3237f5d44cb8c6d0aa0dff6e1bcc:

  ARM: dts: aspeed: Change KCS nodes to v2 binding (2020-05-05 16:37:17 +0930)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-5.8-devicetree

for you to fetch changes up to fa4c8ec6feaa3237f5d44cb8c6d0aa0dff6e1bcc:

  ARM: dts: aspeed: Change KCS nodes to v2 binding (2020-05-05 16:37:17 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 5.8

New machines:

 - YADRO's ast2500 OpenPower P9 Nicole BMC
 - Facebook's ast2500 x86 Yosemite V2 BMC

The AST2600 machines Rainier and Tacoma were fleshed out.

Machines have started describing the GPIO names as userspace attempts
to use the GPIO chardev API.

----------------------------------------------------------------
