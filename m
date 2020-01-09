From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 09 Jan 2020 16:34:14 +1030
Subject: =?UTF-8?Q?Re:_[PATCH_v4_11/12]_ARM:_dts:_aspeed:_witherspoon:_Enable_XDM?=
 =?UTF-8?Q?A_Engine?=
In-Reply-To: <1577993276-2184-12-git-send-email-eajames@linux.ibm.com>
References: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
 <1577993276-2184-12-git-send-email-eajames@linux.ibm.com>
Message-ID: <406ac609-129e-4e11-8654-e4a48d8f72f8@www.fastmail.com>
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
>  arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts 
> b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
> index 569dad93e162..1a28b86f00ea 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
> @@ -658,4 +658,9 @@ &video {
>  	memory-region = <&video_engine_memory>;
>  };
>  
> +&xdma {
> +	status = "okay";
> +	memory = <0x9f000000 0x01000000>;

Can you please add a comment about how the memory range was
derived?
