From: Stefan Schaeckeler (sschaeck) <sschaeck@cisco.com>
Date: Mon, 29 Jul 2019 17:29:01 +0000
Subject: [PATCH 02/17] ARM: dts: aspeed-g5: Use recommended generic node
 name for SDMC
In-Reply-To: <20190726053959.2003-3-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
 <20190726053959.2003-3-andrew@aj.id.au>
Message-ID: <EF113919-7590-442F-A1EE-12143FA4D960@cisco.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thursday, July 25, 2019 at 10:40 PM, Andrew Jeffery wrote:

> The EDAC is a sub-function of the SDRAM Memory Controller. Rename the
> node to the appropriate generic node name.
>
> Cc: Stefan M Schaeckeler <sschaeck@cisco.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  arch/arm/boot/dts/aspeed-g5.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
    
Reviewed-by: Stefan Schaeckeler <sschaeck@cisco.com>    

