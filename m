From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 11 Oct 2022 10:58:19 +0300
Subject: [PATCH v2 12/36] pinctrl: k210: Add missed header(s)
In-Reply-To: <4630d457-2d3b-6f66-7be5-54c84bdf80b4@wdc.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-13-andriy.shevchenko@linux.intel.com> <4630d457-2d3b-6f66-7be5-54c84bdf80b4@wdc.com>
Message-ID: <CAHp75VcghxT6nS1kLjYbj5N3EBj2CukJ3zGKvFSb-Z1paj3-ZQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 11, 2022 at 1:33 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
> On 2022/10/11 5:15, Andy Shevchenko wrote:
> > Do not imply that some of the generic headers may be always included.
> > Instead, include explicitly what we are direct user of.
> >
> > While at it, sort headers alphabetically.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Looks OK to me, but the patch title should be:
>
> pinctrl: k210: Add missing header(s)
>
> Same remark for the entire series. You need s/missed/missing in all patch titles.

Oh, the missing word 'missing' :-) I will replace it locally (I won't
resend it because of that).

> With that fixed,
>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko
