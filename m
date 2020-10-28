From: Joel Stanley <joel@jms.id.au>
Date: Wed, 28 Oct 2020 05:12:56 +0000
Subject: [PATCH 1/3] Arm: dts: aspeed-g6: Fix the register range of gpio
In-Reply-To: <49ef1445-ddb5-41fb-b9f5-f885a1784e77@www.fastmail.com>
References: <20201012033150.21056-1-billy_tsai@aspeedtech.com>
 <20201012033150.21056-2-billy_tsai@aspeedtech.com>
 <49ef1445-ddb5-41fb-b9f5-f885a1784e77@www.fastmail.com>
Message-ID: <CACPK8Xc-rFMkv6_VVizF0F8uqQQC=rko=P_LhC0CphJH+_VFYA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2020 at 01:05, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Mon, 12 Oct 2020, at 14:01, Billy Tsai wrote:
> > This patch is used to fix the memory range of gpio0
> >
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

I've applied this with:

Fixes: 8dbcb5b709b9 ("ARM: dts: aspeed-g6: Add gpio devices")

Cheers,

Joel
