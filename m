From: Joel Stanley <joel@jms.id.au>
Date: Wed, 21 Oct 2020 04:51:17 +0000
Subject: [PATCH 0/2] ARM: dts: Enable ramoops for Rainier and Tacoma
In-Reply-To: <20201016043513.119841-1-andrew@aj.id.au>
References: <20201016043513.119841-1-andrew@aj.id.au>
Message-ID: <CACPK8Xf1=YEApovVOCbE5dkM3uK0Lsx2iXnVK6nK3mx=+q4jpw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2020 at 04:36, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hi,
>
> We're looking to improve our crash data capture for the BMC on some IBM
> platforms. This small series enables ramoops for Rainier and Tacoma.
>
> Please review.

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
> Andrew
>
> Andrew Jeffery (2):
>   ARM: dts: rainier: Add reserved memory for ramoops
>   ARM: dts: tacoma: Add reserved memory for ramoops
>
>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 9 +++++++++
>  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts  | 9 +++++++++
>  2 files changed, 18 insertions(+)
>
> --
> 2.25.1
>
