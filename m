From: Lei Yu <yulei.sh@bytedance.com>
Date: Fri, 16 Apr 2021 15:35:01 +0800
Subject: [External] Re: [PATCH v1] ARM: dts: Fix 64MiB OpenBMC flash
 layout and aspeed-ast2600-evb.dts
In-Reply-To: <CACPK8XeYtaLLWDMR8xZhERrQ_WCUJ2RM_JZmZNQ6oZSvgSDM_w@mail.gmail.com>
References: <20210316085932.2601-1-troy_lee@aspeedtech.com>
 <CACPK8XeYtaLLWDMR8xZhERrQ_WCUJ2RM_JZmZNQ6oZSvgSDM_w@mail.gmail.com>
Message-ID: <CAGm54UHgQSMh8WLzRf7Swhv9mmzNBuEK6eKf9eX0ASp95hjARw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 16, 2021 at 11:03 AM Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 16 Mar 2021 at 08:59, Troy Lee <troy_lee@aspeedtech.com> wrote:
> >
> > Aspeed AST2600 u-boot requires 600KiB+ flash space. Sharing the same
> > openbmc-flash-layout-64.dtsi requires to resize the flash partition.
> >
> > The updated flash layout as follows:
> > - u-boot: 896 KiB
> > - u-boot-env: 128 KiB
> > - kernel: 9MiB
> > - rofs: 32 MiB
> > - rwfs: 22 MiB
>
> Changing the 64MB layout will break the systems that are already using
> this layout. I'll get the Bytedance people to chime in, as theirs is
> the only system using this layout so far.
>
> John, Lei?

Because the kernel's offset is updated, several other changes are required:
1. The related offsets, which is already sent to
https://gerrit.openbmc-project.xyz/c/openbmc/meta-phosphor/+/39343
2. The u-boot patch to update the `bootm` address and make sure it
only applies to the 64MiB layout.

Without the above two changes, I would suggest holding the merge.

-- 
BRs,
Lei YU
