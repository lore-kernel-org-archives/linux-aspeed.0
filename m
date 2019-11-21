From: Joel Stanley <joel@jms.id.au>
Date: Thu, 21 Nov 2019 02:52:39 +0000
Subject: [PATCH] aspeed: fix snoop_file_poll()'s return type
In-Reply-To: <787e54c2-2fe3-4afc-a69b-94771726194b@www.fastmail.com>
References: <20191120000647.30551-1-luc.vanoostenryck@gmail.com>
 <787e54c2-2fe3-4afc-a69b-94771726194b@www.fastmail.com>
Message-ID: <CACPK8XfO=F-BtCuDqyQODJv=6joYmyFiQ5eOYC5YuDJhcLSJtw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2019 at 05:42, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> On Wed, 20 Nov 2019, at 10:36, Luc Van Oostenryck wrote:
> > snoop_file_poll() is defined as returning 'unsigned int' but the
> > .poll method is declared as returning '__poll_t', a bitwise type.
> >
> > Fix this by using the proper return type and using the EPOLL
> > constants instead of the POLL ones, as required for __poll_t.
> >
> > CC: Joel Stanley <joel@jms.id.au>
> > CC: Andrew Jeffery <andrew@aj.id.au>
> > CC: linux-aspeed at lists.ozlabs.org
> > CC: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > index 48f7ac238861..f3d8d53ab84d 100644
> > --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > @@ -97,13 +97,13 @@ static ssize_t snoop_file_read(struct file *file,
> > char __user *buffer,
> >       return ret ? ret : copied;
> >  }
> >
> > -static unsigned int snoop_file_poll(struct file *file,
> > +static __poll_t snoop_file_poll(struct file *file,
> >                                   struct poll_table_struct *pt)
> >  {
> >       struct aspeed_lpc_snoop_channel *chan = snoop_file_to_chan(file);
> >
> >       poll_wait(file, &chan->wq, pt);
> > -     return !kfifo_is_empty(&chan->fifo) ? POLLIN : 0;
> > +     return !kfifo_is_empty(&chan->fifo) ? EPOLLIN : 0;
>
> Looks fine to me as POLLIN and EPOLLIN evaluate to the same value despite
> the type difference.

I assume Luc was using sparse to check:

CHECK   ../drivers/soc/aspeed/aspeed-lpc-snoop.c
../drivers/soc/aspeed/aspeed-lpc-snoop.c:112:19: warning: incorrect
type in initializer (different base types)
../drivers/soc/aspeed/aspeed-lpc-snoop.c:112:19:    expected
restricted __poll_t ( *poll )( ... )
../drivers/soc/aspeed/aspeed-lpc-snoop.c:112:19:    got unsigned int (
* )( ... )

If you fix the return type:

  CHECK   ../drivers/soc/aspeed/aspeed-lpc-snoop.c
../drivers/soc/aspeed/aspeed-lpc-snoop.c:106:45: warning: incorrect
type in return expression (different base types)
../drivers/soc/aspeed/aspeed-lpc-snoop.c:106:45:    expected restricted __poll_t
../drivers/soc/aspeed/aspeed-lpc-snoop.c:106:45:    got int

Reviewed-by: Joel Stanley <joel@jms.id.au>

I will send this to the ARM SOC maintainer. Thanks Luc!

Cheers,

Joel
