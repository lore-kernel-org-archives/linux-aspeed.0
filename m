From: Tomer Maimon <tmaimon77@gmail.com>
Date: Thu, 13 Jun 2019 12:26:42 +0300
Subject: [PATCH v1 2/2] soc: nuvoton: add NPCM LPC BPC driver
In-Reply-To: <CAK8P3a0s1fdt2yHVjOXffeKPKkwUyJ7DKCZHHMKjx+3j300ZAQ@mail.gmail.com>
References: <20190610133245.306812-1-tmaimon77@gmail.com>
 <20190610133245.306812-3-tmaimon77@gmail.com>
 <CAK8P3a0s1fdt2yHVjOXffeKPKkwUyJ7DKCZHHMKjx+3j300ZAQ@mail.gmail.com>
Message-ID: <CAP6Zq1jZEUzbB-ZidF2SD24k8iC_uBkXZ9WbtPpOYNCRjRTz3g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Adding Patrick and Joel to this discussion,

Thanks for your prompt reply!

On Tue, 11 Jun 2019 at 16:12, Arnd Bergmann <arnd@arndb.de> wrote:

> On Mon, Jun 10, 2019 at 4:19 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
> >
> > Add Nuvoton BMC NPCM BIOS post code (BPC) driver.
> >
> > The NPCM BPC monitoring two I/O address written by
> > the host on the Low Pin Count (LPC) bus, the capure
> > data stored in 128-word FIFO.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>
> We've run into this situation before, but don't have a good solution yet:
>
> The driver seems useful and well implemented, but I keep having a bad
> feeling about adding a chardev driver into drivers/soc for something that
> is clearly specific to a particular implementation on the hardware side
> but generic on the user interface. The same user interface might be
> used on an Aspeed BMC or any other one, so please coordinate at
> least between Novoton and Aspeed developers on creating a common
> user interface, and review each other's patches.
>

Probably the only vendors that will use the snoop will be Nuvoton and
Aspeed.
is it worth to create new snoop common user interface for it,
if we will develop a new snoop user interface who will be the maintainer?


> Maybe we can introduce a drivers/bmc/ (or even drivers/openbmc)
>
that collects all those user interfaces with a thin abstraction layer
> and one or two hardware specific back-ends?
>

Sounds good, Maybe we can move the KCS BMC from driver/char/ipmi to the
drivers/bmc/?


>         Arnd
>

appreciate your opinions, Joel, Andrew and Patrick?

Thanks,

Tomer
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190613/c3423b07/attachment.htm>
