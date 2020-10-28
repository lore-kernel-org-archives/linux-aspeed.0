From: Joel Stanley <joel@jms.id.au>
Date: Wed, 28 Oct 2020 04:27:36 +0000
Subject: [PATCH 2/2] Arm: dts: aspeed-g6: Add sgpio node and pinctrl
 setting
In-Reply-To: <D35132A5-2676-4806-AF35-9110DF0CC88B@aspeedtech.com>
References: <20201008015106.3198-1-billy_tsai@aspeedtech.com>
 <20201008015106.3198-3-billy_tsai@aspeedtech.com>
 <CACPK8XeKdmvVB_CTND7mSRvtTRz8i+Zw1=E06OP-=r3=pnh9gw@mail.gmail.com>
 <D35132A5-2676-4806-AF35-9110DF0CC88B@aspeedtech.com>
Message-ID: <CACPK8XccGJgd4eNiRyE8D2VphpuONZC4CmiC4tDk0pFYmaTdJA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2020 at 05:25, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>
> Hi Joel,
>
> On 2020/10/8, 11:49 AM, Joel Stanley wrote:
>
>     On Thu, 8 Oct 2020 at 01:51, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>     > >
>     > > This patch is used to add sgpiom and sgpios nodes and add pinctrl setting
>     > > for sgpiom1
>     >
>     > The code looks good Billy.
>     >
>     > Please split the change in two: device tree changes (arch/arm/dts) in
>     > one, and pinctrl in the second, as they go through different
>     > maintainers.
>     >
>
>     If I split the change in two, the patch of dts will have a compiler error.
>     Because that the sgpiom1 node needs the pinctrl symbol "&pinctrl_sgpm2_default".

The drivers/pinctrl/ changes should be split from the
arch/arm/boot/dts/ changes.

You should keep the arch/arm/boot/dts/ changes in the same patch.

Cheers,

Joel
