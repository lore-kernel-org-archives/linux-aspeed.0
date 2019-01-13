From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 14 Jan 2019 09:09:40 +1030
Subject: [Potential Spoof] Re: [Potential Spoof] Re: [PATCH v2 4/4] ARM:
 dts: aspeed: Add lpc ctrl for Facebook
In-Reply-To: <5972B57A-23D5-43F4-9476-229379B96C7C@fb.com>
References: <5972B57A-23D5-43F4-9476-229379B96C7C@fb.com>
Message-ID: <1547419180.2315773.1633559160.3F7D29CF@webmail.messagingengine.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Vijay,

Sorry for providing an opinion so late, however:

On Sat, 12 Jan 2019, at 11:03, Vijay Khemka wrote:
> Joel,
> Please merge these patches as it is required by facebook platform.
> 
> Regards
> -Vijay
> 
> ?On 1/7/19, 11:25 AM, "Linux-aspeed on behalf of Vijay Khemka" <linux-
> aspeed-bounces+vijaykhemka=fb.com at lists.ozlabs.org on behalf of 
> vijaykhemka at fb.com> wrote:
> 
>     Please merge these patches in upstream kernel.
>     
>     Regards
>     -Vijay
>     
>     On 12/20/18, 10:06 AM, "Linux-aspeed on behalf of Vijay Khemka" 
> <linux-aspeed-bounces+vijaykhemka=fb.com@lists.ozlabs.org on behalf of 
> vijaykhemka at fb.com> wrote:
>     
>         Joel, Can you please take care of these patches merge.
>         
>         On 12/17/18, 12:04 PM, "Vijay Khemka" <vijaykhemka@fb.com> wrote:
>         
>             Added lpc ctrl device to enable LPC clock in Facebook
>             Tiogapass device tree.
>             
>             Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
>             ---
>              .../boot/dts/aspeed-bmc-facebook-tiogapass.dts  | 17 ++++++
> +++++++++++
>              1 file changed, 17 insertions(+)
>             
>             diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-
> tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
>             index 73e58a821613..ef7875b54562 100644
>             --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
>             +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
>             @@ -22,6 +22,17 @@
>              		reg = <0x80000000 0x20000000>;
>              	};
>              
>             +	reserved-memory {
>             +		#address-cells = <1>;
>             +		#size-cells = <1>;
>             +		ranges;
>             +
>             +		flash_memory: region at 98000000 {
>             +			no-map;
>             +			reg = <0x98000000 0x00001000>; /* 4K */
>             +		};
>             +	};
>             +
>              	iio-hwmon {
>              		compatible = "iio-hwmon";
>              		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
>             @@ -54,6 +65,12 @@
>              	};
>              };
>              
>             +&lpc_ctrl {
>             +	status = "okay";
>             +	memory-region = <&flash_memory>;
>             +	flash = <&spi1>;
>             +};
>             +
>              &uart1 {
>              	// Host Console
>              	status = "okay";
>             -- 
>             2.17.1

I understand you just want to make your system work, but this is a
broken way to do it. And that's not your fault - we should really fix
the driver. I think the memory-region phandle should be optional
and the driver should simply limit the options available to the ioctl
to just the flash region if the memory node is not present (i.e. return
an error if the memory region is requested but not described in the
devicetree).

Andrew
