From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 01 Oct 2020 10:12:30 +0930
Subject: [PATCH 4/4] pinctrl: aspeed-g5: Fix LPC register offsets
In-Reply-To: <CACRpkdbn9294JnddMsmGooCe7KCxMiGbuAZ+OAuLwPkZUYD10A@mail.gmail.com>
References: <20200911034631.8473-1-chiawei_wang@aspeedtech.com>
 <20200911034631.8473-5-chiawei_wang@aspeedtech.com>
 <CACRpkdbn9294JnddMsmGooCe7KCxMiGbuAZ+OAuLwPkZUYD10A@mail.gmail.com>
Message-ID: <3755eb41-e939-41b4-93ff-7bfcbdbc9f5b@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 29 Sep 2020, at 22:12, Linus Walleij wrote:
> On Fri, Sep 11, 2020 at 5:47 AM Chia-Wei, Wang
> <chiawei_wang@aspeedtech.com> wrote:
> 
> > The LPC register offsets are fixed to adapt to the LPC DTS change,
> > where the LPC partitioning is removed.
> >
> > Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> 
> I can apply this one patch if I get a review from one of the
> Aspeed pinctrl maintainer.
> 
> Andrew?

There needs to be a v2 of the series that fixes the binding documentation, 
which will drive some discussion about backwards compatibility. So lets not 
apply this patch just yet.

Thanks for touching base!

Andrew
