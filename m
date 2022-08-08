From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 08 Aug 2022 10:00:08 +0930
Subject: [PATCH 1/1] ARM: dts: aspeed-g6: enable more UART controllers
In-Reply-To: <20220805090957.470434-1-j220584470k@gmail.com>
References: <20220805090957.470434-1-j220584470k@gmail.com>
Message-ID: <d52e126e-3dc3-4645-a9f0-2f4e3411010a@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 5 Aug 2022, at 18:39, Ken Chen wrote:
> Setup the configuration of UART6, UART7, UART8, and UART9 in
> aspeed-g6.dtsi.
>
> Signed-off-by: Ken Chen <j220584470k@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 64 +++++++++++++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 8c0de3f27883b..fe7cef6b5e976 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -34,8 +34,12 @@ aliases {
>  		serial2 = &uart3;
>  		serial3 = &uart4;
>  		serial4 = &uart5;
> -		serial5 = &vuart1;
> -		serial6 = &vuart2;
> +		serial5 = &uart6;
> +		serial6 = &uart7;
> +		serial7 = &uart8;
> +		serial8 = &uart9;
> +		serial9 = &vuart1;
> +		serial10 = &vuart2;
>  	};
> 

Have you tested the AST2600 systems in OpenBMC with this patch to see 
if you're not breaking any assumptions made by userspace about serial 
numbering, given the aliases exist?

Andrew
