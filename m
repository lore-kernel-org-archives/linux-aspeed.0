From: Tao Ren <rentao.bupt@gmail.com>
Date: Mon, 16 Nov 2020 17:16:03 -0800
Subject: [PATCH] ARM: dts: aspeed: minipack: Fixup I2C tree
In-Reply-To: <CACPK8Xcpj_LsYOJ=S0p1D5Wqof_2m7SLnPRantQen61B2_XjAA@mail.gmail.com>
References: <20201110072446.8218-1-rentao.bupt@gmail.com>
 <CACPK8Xcpj_LsYOJ=S0p1D5Wqof_2m7SLnPRantQen61B2_XjAA@mail.gmail.com>
Message-ID: <20201117011602.GA28529@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 16, 2020 at 03:33:45AM +0000, Joel Stanley wrote:
> On Tue, 10 Nov 2020 at 07:24, <rentao.bupt@gmail.com> wrote:
> >
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > Create all the i2c switches in device tree and use aliases to assign
> > child channels with consistent bus numbers.
> >
> > Besides, "i2c-mux-idle-disconnect" is set for all the i2c switches to
> > avoid potential conflicts when multiple devices (beind the switches) use
> > the same device address.
> >
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> I will apply for 5.11.

Great. Thank you Joel!


Cheers,

Tao
