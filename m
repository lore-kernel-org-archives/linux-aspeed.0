From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 31 Aug 2019 08:26:30 -0700
Subject: [PATCH v2 1/3] dt-bindings: hwmon: Document ibm,cffps2
 compatible string
In-Reply-To: <1567192263-15065-2-git-send-email-eajames@linux.ibm.com>
References: <1567192263-15065-1-git-send-email-eajames@linux.ibm.com>
 <1567192263-15065-2-git-send-email-eajames@linux.ibm.com>
Message-ID: <20190831152630.GA8907@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Aug 30, 2019 at 02:11:01PM -0500, Eddie James wrote:
> Document the compatible string for version 2 of the IBM CFFPS PSU.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied to hwmon-next. Note that we'll still need review from a DT maintainer.
I don't see any problems, but then who knows.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt b/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
> index f68a0a6..1036f65 100644
> --- a/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
> +++ b/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
> @@ -1,8 +1,10 @@
> -Device-tree bindings for IBM Common Form Factor Power Supply Version 1
> -----------------------------------------------------------------------
> +Device-tree bindings for IBM Common Form Factor Power Supply Versions 1 and 2
> +-----------------------------------------------------------------------------
>  
>  Required properties:
> - - compatible = "ibm,cffps1";
> + - compatible				: Must be one of the following:
> +						"ibm,cffps1"
> +						"ibm,cffps2"
>   - reg = < I2C bus address >;		: Address of the power supply on the
>  					  I2C bus.
>  
