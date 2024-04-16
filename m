From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 16 Apr 2024 09:32:30 +0930
Subject: [PATCH v2] ARM: dts: aspeed: Add IBM P11 BMC boards
In-Reply-To: <20240415154931.10775-1-eajames@linux.ibm.com>
References: <20240415154931.10775-1-eajames@linux.ibm.com>
Message-ID: <48ad6bcccae315e68bc0aa10669eed645c495139.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2024-04-15 at 10:49 -0500, Eddie James wrote:
> Add the Blueridge and Fuji BMC systems.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> Changes since v1:
>  - Change "ody" to "odyssey"
> 
>  arch/arm/boot/dts/aspeed/Makefile             |    2 +
>  .../dts/aspeed/aspeed-bmc-ibm-blueridge.dts   | 1752 +++++++
>  .../boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts   | 4016 +++++++++++++++++
>  .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 1704 +++++++
>  4 files changed, 7474 insertions(+)

A few points:

- Altogether this patch is pretty large. Can we do one for each of the
FSI topology and the platforms?

- The only list to which you've sent the patch is linux-aspeed, which
doesn't appear to be archived on lore. Can you please add at least one
that is? There are a few that should probably be included regardless.

- I don't plan to merge the patch until it has had review from ideally
more than one other IBMer

On the review front:

It looks like you still need to update
Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml with the new
platform compatible strings.

Also, can you please run?

```
make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-{blueridge,fuji}.dtb
```

and address the warnings? This is best done by first applying the patch
on top of my tree below. It goes some way to eliminating many of the
warnings currently produced for the Aspeed BMC SoCs:

https://github.com/amboar/linux/tree/dt-warnings/all

Andrew
