From: Joel Stanley <joel@jms.id.au>
Date: Tue, 27 Mar 2018 17:22:58 +1030
Subject: [PATCH v2 0/4] serial: implement flow control for ASPEED VUART
 driver
In-Reply-To: <20180327034827.20773-1-jk@ozlabs.org>
References: <20180323155116.GA31423@kroah.com>
 <20180327034827.20773-1-jk@ozlabs.org>
Message-ID: <CACPK8Xfn_nh_d_7avCADsD6gpEky_RZAt_kROJAPF=hVthX_JQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 27 March 2018 at 14:18, Jeremy Kerr <jk@ozlabs.org> wrote:
> --
> v2:
>  - rebase onto tty-next, dropping applied proc patch
>  - 1/4 simplify status mask checks
>  - 4/4 Use updated timer API, fix text wrap
>
>
> Jeremy Kerr (4):
>   serial: Introduce UPSTAT_SYNC_FIFO for synchronised FIFOs
>   serial/8250: export serial8250_read_char
>   serial/aspeed-vuart: Implement rx throttling
>   serial/aspeed-vuart: Implement quick throttle mechanism

I gave v2 a spin on top of 4.16:

Tested-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel


>
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 124 ++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c         |   3 +-
>  drivers/tty/serial/serial_core.c            |   4 +-
>  include/linux/serial_8250.h                 |   1 +
>  include/linux/serial_core.h                 |   1 +
>  5 files changed, 130 insertions(+), 3 deletions(-)
>
> --
> 2.14.1
>
