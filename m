From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Thu, 21 Nov 2019 11:08:23 +0100
Subject: [PATCH] aspeed: fix snoop_file_poll()'s return type
In-Reply-To: <CACPK8XfO=F-BtCuDqyQODJv=6joYmyFiQ5eOYC5YuDJhcLSJtw@mail.gmail.com>
References: <20191120000647.30551-1-luc.vanoostenryck@gmail.com>
 <787e54c2-2fe3-4afc-a69b-94771726194b@www.fastmail.com>
 <CACPK8XfO=F-BtCuDqyQODJv=6joYmyFiQ5eOYC5YuDJhcLSJtw@mail.gmail.com>
Message-ID: <20191121100823.2twowr42nsyykvgg@ltop.local>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 21, 2019 at 02:52:39AM +0000, Joel Stanley wrote:
> On Wed, 20 Nov 2019 at 05:42, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Looks fine to me as POLLIN and EPOLLIN evaluate to the same value despite
> > the type difference.
> 
> I assume Luc was using sparse to check:
> 
> CHECK   ../drivers/soc/aspeed/aspeed-lpc-snoop.c
> ../drivers/soc/aspeed/aspeed-lpc-snoop.c:112:19: warning: incorrect
> type in initializer (different base types)
> ../drivers/soc/aspeed/aspeed-lpc-snoop.c:112:19:    expected
> restricted __poll_t ( *poll )( ... )
> ../drivers/soc/aspeed/aspeed-lpc-snoop.c:112:19:    got unsigned int (
> * )( ... )
> 
> If you fix the return type:
> 
>   CHECK   ../drivers/soc/aspeed/aspeed-lpc-snoop.c
> ../drivers/soc/aspeed/aspeed-lpc-snoop.c:106:45: warning: incorrect
> type in return expression (different base types)
> ../drivers/soc/aspeed/aspeed-lpc-snoop.c:106:45:    expected restricted __poll_t
> ../drivers/soc/aspeed/aspeed-lpc-snoop.c:106:45:    got int

Yes, but with the change s/POLLIN/EPOLLIN/ this last warning
is not issued.
 
Cheers,
-- Luc
