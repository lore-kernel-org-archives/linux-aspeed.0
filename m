From: Vijay Khemka <vijaykhemka@fb.com>
Date: Sat, 12 Jan 2019 00:33:08 +0000
Subject: [Potential Spoof] Re: [Potential Spoof] Re: [PATCH v2 4/4] ARM:
 dts: aspeed: Add lpc ctrl for Facebook
Message-ID: <5972B57A-23D5-43F4-9476-229379B96C7C@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Joel,
Please merge these patches as it is required by facebook platform.

Regards
-Vijay

?On 1/7/19, 11:25 AM, "Linux-aspeed on behalf of Vijay Khemka" <linux-aspeed-bounces+vijaykhemka=fb.com at lists.ozlabs.org on behalf of vijaykhemka@fb.com> wrote:

    Please merge these patches in upstream kernel.
    
    Regards
    -Vijay
    
    On 12/20/18, 10:06 AM, "Linux-aspeed on behalf of Vijay Khemka" <linux-aspeed-bounces+vijaykhemka=fb.com at lists.ozlabs.org on behalf of vijaykhemka@fb.com> wrote:
    
        Joel, Can you please take care of these patches merge.
        
        On 12/17/18, 12:04 PM, "Vijay Khemka" <vijaykhemka@fb.com> wrote:
        
            Added lpc ctrl device to enable LPC clock in Facebook
            Tiogapass device tree.
            
            Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
            ---
             .../boot/dts/aspeed-bmc-facebook-tiogapass.dts  | 17 +++++++++++++++++
             1 file changed, 17 insertions(+)
            
            diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
            index 73e58a821613..ef7875b54562 100644
            --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
            +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
            @@ -22,6 +22,17 @@
             		reg = <0x80000000 0x20000000>;
             	};
             
            +	reserved-memory {
            +		#address-cells = <1>;
            +		#size-cells = <1>;
            +		ranges;
            +
            +		flash_memory: region at 98000000 {
            +			no-map;
            +			reg = <0x98000000 0x00001000>; /* 4K */
            +		};
            +	};
            +
             	iio-hwmon {
             		compatible = "iio-hwmon";
             		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
            @@ -54,6 +65,12 @@
             	};
             };
             
            +&lpc_ctrl {
            +	status = "okay";
            +	memory-region = <&flash_memory>;
            +	flash = <&spi1>;
            +};
            +
             &uart1 {
             	// Host Console
             	status = "okay";
            -- 
            2.17.1
            
            
        
        
    
    

