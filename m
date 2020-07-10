From: Joel Stanley <joel@jms.id.au>
Date: Fri, 10 Jul 2020 03:04:03 +0000
Subject: [PATCH 2/2] mmc: sdhci-of-aspeed: Fix clock divider calculation
In-Reply-To: <4acad452-33c7-4fb2-ba90-19a824558b94@www.fastmail.com>
References: <20200709195706.12741-1-eajames@linux.ibm.com>
 <20200709195706.12741-3-eajames@linux.ibm.com>
 <4acad452-33c7-4fb2-ba90-19a824558b94@www.fastmail.com>
Message-ID: <CACPK8XcWEn-M291U1va7T=5R0qHp3D0hy53-fkEw7pa_iQu6tA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 10 Jul 2020 at 01:14, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Fri, 10 Jul 2020, at 05:27, Eddie James wrote:
> > When calculating the clock divider, start dividing at 2 instead of 1.
> > The divider is divided by two at the end of the calculation, so starting
> > at 1 may result in a divider of 0, which shouldn't happen.
> >
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Acked-by: Joel Stanley <joel@jms.id.au>
Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")

Stephen, I think this should go to stable too along with 1/2.

Cheers,

Joel
