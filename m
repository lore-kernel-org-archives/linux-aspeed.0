From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 09 Jan 2020 16:34:32 +1030
Subject: [PATCH v4 12/12] ARM: dts: aspeed: tacoma: Enable XDMA engine
In-Reply-To: <1577993276-2184-13-git-send-email-eajames@linux.ibm.com>
References: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
 <1577993276-2184-13-git-send-email-eajames@linux.ibm.com>
Message-ID: <fa16ef12-b301-4a1d-aaf4-ee8fcd0f398e@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 3 Jan 2020, at 05:57, Eddie James wrote:
> Enable the XDMA engine node.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts 
> b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> index f02de4ab058c..2e5cd51db7c2 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> @@ -1193,3 +1193,8 @@ &pinctrl {
>  	pinctrl-0 = <&pinctrl_lpc_default>,
>  		    <&pinctrl_lsirq_default>;
>  };
> +
> +&xdma {
> +	status = "okay";
> +	memory = <0xbf800000 0x00800000>;
> +};

Can you please add a comment about how the memory range was
derived?
