From: Rob Herring <robh@kernel.org>
Date: Tue, 15 Oct 2019 17:24:15 -0500
Subject: [PATCH 1/7] dt-bindings: pinctrl: aspeed-g6: Rework SD3 function
 and groups
In-Reply-To: <20191008044153.12734-2-andrew@aj.id.au>
References: <20191008044153.12734-1-andrew@aj.id.au>
 <20191008044153.12734-2-andrew@aj.id.au>
Message-ID: <20191015222415.GA10977@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue,  8 Oct 2019 15:11:47 +1030, Andrew Jeffery wrote:
> Rename SD3 functions and groups to EMMC to better reflect their intended
> use before the binding escapes too far into the wild. Also clean up the
> SD3 pin groups to eliminate some silliness that slipped through the
> cracks (SD3DAT[4-7]) by unifying them into three new groups: EMMCG1,
> EMMCG4 and EMMCG8 for 1, 4 and 8-bit data buses respectively.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> Unfortunately reflowing the list creates a lot of noise in this change. As
> mentioned the SD3DAT[4-7] groups are renamed, as is the SD3 function. There
> should be no functional changes beyond that.
> 
>  .../pinctrl/aspeed,ast2600-pinctrl.yaml       | 86 +++++++++----------
>  1 file changed, 42 insertions(+), 44 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
