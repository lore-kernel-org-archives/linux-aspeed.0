From: Olof Johansson <olof@lixom.net>
Date: Mon, 22 Jul 2019 13:23:04 -0700
Subject: [PATCH linux dev-5.2] ARM: dts: aspeed: swift: Fix FSI GPIOs
In-Reply-To: <20190719203037.11795-1-mspinler@linux.ibm.com>
References: <20190719203037.11795-1-mspinler@linux.ibm.com>
Message-ID: <CAOesGMhf984ic0O4zhNGo=SfrqDX2wDkYxyfga81JDXkUyciqw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 19, 2019 at 1:31 PM Matt Spinler <mspinler@linux.ibm.com> wrote:
>
> From: Matt Spinler <spinler@us.ibm.com>
>
> Change the FSI clock and data GPIOs to match what the hardware turned
> out to use.
>
> Signed-off-by: Matt Spinler <spinler@us.ibm.com>

Hi,

This is not a comment on this patch specifically, just an overall
request for people to adjust how they post patches:

When running get_maintainer.pl on
arch/arm/boot/dts/aspeed-bmc-opp-swift.dts, I get the following:

[...]
linux-arm-kernel at lists.infradead.org (moderated list:ARM/ASPEED MACHINE SUPPORT)
linux-aspeed at lists.ozlabs.org (moderated list:ARM/ASPEED MACHINE SUPPORT)
[...]

Please include both of them on patches. Lots of people aren't
subscribed to the aspeed-only mailing list, so coming back later to
reply to a patch is hard when it hasn't made it into your mailboxes.


Thanks!

-Olof
