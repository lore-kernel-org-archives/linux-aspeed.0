From: Vijay Khemka <vijaykhemka@fb.com>
Date: Fri, 14 Sep 2018 18:57:23 +0000
Subject: [PATCH] ARM: dts: aspeed: Adding Facebook TioagaPass BMC
In-Reply-To: <20180913201739.GG23892@lunn.ch>
References: <20180913195751.1833227-1-vijaykhemka@fb.com>
 <20180913201739.GG23892@lunn.ch>
Message-ID: <781180F5-B7E7-44CD-9747-8E2908ACF5E2@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks Andrew,
I have revised patch as I found some more changes. Sent a new version.

Regards
-Vijay

?On 9/13/18, 1:18 PM, "Andrew Lunn" <andrew@lunn.ch> wrote:

    > +++ b/arch/arm/boot/dts/Makefile
    > @@ -1206,4 +1206,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
    >  	aspeed-bmc-opp-witherspoon.dtb \
    >  	aspeed-bmc-opp-zaius.dtb \
    >  	aspeed-bmc-portwell-neptune.dtb \
    > +	aspeed-bmc-facebook-tiogapass.dtb \
    
    Hi Vijay
    
    These entries are normally kept in alphabetic order.
    
    > +	leds {
    > +		compatible = "gpio-leds";
    > +		postcode0 {
    > +			label="BMC_UP";
    
    Documentation/leds/leds-class.txt
    
    LED Device Naming
    =================
    
    Is currently of the form:
    
    "devicename:colour:function"
    
    	Andrew
    

