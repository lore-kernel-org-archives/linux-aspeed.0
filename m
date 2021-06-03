From: Joel Stanley <joel@jms.id.au>
Date: Thu, 3 Jun 2021 06:02:07 +0000
Subject: [External] Re: [PATCH v1] ARM: dts: Fix 64MiB OpenBMC flash
 layout and aspeed-ast2600-evb.dts
In-Reply-To: <CAGm54UHgQSMh8WLzRf7Swhv9mmzNBuEK6eKf9eX0ASp95hjARw@mail.gmail.com>
References: <20210316085932.2601-1-troy_lee@aspeedtech.com>
 <CACPK8XeYtaLLWDMR8xZhERrQ_WCUJ2RM_JZmZNQ6oZSvgSDM_w@mail.gmail.com>
 <CAGm54UHgQSMh8WLzRf7Swhv9mmzNBuEK6eKf9eX0ASp95hjARw@mail.gmail.com>
Message-ID: <CACPK8XdgLP7XSH0Zkej87ynnKTbEUW+RUBiSMgDH1H-LD5VXhg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 16 Apr 2021 at 07:35, Lei Yu <yulei.sh@bytedance.com> wrote:
>
> On Fri, Apr 16, 2021 at 11:03 AM Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Tue, 16 Mar 2021 at 08:59, Troy Lee <troy_lee@aspeedtech.com> wrote:
> > >
> > > Aspeed AST2600 u-boot requires 600KiB+ flash space. Sharing the same
> > > openbmc-flash-layout-64.dtsi requires to resize the flash partition.
> > >
> > > The updated flash layout as follows:
> > > - u-boot: 896 KiB
> > > - u-boot-env: 128 KiB
> > > - kernel: 9MiB
> > > - rofs: 32 MiB
> > > - rwfs: 22 MiB
> >
> > Changing the 64MB layout will break the systems that are already using
> > this layout. I'll get the Bytedance people to chime in, as theirs is
> > the only system using this layout so far.
> >
> > John, Lei?
>
> Because the kernel's offset is updated, several other changes are required:
> 1. The related offsets, which is already sent to
> https://gerrit.openbmc-project.xyz/c/openbmc/meta-phosphor/+/39343
> 2. The u-boot patch to update the `bootm` address and make sure it
> only applies to the 64MiB layout.
>
> Without the above two changes, I would suggest holding the merge.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Just confirming that we are okay to go ahead with this change, as per
the discussion on the openbmc list[1].

[1] https://lore.kernel.org/openbmc/CACPK8XdVNXSfzDBPryjQh_4S0yU4Tp6VOOtju+L_DcfgHumPJw at mail.gmail.com/

Cheers,

Joel
