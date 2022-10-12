From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 12 Oct 2022 13:04:10 +0300
Subject: [rft, PATCH v2 00/36] pinctrl: Clean up and add missed headers
In-Reply-To: <0684f480-2092-d520-2c8e-bd9a2dca47e3@gmail.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com> <0684f480-2092-d520-2c8e-bd9a2dca47e3@gmail.com>
Message-ID: <CAHp75VdDjyUAZBTaoPOe5oA3f_5xRznAooq08=Eff4F1AZyVOQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 11, 2022 at 11:56 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 10/10/2022 1:14 PM, Andy Shevchenko wrote:
> > Currently the header inclusion inside the pinctrl headers seems more arbitrary
> > than logical. This series is basically out of two parts:
> > - add missed headers to the pin control drivers / users
> > - clean up the headers of pin control subsystem
> >
> > The idea is to have this series to be pulled after -rc1 by the GPIO and
> > pin control subsystems, so all new drivers will utilize cleaned up headers
> > of the pin control.
> >
> > Please, review and comment.
>
> Did you really need to split this on a per-driver basis as opposed to
> just a treewide drivers/pinctrl, drivers/media and drivers/gpiolib patch
> set?
>
> 36 patches seems needlessly high when 4 patches could have achieve the
> same outcome.

I can combine them if maintainers ask for that, nevertheless for Intel
pin control and GPIO drivers, which I care more about, I would like to
leave as separate changes (easy to see in history what was done).


-- 
With Best Regards,
Andy Shevchenko
