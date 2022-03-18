From: Joel Stanley <joel@jms.id.au>
Date: Fri, 18 Mar 2022 07:16:00 +0000
Subject: [PATCH v2 2/2] ARM: soc: aspeed: Add secure boot controller
 support
In-Reply-To: <CAK8P3a0LKG25Zu1X0m0FmSXpbC6YmWcvyhW1MOcw4XgnazS4sw@mail.gmail.com>
References: <20220310000629.119699-1-joel@jms.id.au>
 <20220310000629.119699-3-joel@jms.id.au>
 <CAK8P3a0LKG25Zu1X0m0FmSXpbC6YmWcvyhW1MOcw4XgnazS4sw@mail.gmail.com>
Message-ID: <CACPK8XdunkxWx-Lb=9Gi7WnNfRyVtrsdPMnasNv1sBtZRxOmfw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Mar 2022 at 08:03, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Mar 10, 2022 at 1:06 AM Joel Stanley <joel@jms.id.au> wrote:
> >
> > This reads out the status of the secure boot controller and exposes it
> > in debugfs.
> >
> > An example on a AST2600A3 QEMU model:
> >
> >  # grep -r . /sys/kernel/debug/aspeed/*
> >  /sys/kernel/debug/aspeed/sbc/abr_image:0
> >  /sys/kernel/debug/aspeed/sbc/low_security_key:0
> >  /sys/kernel/debug/aspeed/sbc/otp_protected:0
> >  /sys/kernel/debug/aspeed/sbc/secure_boot:1
> >  /sys/kernel/debug/aspeed/sbc/uart_boot:0
> >
> > On boot the state of the system according to the secure boot controller
> > will be printed:
> >
> >  [    0.037634] AST2600 secure boot enabled
> >
> > or
> >
> >  [    0.037935] AST2600 secure boot disabled
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > v2:
> >   - Place files in aspeed/sbc
> >   - Check for error when creating directory
> >   - Print secure boot message even if debugfs is disabled
>
> The implementation looks fine to me, but I think the changelog needs to
> explain why you picked debugfs over a sysfs interface, and how the
> interface is going to be used.
>
> As a rule, sysfs interfaces need to be documented and kept stable
> so that user space can rely on it, while debugfs interfaces should only
> be used for development and never be accessed by applications
> that need to work across kernel versions. If no stable user space
> is allowed to access these files, what is accessing them?

I hear what you're saying, but we're now going around in circles. The
first proposal added a soc-specific sysfs interface, which was
rejected in favor of creating a common interface. The common interface
didn't get any support, and with the feedback being the files were too
soc-specific. You rightly point out that the debugfs API is not
supposed to be relied on as a stable userspace API.

Do you think we should revisit the soc-specific sysfs?

The userspace that accesses the files comes in two forms: a runtime
application that checks the system state, and some manufacturing line
scripts that checks if the machine was correctly provisioned. The
application source can be viewed here:

 https://gerrit.openbmc-project.xyz/c/openbmc/phosphor-state-manager/+/51766

The discussion has lost momentum for me, as in practice we needed to
ship the hardware, so the openbmc kernel will support the version of
the patches that were merged there for the lifetime of the product.
This isn't a threat, but an observation that the mainline kernel
process has failed in this instance, despite the best intentions of
everyone involved.

Cheers,

Joel
