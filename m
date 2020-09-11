From: Joel Stanley <joel@jms.id.au>
Date: Fri, 11 Sep 2020 00:56:53 +0000
Subject: [PATCH v2 11/15] ARM: dts: aspeed: fix PCA95xx GPIO expander
 properties on Portwell
In-Reply-To: <20200910175733.11046-12-krzk@kernel.org>
References: <20200910175733.11046-1-krzk@kernel.org>
 <20200910175733.11046-12-krzk@kernel.org>
Message-ID: <CACPK8Xe8ufYxKA_Xh7D=TgocRFQ7BKFdm_Le-Ob-QxZWm6PZJw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2020 at 17:59, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The PCA95xx GPIO expander requires GPIO controller properties to operate
> properly.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Joel Stanley <joel@jms.id.au>

(This device tree can probably be dropped in the future. I heard these
boards were very hard to come by even a year or so ago, and I doubt
they are still in use.)

> ---
>  arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts b/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
> index 4a1ca8f5b6a7..03c161493ffc 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
> @@ -121,6 +121,8 @@
>         pca9555 at 27 {
>                 compatible = "nxp,pca9555";
>                 reg = <0x27>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
>         };
>  };
>
> --
> 2.17.1
>
