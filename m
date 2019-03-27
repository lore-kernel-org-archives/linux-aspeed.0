From: Joel Stanley <joel@jms.id.au>
Date: Wed, 27 Mar 2019 06:16:52 +0000
Subject: [PATCH] witherspoon.dts: Enable the USB vhub (device)
In-Reply-To: <1553610803-65797-1-git-send-email-anoo@linux.ibm.com>
References: <1553610803-65797-1-git-send-email-anoo@linux.ibm.com>
Message-ID: <CACPK8XfSPYxKJ6QJ6UkBEs69cH8E0COxk-BgcJbqfvsNsc4Tsg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Adriana,

On Tue, 26 Mar 2019 at 14:34, Adriana Kobylak <anoo@linux.ibm.com> wrote:
>
> The Aspeed vhub device driver is already enabled in
> the defconfig, make use of it in the witherspoon platform.
>
> Signed-off-by: Adriana Kobylak <anoo@linux.ibm.com>

The patch looks good. However it would be good if the commit message
would follow the style used by other patches. Next time, do a git log
of the file and see how others format their messages.'

$ git log --oneline arch/arm/boot/dts/aspeed-*
2b66ba56dca9 ARM: dts: aspeed: Add Power9 and Power9 CFAM description
82545da4069b ARM: dts: aspeed: Rename flash-controller nodes
58e953107de1 ARM: dts: palmetto: Fix flash_memory region
3b1433fac7ec ARM: dts: aspeed: tiogapass: Add sensors
36b64bb6dfa2 ARM: dts: aspeed: tiogapass: Enable KCS
7dd7e19bed04 ARM: dts: aspeed: Add KCS support for LPC BMC

I've applied the version of this patch that Eddie sent, so it should
be all good.

Cheers,

Joel
