From: Stefan Schaeckeler (sschaeck) <sschaeck@cisco.com>
Date: Mon, 29 Jul 2019 17:26:10 +0000
Subject: [PATCH 01/17] ARM: dts: aspeed-g5: Move EDAC node to APB
In-Reply-To: <20190726053959.2003-2-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
 <20190726053959.2003-2-andrew@aj.id.au>
Message-ID: <8F0B09F9-A2EA-4A88-BE8A-A8869FCE178A@cisco.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thursday, July 25, 2019 at 10:40 PM, Andrew Jeffery wrote:

> Previously the register interface was not attached to any internal bus,
> which is not correct - it lives on the APB.
>
> Cc: Stefan M Schaeckeler <sschaeck@cisco.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  arch/arm/boot/dts/aspeed-g5.dtsi | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Schaeckeler <sschaeck@cisco.com>


